import 'package:flutter/material.dart';

import '../widgets/project_constants.dart';

class ClassroomScreen extends StatefulWidget {
  const ClassroomScreen({super.key});

  @override
  State<ClassroomScreen> createState() => _ClassroomScreenState();
}

class _ClassroomScreenState extends State<ClassroomScreen> {
  late int studentCount;

  @override
  void initState() {
    studentCount = 31;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Class Room'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.elliptical(30, 30),
                bottomRight: Radius.elliptical(30, 30),
              ),
              color: classRoomIteamsBackgroundColor,
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
                        child: Text('M', style: TextStyle(color: Colors.white)),
                      ),
                      const SizedBox(width: 2),
                      const CircleAvatar(
                        backgroundColor: Colors.orange,
                        child: Text('S', style: TextStyle(color: Colors.white)),
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
                const SizedBox(height: 16),
                GridView.count(
                  crossAxisCount: 4,
                  shrinkWrap: true,
                  children: const [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.calendar_month,
                          color: Colors.white,
                        ),
                        Text(
                          'Attendance',
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.schedule_rounded,
                          color: Colors.white,
                        ),
                        Text(
                          'TimeTabel',
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.notifications_none_rounded,
                          color: Colors.white,
                        ),
                        Text(
                          'Notice Board',
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.chat_rounded,
                          color: Colors.white,
                        ),
                        Text(
                          'Chat',
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.note_rounded,
                          color: Colors.white,
                        ),
                        Text(
                          'Home Works',
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.folder_rounded,
                          color: Colors.white,
                        ),
                        Text(
                          'Study Materials',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.assignment_rounded,
                          color: Colors.white,
                        ),
                        Text(
                          'Tests',
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.video_collection_rounded,
                          color: Colors.white,
                        ),
                        Text(
                          'Recordings',
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Lessons',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.lightbulb,
                      color: Colors.deepOrange,
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Topics',
                      style: TextStyle(fontSize: 14, color: Colors.deepOrange),
                    ),
                  ],
                ),
                Text(
                  'Add the topics here\nYou can set timeline for individual topics and track progress here',
                  style: TextStyle(fontSize: 14),
                ),
              ],
            ),
          ),
          Row(
            children: [
              TextButton(
                onPressed: () {},
                child: const Text(
                  'I\'ll do it later',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
              TextButton(
                onPressed: () {},
                child: const Text(
                  'Setup Now',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ],
          ),
          Expanded(
            child: ListView(
              children: const [
                LessonTile(title: 'Introduction to Java'),
                LessonTile(title: 'Variables'),
                LessonTile(title: 'String'),
                LessonTile(title: 'Operator'),
                LessonTile(title: 'Conditional Statements'),
                LessonTile(title: 'Loops (For, while, do while)'),
              ],
            ),
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

class LessonTile extends StatelessWidget {
  final String title;

  const LessonTile({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      trailing: const Icon(Icons.check_circle, color: Colors.green),
      onTap: () {},
    );
  }
}
