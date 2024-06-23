// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ma_raza_khan/screens/login_screen.dart';
import 'package:ma_raza_khan/widgets/class_top_items.dart';
import 'package:share_plus/share_plus.dart';

import '../widgets/project_constants.dart' as pc;
import 'class/approve_request.dart';

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
  bool isStudent = loggedInUserType == 'Student' ? true : false;
  late String teacherDesignation = '';
  late String teacherName = '';

  @override
  void initState() {
    studentCount = 31;
    _fetchTeacherDetails();
    super.initState();
  }

  Future<void> _fetchTeacherDetails() async {
    try {
      var querySnapshot = await FirebaseFirestore.instance
          .collection('classes')
          .doc(widget.classId)
          .get();
      var teacherEmail = querySnapshot.data()?['teachers'][0]['email'];
      var teacherQuerySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: teacherEmail)
          .get();
      if (teacherQuerySnapshot.docs.isNotEmpty) {
        var teacherData = teacherQuerySnapshot.docs.first.data();
        setState(() {
          teacherName = teacherData['full_name'];
          teacherDesignation = teacherData['designation'];
        });
      }
    } catch (e) {
      debugPrint('Error fetching teacher details: $e');
    }
  }

  Future<void> _shareClassroomId() async {
    final classId = widget.classId;
    final message = 'Join my class with this ID: $classId';
    Share.share(message);
  }

  Future<void> _copyClassroomIdToClipboard() async {
    final classId = widget.classId;
    await Clipboard.setData(ClipboardData(text: classId));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Classroom ID copied to clipboard')),
    );
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
          Visibility(
            visible: !isStudent,
            child: PopupMenuButton<String>(
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
                        color: const Color.fromARGB(255, 156, 190, 206),
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
                          IconButton(
                            highlightColor: Colors.white,
                            icon: const Icon(
                              Icons.copy_rounded,
                              color: Color.fromARGB(255, 2, 37, 65),
                            ),
                            onPressed: _copyClassroomIdToClipboard,
                          ),
                          TextButton(
                            onPressed: () {},
                            child: IconButton(
                              onPressed: _shareClassroomId,
                              highlightColor: Colors.white,
                              icon: const Icon(
                                Icons.add_circle,
                                color: Color.fromARGB(255, 2, 37, 65),
                              ),
                            ),
                          ),
                          loggedInUserType == 'Teacher'
                              ? IconButton(
                                  highlightColor: Colors.white,
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            ApproveRequestsScreen(
                                                classId: widget.classId),
                                      ),
                                    );
                                  },
                                  icon: const Icon(
                                    Icons.check_circle_outline,
                                    color: Color.fromARGB(255, 47, 102, 49),
                                  ),
                                )
                              : const Text(''),
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
                    'About Teacher',
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
                          teacherName,
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
                          Icons.info_outline,
                          color: Colors.blue,
                        ),
                        const SizedBox(width: 8),
                        Text(teacherDesignation)
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
        label: isStudent ? const Text('Join Live') : const Text('Go Live'),
        icon: const Icon(Icons.live_tv_rounded),
        backgroundColor: Colors.orange,
      ),
    );
  }
}
