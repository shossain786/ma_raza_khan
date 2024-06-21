// ignore_for_file: use_build_context_synchronously

import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ma_raza_khan/widgets/my_scaffold_msg.dart' as sc;
import 'package:ma_raza_khan/widgets/project_constants.dart';

class CreateClassScreen extends StatefulWidget {
  const CreateClassScreen({super.key});

  @override
  State<CreateClassScreen> createState() => _CreateClassScreenState();
}

class _CreateClassScreenState extends State<CreateClassScreen> {
  final _formKey = GlobalKey<FormState>();
  final _classNameController = TextEditingController();
  final _subjectNameController = TextEditingController();
  late String classRoomId;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  @override
  void dispose() {
    _classNameController.dispose();
    _subjectNameController.dispose();
    super.dispose();
  }

  Future<void> _createClassroom() async {
    String className = _classNameController.text.trim();
    String subject = _subjectNameController.text.trim();
    classRoomId = generateRandomClassroomId();
    if (className.isNotEmpty) {
      debugPrint('Class Name: $className');
      debugPrint('Subject Name: $subject');

      await _firebaseFirestore.collection("classes").doc().set(
          {"className": className, "subject": subject, "classId": classRoomId});

      sc.showSuccessMessage(context,
          'Class room created sussessfully! Classroom id: $classRoomId');

      _classNameController.clear();
      _subjectNameController.clear();
    } else {
      sc.showUnSuccessMessage(
          context, 'Class not created. Please virify entered details');
    }
  }

  String generateRandomClassroomId() {
    Random random = Random();
    int min = 10000000;
    int max = 99999999;
    int randomNumber = min + random.nextInt(max - min + 1);
    return randomNumber.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Classroom'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Class Name',
                  border: OutlineInputBorder(),
                ),
                controller: _classNameController,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter a class name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Subject Name',
                  border: OutlineInputBorder(),
                ),
                controller: _subjectNameController,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter subject name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                height: 40,
                child: ElevatedButton(
                  onPressed: _createClassroom,
                  style: ElevatedButton.styleFrom(
                    foregroundColor: btnForeGroundColor,
                    backgroundColor: saveBtnBackGrndColor,
                  ),
                  child: const Text(
                    'Save Class',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
