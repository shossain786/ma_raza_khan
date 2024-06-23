// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ma_raza_khan/screens/profile/user_profile.dart';
import 'package:ma_raza_khan/widgets/project_constants.dart';
import '../screens/login_screen.dart';

class AppDrawer extends StatelessWidget {
  final String fullName;
  final String email;
  const AppDrawer({super.key, required this.fullName, required this.email});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(
              fullName,
              style: const TextStyle(fontSize: 20),
            ),
            accountEmail: Text(
              email,
              style: const TextStyle(fontSize: 14),
            ),
            currentAccountPicture: const CircleAvatar(
              child: Icon(Icons.mosque),
            ),
            decoration: BoxDecoration(
              color: welcomeScreen2BGColor,
            ),
          ),
          ListTileTheme(
              iconColor: bottomSheetBGColor,
              textColor: bottomSheetBGColor,
              selectedColor: drawerOnSelectedColor,
              tileColor: drawerOnSelectedColor,
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.home),
                    title: const Text('Home'),
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.info),
                    title: const Text('Profile'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ProfileScreen(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.person),
                    title: const Text('Students/Co-Teachers'),
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                    // child: Divider(height: 1, color: drawerDividerColor),
                  ),
                  ListTile(
                    leading: const Icon(Icons.settings),
                    title: const Text('Settings'),
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.contact_support),
                    title: const Text('About US'),
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.logout),
                    title: const Text('Logout'),
                    onTap: () async {
                      await FirebaseAuth.instance.signOut();
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                            builder: (context) => const LoginScreen()),
                      );
                    },
                  )
                ],
              )),
        ],
      ),
    );
  }
}
