// ignore_for_file: library_private_types_in_public_api

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

  Future<void> _approveRequest(String requestId, String studentName) async {
    await _firestore.collection('classes').doc(widget.classId).update({
      'students': FieldValue.arrayUnion([studentName]),
    });
    await _firestore.collection('join_requests').doc(requestId).delete();
  }

  Future<void> _declineRequest(String requestId) async {
    await _firestore.collection('join_requests').doc(requestId).delete();
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
            return const Center(child: Text('Error loading requests'));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No join requests'));
          }

          return ListView(
            children: snapshot.data!.docs.map((doc) {
              var data = doc.data() as Map<String, dynamic>;
              var requestId = doc.id;
              var studentName = data['name'] ?? 'No Name';
              return ListTile(
                title: Text(studentName),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.check),
                      onPressed: () => _approveRequest(requestId, studentName),
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
