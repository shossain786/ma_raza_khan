import 'package:flutter/material.dart';
import 'package:ma_raza_khan/project_constants.dart';

class CreateClassScreen extends StatefulWidget {
  const CreateClassScreen({super.key});

  @override
  State<CreateClassScreen> createState() => _CreateClassScreenState();
}

class _CreateClassScreenState extends State<CreateClassScreen> {
  final _formKey = GlobalKey<FormState>();
  final _classNameController = TextEditingController();
  final _subjectNameController = TextEditingController();

  @override
  void dispose() {
    _classNameController.dispose();
    _subjectNameController.dispose();
    super.dispose();
  }

  void _createClassroom() {
    debugPrint(
      'Data received: ${_classNameController.text} and ${_subjectNameController.text}',
    );
    String className = _classNameController.text.trim();
    String subject = _subjectNameController.text.trim();
    if (className.isNotEmpty) {
      debugPrint('Class Name: $className');
      debugPrint('Subject Name: $subject');

      _classNameController.clear();
      _subjectNameController.clear();
    }
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
