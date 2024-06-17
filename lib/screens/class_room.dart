import 'package:flutter/material.dart';
import 'package:ma_raza_khan/widgets/class_top_items.dart';

import '../widgets/project_constants.dart' as pc;

class ClassroomScreen extends StatefulWidget {
  const ClassroomScreen({super.key});

  @override
  State<ClassroomScreen> createState() => _ClassroomScreenState();
}

class _ClassroomScreenState extends State<ClassroomScreen> {
  late int studentCount;
  bool topicDone = false;

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
                          Icons.person,
                          color: Colors.deepOrange,
                        ),
                        SizedBox(width: 8),
                        Text(
                          'Class Teacher',
                          style:
                              TextStyle(fontSize: 14, color: Colors.deepOrange),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.info_rounded,
                          color: Colors.blue,
                        ),
                        SizedBox(width: 8),
                        Text(
                          'Saddam Hossain',
                          style: TextStyle(
                              fontSize: 14,
                              color: Color.fromARGB(255, 63, 31, 69),
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.more_rounded,
                          color: Colors.blue,
                        ),
                        SizedBox(width: 8),
                        Text('Software Developer, E2OPEN')
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
                  color: Colors.blueGrey,
                ),
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
