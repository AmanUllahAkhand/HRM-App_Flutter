import 'package:flutter/material.dart';

// Define a data model for attendance records
class AttendanceRecord {
  final String name;
  final String imagePath;
  final String attendanceTime;
  final String leavingTime;
  final List<String> breakTimes;
  final List<String> returnTimes;

  AttendanceRecord({
    required this.name,
    required this.imagePath,
    required this.attendanceTime,
    required this.leavingTime,
    required this.breakTimes,
    required this.returnTimes,
  });
}


class AttendanceSheetScreen extends StatelessWidget {
  final List<AttendanceRecord> records = [
    AttendanceRecord(
      name: 'John Doe',
      imagePath: 'images/akash.jpeg', // Replace with actual image path
      attendanceTime: '09:00 AM',
      leavingTime: '05:00 PM',
      breakTimes: ['11:30 AM - 12:00 PM', '03:00 PM - 03:15 PM'],
      returnTimes: ['12:00 PM', '03:15 PM'],
    ),
    // Add more attendance records here
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Attendance Sheet'),
      ),
      body: ListView.builder(
        itemCount: records.length,
        itemBuilder: (context, index) {
          return AttendanceRecordItem(record: records[index]);
        },
      ),
    );
  }
}

class AttendanceRecordItem extends StatelessWidget {
  final AttendanceRecord record;

  AttendanceRecordItem({required this.record});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: AssetImage(record.imagePath),
        radius: 30,
      ),
      title: Text(record.name),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Attendance Time: ${record.attendanceTime}'),
          Text('Leaving Time: ${record.leavingTime}'),
          Text('Break Times: ${record.breakTimes.join(', ')}'),
          Text('Return Times: ${record.returnTimes.join(', ')}'),
        ],
      ),
    );
  }
}
