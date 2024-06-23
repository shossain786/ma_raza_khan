import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ma_raza_khan/screens/login_screen.dart';

import '../../widgets/project_constants.dart';
import 'edit_profile.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const EditProfileScreen(),
                ),
              );
            },
            icon: const Icon(Icons.edit_rounded),
          )
        ],
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance
            .collection('users')
            .doc(loggedInUserID)
            .get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData) {
            return const Center(child: Text('No data found'));
          }

          var userData = snapshot.data!.data() as Map<String, dynamic>;

          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                MyContainer().menuContainer('Name:', userData['full_name']),
                const Divider(),
                MyContainer().menuContainer('Email:', userData['email']),
                const Divider(),
                MyContainer().menuContainer(
                    'Contact Number:', userData['contact_number']),
                const Divider(),
                userData['designation'] != null
                    ? MyContainer()
                        .menuContainer('Designation:', userData['designation'])
                    : Container(),
                const SizedBox(height: 20),
              ],
            ),
          );
        },
      ),
    );
  }
}

class MyContainer {
  Container menuContainer(String title, String name) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: drawerOnSelectedColor,
          border: Border.all(width: 1, color: welcomeScreen1BGColor),
          gradient: const LinearGradient(colors: [
            Color.fromARGB(255, 113, 185, 244),
            Color.fromARGB(255, 183, 216, 245),
            Color.fromARGB(255, 125, 192, 247)
          ]),
          boxShadow: const [
            BoxShadow(
              color: Colors.blue,
            ),
            BoxShadow(
              color: Colors.red,
            ),
          ]),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                name,
                softWrap: true,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
