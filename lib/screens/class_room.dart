import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ma_raza_khan/screens/login_screen.dart';
import 'package:ma_raza_khan/widgets/class_top_items.dart';

import '../widgets/project_constants.dart' as pc;

class ClassroomScreen extends StatefulWidget {
  final String classId;
  final String className;
  const ClassroomScreen({
    super.key,
    required this.classId,
    required this.className,
  });

  @override
  State<ClassroomScreen> createState() => _ClassroomScreenState();
}

class _ClassroomScreenState extends State<ClassroomScreen> {
  late int studentCount;
  bool topicDone = false;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    studentCount = 31;
    super.initState();
  }

  Future<void> _editClassroom() async {}

  Future<void> _deleteClassroom() async {
    await _firestore.collection('classes').doc(widget.classId).delete();
    if (mounted) {
      Navigator.pop(context);
    }
  }

  Future<void> _archiveClassroom() async {}

  Future<void> _classroomSettings() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.className),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              switch (value) {
                case 'edit':
                  _editClassroom();
                  break;
                case 'delete':
                  _deleteClassroom();
                  break;
                case 'archive':
                  _archiveClassroom();
                  break;
                case 'settings':
                  _classroomSettings();
                  break;
              }
            },
            itemBuilder: (context) {
              return [
                const PopupMenuItem(
                  value: 'edit',
                  child: Row(
                    children: [
                      Icon(Icons.edit_rounded),
                      Text('Edit Classroom'),
                    ],
                  ),
                ),
                const PopupMenuItem(
                    value: 'archive',
                    child: Row(
                      children: [
                        Icon(Icons.archive_rounded),
                        Text('Archive Classroom'),
                      ],
                    )),
                const PopupMenuItem(
                    value: 'settings',
                    child: Row(
                      children: [
                        Icon(Icons.settings_rounded),
                        Text('Settings'),
                      ],
                    )),
                const PopupMenuItem(
                    value: 'delete',
                    child: Row(
                      children: [
                        Icon(Icons.delete_rounded),
                        Text('Delete Classroom'),
                      ],
                    )),
              ];
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.elliptical(30, 30),
                    bottomRight: Radius.elliptical(30, 30),
                  ),
                  color: pc.classRoomIteamsBackgroundColor,
                ),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(left: 6, right: 6),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.blueGrey,
                      ),
                      child: Row(
                        children: [
                          const CircleAvatar(
                            backgroundColor: Colors.red,
                            child: Text('M',
                                style: TextStyle(color: Colors.white)),
                          ),
                          const SizedBox(width: 2),
                          const CircleAvatar(
                            backgroundColor: Colors.orange,
                            child: Text('S',
                                style: TextStyle(color: Colors.white)),
                          ),
                          const SizedBox(width: 2),
                          CircleAvatar(
                            backgroundColor: Colors.blue,
                            child: Text(
                              '+$studentCount',
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                          const Spacer(),
                          TextButton(
                            onPressed: () {},
                            child: const Text(
                              '+ Invite',
                              style: TextStyle(color: Colors.lightBlueAccent),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    myClassRoomGridItems(),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'About Me',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.person,
                          color: Colors.blue,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          loggedInUserFullName,
                          style: const TextStyle(
                              fontSize: 20,
                              color: Color.fromARGB(255, 63, 31, 69),
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.info_rounded,
                          color: Colors.deepOrange,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          loggedInUserType,
                          style: const TextStyle(
                              fontSize: 14, color: Colors.deepOrange),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.info_outline,
                          color: Colors.blue,
                        ),
                        const SizedBox(width: 8),
                        Text(loggedInUserDesignation)
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
          DraggableScrollableSheet(
            initialChildSize: 0.4,
            minChildSize: 0.4,
            maxChildSize: 0.8,
            builder: (BuildContext context, ScrollController scrollController) {
              return Container(
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                    gradient: LinearGradient(
                      colors: [
                        Color.fromARGB(255, 47, 159, 187),
                        Color.fromARGB(169, 172, 88, 88),
                        Color.fromARGB(115, 136, 91, 91),
                      ],
                    )),
                child: ListView.builder(
                  controller: scrollController,
                  itemCount: 25,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      iconColor: const Color.fromARGB(255, 6, 83, 146),
                      selectedTileColor: Colors.amber,
                      title: Text('Item $index'),
                      leading: IconButton(
                        onPressed: () {
                          setState(() {
                            topicDone = !topicDone;
                          });
                        },
                        icon: topicDone
                            ? const Icon(Icons.check_box)
                            : const Icon(Icons.check_box_outline_blank_rounded),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: const Text('Go Live'),
        icon: const Icon(Icons.live_tv),
        backgroundColor: Colors.orange,
      ),
    );
  }
}
