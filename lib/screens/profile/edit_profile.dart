import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ma_raza_khan/screens/login_screen.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _fullNameController;
  late TextEditingController _emailController;
  late TextEditingController _contactNumberController;
  late TextEditingController _designationController;

  @override
  void initState() {
    super.initState();

    // Initialize the controllers with empty values
    _fullNameController = TextEditingController();
    _emailController = TextEditingController();
    _contactNumberController = TextEditingController();
    _designationController = TextEditingController();

    loadData();
  }

  Future<void> loadData() async {
    DocumentSnapshot document = await FirebaseFirestore.instance
        .collection('users')
        .doc(loggedInUserID)
        .get();

    var userData = document.data() as Map<String, dynamic>?;

    if (userData != null) {
      _fullNameController.text = userData['full_name'] ?? '';
      _emailController.text = userData['email'] ?? '';
      _contactNumberController.text = userData['contact_number'] ?? '';
      _designationController.text = userData['designation'] ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Profile')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<void>(
          future: loadData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            return Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _fullNameController,
                    decoration: const InputDecoration(labelText: 'Full Name'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your full name';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(labelText: 'Email'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _contactNumberController,
                    decoration:
                        const InputDecoration(labelText: 'Contact Number'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your contact number';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _designationController,
                    decoration: const InputDecoration(labelText: 'Designation'),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        await FirebaseFirestore.instance
                            .collection('users')
                            .doc(loggedInUserID)
                            .update({
                          'full_name': _fullNameController.text,
                          'email': _emailController.text,
                          'contact_number': _contactNumberController.text,
                          'designation': _designationController.text,
                        });
                        loggedInUserDesignation = _designationController.text;
                        if (mounted) {
                          Navigator.pop(context);
                          Navigator.pop(context);
                        }
                      }
                    },
                    child: const Text('Save'),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
