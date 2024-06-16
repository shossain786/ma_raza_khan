import 'package:flutter/material.dart';

Drawer myAppDrawer() {
  return Drawer(
    child: ListView(
      children: [
        const UserAccountsDrawerHeader(
          accountName: Text('Saddam Hossain'),
          accountEmail: Text('sddmhossain786@gmail.com'),
          currentAccountPicture: CircleAvatar(
            child: Icon(Icons.mosque),
          ),
        ),
        ListTile(
          leading: const Icon(Icons.home),
          title: const Text('Home'),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(Icons.info),
          title: const Text('Profile'),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(Icons.person),
          title: const Text('Students/Co-Teachers'),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(Icons.settings),
          title: const Text('Settings'),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(Icons.contact_support),
          title: const Text('About US'),
          onTap: () {},
        ),
      ],
    ),
  );
}
