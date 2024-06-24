// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import '../../services/firestore_service.dart';
import 'class_topics.dart';

class TopicManager extends StatefulWidget {
  final String classId;
  const TopicManager({super.key, required this.classId});

  @override
  _TopicManagerState createState() => _TopicManagerState();
}

class _TopicManagerState extends State<TopicManager> {
  final FirestoreService _firestoreService = FirestoreService();
  late Stream<List<Topic>> _topicsStream;

  @override
  void initState() {
    super.initState();
    _topicsStream = _firestoreService.getTopics(widget.classId);
  }

  void _toggleComplete(Topic topic) {
    final updatedTopic = Topic(
      title: topic.title,
      isCompleted: !topic.isCompleted,
    );
    _firestoreService.addTopic(widget.classId, updatedTopic);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Topic>>(
      stream: _topicsStream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        final topics = snapshot.data ?? [];
        return TopicSheet(
          topics: topics,
          onToggleComplete: _toggleComplete,
        );
      },
    );
  }
}
