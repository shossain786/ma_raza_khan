import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ma_raza_khan/screens/class/join_request.dart';
import 'package:ma_raza_khan/screens/login_screen.dart';
import '../widgets/my_appdrawer.dart';
import 'class_room.dart';
import 'create_classroom.dart';

class HomeScreen extends StatelessWidget {
  final String fullName;
  final String emailId;
  final String userId;

  HomeScreen({
    super.key,
    required this.fullName,
    required this.emailId,
    required this.userId,
  });

  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Dashboard'),
          actions: [
            IconButton(
              icon: const Icon(Icons.help),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.notifications),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.chat_bubble),
              onPressed: () {},
            ),
          ],
        ),
        drawer: const AppDrawer(),
        body: Column(
          children: [
            Container(
              color: const Color.fromARGB(255, 1, 96, 144),
              width: double.infinity,
              height: 120,
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
              child: const Card.outlined(
                color: Color.fromARGB(116, 2, 78, 74),
                borderOnForeground: true,
                margin: EdgeInsets.all(4.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'No Scheduled Class Available',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Your Classes',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.calendar_month),
                      ),
                      IconButton(
                        onPressed: () {
                          if (loggedInUserType == 'Student') {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const JoinClassScreen(),
                              ),
                            );
                          } else {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const CreateClassScreen(),
                              ),
                            );
                          }
                        },
                        icon: const Icon(Icons.add),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: StreamBuilder<DocumentSnapshot>(
                stream: _firebaseFirestore
                    .collection('users')
                    .doc(userId)
                    .snapshots(),
                builder: (context, userSnapshot) {
                  if (userSnapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (userSnapshot.hasError) {
                    return const Center(child: Text('Error loading user data'));
                  }

                  if (!userSnapshot.hasData || !userSnapshot.data!.exists) {
                    return const Center(child: Text('No user data available'));
                  }

                  var userData =
                      userSnapshot.data!.data() as Map<String, dynamic>;

                  Stream<QuerySnapshot> classStream;

                  if (loggedInUserType == 'Student') {
                    debugPrint('Student ID: $userId');
                    var classIds = List<String>.from(userData['classes'] ?? []);
                    classStream = _firebaseFirestore
                        .collection('classes')
                        .where(FieldPath.documentId,
                            whereIn:
                                classIds.isNotEmpty ? classIds : ['dummyId'])
                        .snapshots();
                  } else {
                    classStream = _firebaseFirestore
                        .collection('classes')
                        .where('createdBy', isEqualTo: userId)
                        .snapshots();
                  }

                  return StreamBuilder<QuerySnapshot>(
                    stream: classStream,
                    builder: (context, classSnapshot) {
                      if (classSnapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (classSnapshot.hasError) {
                        return const Center(
                            child: Text('Error loading classrooms'));
                      }

                      if (!classSnapshot.hasData ||
                          classSnapshot.data!.docs.isEmpty) {
                        return const Center(
                            child: Text('No classrooms available'));
                      }

                      return ListView(
                        children: classSnapshot.data!.docs.map((doc) {
                          var data = doc.data() as Map<String, dynamic>;
                          var classId = doc.id;
                          return ClassroomCard(
                            classId: classId,
                            title: data['className'] ?? 'No Title',
                            subtitle: data['subject'] ?? 'No Subject',
                            teacherName: data['teacherName'] ?? 'No Teacher',
                            schedule: 'N/A',
                            students: (data['students'] as List).length,
                          );
                        }).toList(),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ClassroomCard extends StatelessWidget {
  final String classId;
  final String title;
  final String subtitle;
  final String teacherName;
  final String schedule;
  final int students;

  const ClassroomCard({
    super.key,
    required this.classId,
    required this.title,
    required this.subtitle,
    required this.teacherName,
    required this.schedule,
    required this.students,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: ListTile(
        title: Text(title),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(subtitle),
            const SizedBox(height: 4),
            Text('Teacher: $teacherName'),
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(Icons.calendar_month, size: 14),
                const SizedBox(width: 4),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(schedule),
                      const SizedBox(),
                      Text(
                        '$students Students',
                        style: const TextStyle(color: Colors.orange),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
        trailing: const Icon(
          Icons.arrow_right_alt,
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  ClassroomScreen(classId: classId, className: title),
            ),
          );
        },
      ),
    );
  }
}
