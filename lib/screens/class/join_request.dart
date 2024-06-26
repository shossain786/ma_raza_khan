// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ma_raza_khan/screens/login_screen.dart';
import 'package:ma_raza_khan/widgets/my_scaffold_msg.dart';

class JoinClassScreen extends StatefulWidget {
  const JoinClassScreen({super.key});

  @override
  _JoinClassScreenState createState() => _JoinClassScreenState();
}

class _JoinClassScreenState extends State<JoinClassScreen> {
  final TextEditingController _classIdController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> _sendJoinRequest() async {
    if (_classIdController.text.isNotEmpty) {
      try {
        await _firestore.collection('join_requests').add({
          'classId': _classIdController.text,
          'name': loggedInUserFullName,
          'timestamp': FieldValue.serverTimestamp(),
          'email': loggedInUserEmail,
        });
        showSuccessMessage(context, 'Join request sent successfully');
      } catch (e) {
        showUnSuccessMessage(context, 'Failed to send join request: $e');
      }
    } else {
      showUnSuccessMessage(context, 'Please enter both class ID');
    }
    _classIdController.clear();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Join Class')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _classIdController,
              decoration: const InputDecoration(labelText: 'Classroom ID'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _sendJoinRequest,
              child: const Text('Send Join Request'),
            ),
          ],
        ),
      ),
    );
  }
}
