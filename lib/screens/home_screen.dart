import 'package:flutter/material.dart';
import 'package:ma_raza_khan/widgets/my_appdrawer.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       home: HomeScreen(),
//     );
//   }
// }

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('M.A RAZA KHAN'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {},
          ),
        ],
      ),
      drawer: myAppDrawer(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              elevation: 4,
              child: ListTile(
                title: const Text('Study Material Manager'),
                subtitle: const Text('Upload and manage study material.'),
                trailing: ElevatedButton(
                  onPressed: () {},
                  child: const Text('Upload'),
                ),
                leading: Image.network(
                    'https://via.placeholder.com/150'), // Replace with actual image
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                const Text('Overview',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const Spacer(),
                const Text('ID: 6608153922'),
                IconButton(
                  icon: const Icon(Icons.share),
                  onPressed: () {},
                ),
              ],
            ),
          ),
          Expanded(
            child: GridView.count(
              crossAxisCount: 3,
              children: const [
                GridItem(icon: Icons.play_circle_fill, label: 'Live Class'),
                GridItem(icon: Icons.article, label: 'Test'),
                GridItem(icon: Icons.menu_book, label: 'Study Material'),
                GridItem(icon: Icons.chat, label: 'Chat'),
                GridItem(icon: Icons.assignment, label: 'Assignment'),
                GridItem(icon: Icons.attach_money, label: 'Fee'),
                GridItem(icon: Icons.poll, label: 'Poll'),
                GridItem(icon: Icons.fiber_manual_record, label: 'Recording'),
                GridItem(icon: Icons.support, label: 'Support'),
                GridItem(icon: Icons.calendar_today, label: 'Attendance'),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.group), label: 'Students/Co-Teachers'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Premium'),
        ],
      ),
    );
  }
}

class GridItem extends StatelessWidget {
  final IconData icon;
  final String label;

  const GridItem({super.key, required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: InkWell(
        onTap: () {},
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 50),
            const SizedBox(height: 8),
            Text(label, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}
