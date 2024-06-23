// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ApproveRequestsScreen extends StatefulWidget {
  final String classId;

  const ApproveRequestsScreen({super.key, required this.classId});

  @override
  _ApproveRequestsScreenState createState() => _ApproveRequestsScreenState();
}

class _ApproveRequestsScreenState extends State<ApproveRequestsScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> _approveRequest(
      String requestId, String studentName, String email) async {
    try {
      // Update the class document
      await _firestore.collection('classes').doc(widget.classId).update({
        'students': FieldValue.arrayUnion([
          {'name': studentName, 'email': email}
        ]),
      });

      // Find the user document by email and update it
      var userSnapshot = await _firestore
          .collection('users')
          .where('email', isEqualTo: email)
          .limit(1)
          .get();

      if (userSnapshot.docs.isNotEmpty) {
        var userDoc = userSnapshot.docs.first;
        await _firestore.collection('users').doc(userDoc.id).update({
          'classes': FieldValue.arrayUnion([widget.classId]),
        });
      }

      await _firestore.collection('join_requests').doc(requestId).delete();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to approve request: $e')),
      );
    }
  }

  Future<void> _declineRequest(String requestId) async {
    try {
      await _firestore.collection('join_requests').doc(requestId).delete();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to decline request: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Approve Join Requests')),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore
            .collection('join_requests')
            .where('classId', isEqualTo: widget.classId)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
                child: Text('Error loading requests: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No join requests'));
          }

          return ListView(
            children: snapshot.data!.docs.map((doc) {
              var data = doc.data() as Map<String, dynamic>;
              var requestId = doc.id;
              var studentName = data['name'] ?? 'No Name';
              var studentEmail = data['email'] ?? 'No email';
              return ListTile(
                title: Text(studentName),
                subtitle: Text(studentEmail),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.check),
                      onPressed: () =>
                          _approveRequest(requestId, studentName, studentEmail),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => _declineRequest(requestId),
                    ),
                  ],
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
