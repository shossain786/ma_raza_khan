import 'package:flutter/material.dart';

class ClassroomScreen extends StatelessWidget {
  const ClassroomScreen({super.key});

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
            padding: const EdgeInsets.all(16.0),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.elliptical(30, 30),
                bottomRight: Radius.elliptical(30, 30),
              ),
              color: Colors.blue,
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    const CircleAvatar(
                      backgroundColor: Colors.red,
                      child: Text('M', style: TextStyle(color: Colors.white)),
                    ),
                    const SizedBox(width: 8),
                    const CircleAvatar(
                      backgroundColor: Colors.orange,
                      child: Text('S', style: TextStyle(color: Colors.white)),
                    ),
                    const SizedBox(width: 8),
                    const CircleAvatar(
                      backgroundColor: Colors.blue,
                      child: Text('+1', style: TextStyle(color: Colors.white)),
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        '+ Invite',
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                GridView.count(
                  crossAxisCount: 4,
                  shrinkWrap: true,
                  children: const [
                    ClassroomFeature(
                        icon: Icons.calendar_today, label: 'Attendance'),
                    ClassroomFeature(icon: Icons.schedule, label: 'Timetable'),
                    ClassroomFeature(
                        icon: Icons.notifications, label: 'Notice Board'),
                    ClassroomFeature(icon: Icons.chat, label: 'Chat'),
                    ClassroomFeature(icon: Icons.book, label: 'Homeworks'),
                    ClassroomFeature(
                        icon: Icons.folder, label: 'Study Materials'),
                    ClassroomFeature(icon: Icons.assignment, label: 'Tests'),
                    ClassroomFeature(
                        icon: Icons.video_collection_outlined,
                        label: 'Recordings'),
                  ],
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text('Lessons',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
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

class ClassroomFeature extends StatelessWidget {
  final IconData icon;
  final String label;

  const ClassroomFeature({super.key, required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white),
          color: Colors.white54,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 30, color: Colors.blueGrey[700]),
            const SizedBox(height: 8),
            Text(label,
                style: TextStyle(color: Colors.blueGrey[700], fontSize: 12)),
          ],
        ),
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
