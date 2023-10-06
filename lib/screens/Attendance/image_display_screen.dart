import 'package:flutter/material.dart';
import 'dart:io';
import 'package:intl/intl.dart';


class ImageDisplayScreen extends StatefulWidget {
  final String imagePath;
  final String attendanceTime;

  ImageDisplayScreen({required this.imagePath, required this.attendanceTime});

  @override
  _ImageDisplayScreenState createState() => _ImageDisplayScreenState();
}
class _ImageDisplayScreenState extends State<ImageDisplayScreen> {
  List<String> capturedImagePaths = [];

  @override
  void initState() {
    super.initState();
    capturedImagePaths.add(widget.imagePath);
  }

  @override
  Widget build(BuildContext context) {
    final currentTime = DateFormat('hh:mm:ss a').format(DateTime.now());
    final currentDate = DateFormat('MMM dd, yyyy').format(DateTime.now());

    return Scaffold(
      appBar: AppBar(
        title: Text('Captured Images'),
      ),
      body: ListView.builder(
        itemCount: capturedImagePaths.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.all(10),
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipOval(
                    child: Image.file(
                      File(capturedImagePaths[index]),
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text('Date: $currentDate'),
                  Text('Attendance Time: ${widget.attendanceTime}'),
                  Text('Leaving Time: $currentTime'),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
