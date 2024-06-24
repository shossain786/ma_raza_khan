import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<List<Topic>> getTopics(String classId) {
    return _db.collection('classes').doc(classId).snapshots().map((snapshot) {
      var data = snapshot.data(); // Ensure proper casting
      List<dynamic> topicsArray = data?['topics'] ?? [];
      return topicsArray
          .map((data) => Topic.fromMap(data as Map<String, dynamic>))
          .toList();
    });
  }

  Future<void> addTopic(String classId, Topic topic) {
    final topicMap = topic.toMap();
    return _db.collection('classes').doc(classId).update({
      'topics': FieldValue.arrayUnion([topicMap])
    });
  }

  Future<void> updateTopicCompletionStatus(
      String classId, String title, bool isCompleted) async {
    DocumentReference classDocRef = _db.collection('classes').doc(classId);
    DocumentSnapshot classDoc = await classDocRef.get();

    if (classDoc.exists) {
      var data =
          classDoc.data() as Map<String, dynamic>?; // Ensure proper casting
      List<dynamic> topicsArray = data?['topics'] ?? [];
      List<Map<String, dynamic>> updatedTopicsArray =
          topicsArray.map((topicData) {
        var topicMap =
            topicData as Map<String, dynamic>; // Ensure proper casting
        if (topicMap['title'] == title) {
          return {'title': title, 'isCompleted': isCompleted};
        } else {
          return topicMap;
        }
      }).toList();

      await classDocRef.update({'topics': updatedTopicsArray});
    }
  }
}

class Topic {
  final String title;
  final bool isCompleted;

  Topic({required this.title, this.isCompleted = false});

  factory Topic.fromMap(Map<String, dynamic> data) {
    return Topic(
      title: data['title'] ?? '',
      isCompleted: data['isCompleted'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'isCompleted': isCompleted,
    };
  }
}
