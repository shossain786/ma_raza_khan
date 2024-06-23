// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ma_raza_khan/screens/login_screen.dart';
import 'home_screen.dart'; // Ensure you import the HomeScreen if you want to navigate back after creating a class

class CreateClassScreen extends StatefulWidget {
  const CreateClassScreen({super.key});

  @override
  State<CreateClassScreen> createState() => _CreateClassScreenState();
}

class _CreateClassScreenState extends State<CreateClassScreen> {
  final TextEditingController _classNameController = TextEditingController();
  final TextEditingController _subjectController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Classroom'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _classNameController,
              decoration: const InputDecoration(labelText: 'Class Name'),
            ),
            TextField(
              controller: _subjectController,
              decoration: const InputDecoration(labelText: 'Subject'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _createClassroom,
              child: const Text('Create Classroom'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _createClassroom() async {
    if (_classNameController.text.isEmpty || _subjectController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields')),
      );
      return;
    }

    String userId = loggedInUserID;
    String teacherName = loggedInUserFullName;
    String emailId = loggedInUserEmail; // Assuming this is available

    await _firestore.collection('classes').add({
      'className': _classNameController.text,
      'subject': _subjectController.text,
      'createdBy': userId,
      'teachers': [
        {'name': teacherName, 'email': emailId}
      ],
      'students': [],
      'joinRequests': [],
    });

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HomeScreen(
          fullName: teacherName,
          emailId: emailId,
          userId: userId,
        ),
      ),
    );
  }
}
