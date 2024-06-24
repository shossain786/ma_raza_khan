import 'package:flutter/material.dart';

import '../../services/firestore_service.dart';

class TopicSheet extends StatelessWidget {
  final List<Topic> topics;
  final Function(Topic) onToggleComplete;

  const TopicSheet({
    super.key,
    required this.topics,
    required this.onToggleComplete,
  });

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
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
            ),
          ),
          child: ListView.builder(
            controller: scrollController,
            itemCount: topics.length,
            itemBuilder: (BuildContext context, int index) {
              final topic = topics[index];
              return ListTile(
                iconColor: const Color.fromARGB(255, 6, 83, 146),
                selectedTileColor: Colors.amber,
                title: Text(topic.title),
                leading: IconButton(
                  onPressed: () {
                    onToggleComplete(topic);
                  },
                  icon: topic.isCompleted
                      ? const Icon(Icons.check_box)
                      : const Icon(Icons.check_box_outline_blank_rounded),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
