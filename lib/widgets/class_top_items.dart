import 'package:flutter/material.dart';

myClassRoomGridItems() {
  return GridView.count(
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
  );
}
