import 'package:flutter/material.dart';
import 'package:ma_raza_khan/screens/class_room.dart';
import 'package:ma_raza_khan/screens/create_classroom.dart';
import 'package:ma_raza_khan/widgets/my_appdrawer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Classrooms'),
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
            color: Colors.blueGrey[900],
            width: double.infinity,
            height: 120,
            padding: const EdgeInsets.all(16.0),
            child: const Column(
              children: [
                Icon(Icons.task, size: 50, color: Colors.white),
                SizedBox(height: 8),
                Text('No upcoming task', style: TextStyle(color: Colors.white)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Your Classrooms',
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CreateClassScreen(),
                          ),
                        );
                      },
                      icon: const Icon(Icons.add),
                    )
                  ],
                )
              ],
            ),
          ),
          Expanded(
            child: ListView(
              children: const [
                ClassroomCard(
                  title: 'Ilm e Fiqah Saniya',
                  subtitle: 'Fiqah',
                  schedule: 'Mon Tue',
                  students: 30,
                ),
                ClassroomCard(
                  title: 'Tajweed Ula',
                  subtitle: 'Marifati Tajweed',
                  schedule: 'Mon Tue',
                  students: 30,
                ),
                ClassroomCard(
                  title: 'Ilm e Nahw Saniya',
                  subtitle: 'Nahw',
                  schedule: 'Fri Sat',
                  students: 30,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ClassroomCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String schedule;
  final int students;

  const ClassroomCard({
    super.key,
    required this.title,
    required this.subtitle,
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
              builder: (context) => const ClassroomScreen(),
            ),
          );
        },
      ),
    );
  }
}
