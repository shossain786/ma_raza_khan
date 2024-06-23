// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously, unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ma_raza_khan/screens/home_screen.dart';
import 'package:ma_raza_khan/screens/sign_up.dart';
import 'package:ma_raza_khan/widgets/my_scaffold_msg.dart';

late String loggedInUserType;
late String loggedInUserFullName;
late String loggedInUserEmail;
late String loggedInUserID;
late String loggedInUserDesignation;

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _selectedRole = 'Student';
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> _login() async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _usernameController.text,
        password: _passwordController.text,
      );
      // Check the role (you should have a way to check the role, maybe from Firestore)
      DocumentSnapshot userDoc = await _firestore
          .collection('users')
          .doc(userCredential.user?.uid)
          .get();
      String fullName = userDoc['full_name'];
      String email = userDoc['email'];
      String userRole = userDoc['role'];

      if (userRole == _selectedRole) {
        debugPrint("Logged in as $_selectedRole");
        loggedInUserType = userRole;
        loggedInUserEmail = email;
        loggedInUserID = userCredential.user!.uid;
        try {
          loggedInUserDesignation = userDoc['designation'] ?? 'No designation';
        } catch (e) {
          loggedInUserDesignation = 'Student';
        }

        loggedInUserFullName = fullName;

        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => HomeScreen(emailId: email, fullName: fullName)),
        );
      } else {
        showUnSuccessMessage(
            context, 'You do not have access as role: $_selectedRole');
        await _auth.signOut();
      }
    } on FirebaseAuthException catch (error) {
      showUnSuccessMessage(context, error.email ?? 'Authentication failed!!');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(height: 50),
                  const Text(
                    'MA RAZA KHAN',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'LOGIN',
                    style: TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _usernameController,
                    decoration: const InputDecoration(
                      labelText: 'Username',
                      hintText: 'hamid@email.com',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _passwordController,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(),
                    ),
                    obscureText: true,
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Radio<String>(
                        value: 'Student',
                        groupValue: _selectedRole,
                        onChanged: (String? value) {
                          setState(() {
                            _selectedRole = value!;
                          });
                        },
                      ),
                      const Text('Student'),
                      Radio<String>(
                        value: 'Teacher',
                        groupValue: _selectedRole,
                        onChanged: (String? value) {
                          setState(() {
                            _selectedRole = value!;
                          });
                        },
                      ),
                      const Text('Teacher'),
                    ],
                  ),
                  const SizedBox(height: 10),
                  TextButton(
                    onPressed: () {
                      debugPrint('Pressed on forgot password');
                    },
                    child: const Text('Forgot your password?'),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      debugPrint('Pressed on Login Button');
                      _login();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    child: const Text('LOGIN'),
                  ),
                  const SizedBox(height: 10),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const SignUpScreen(),
                        ),
                      );
                    },
                    child: const Text('Don\'t have an account? Sign up'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
