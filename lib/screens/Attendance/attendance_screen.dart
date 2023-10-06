import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:async';
import 'package:analog_clock/analog_clock.dart';
import 'package:image_picker/image_picker.dart';
import '../Attendance/image_display_screen.dart';

class AttendanceScreen extends StatefulWidget {
  @override
  _AttendanceScreenState createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  String currentTime = '';
  String currentDate = DateFormat('MMM dd, yyyy').format(DateTime.now());
  String attendanceTime = ''; // Store attendance time
  bool isPresent = false;
  String capturedImagePath = ''; // Store the path of the captured image

  void updateCurrentTime() {
    Timer.periodic(Duration(seconds: 1), (Timer timer) {
      if (mounted) {
        setState(() {
          currentTime = DateFormat('hh:mm:ss a').format(DateTime.now());
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    updateCurrentTime();
  }

  // Function to open the camera and take a picture
  Future<void> _takePicture() async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image != null) {
      setState(() {
        capturedImagePath = image.path; // Store the captured image path
      });

      // Store the attendance time when the picture is taken
      setState(() {
        attendanceTime = currentTime;
      });

      // Navigate to the ImageDisplayScreen and pass the image path and attendance time
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ImageDisplayScreen(
            imagePath: capturedImagePath,
            attendanceTime: attendanceTime,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Attendance Screen'),
        backgroundColor: Colors.green,
      ),
      backgroundColor: Colors.green,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 25),
            AnalogClock(
              decoration: BoxDecoration(
                border: Border.all(width: 2.0, color: Colors.white),
                color: Colors.transparent,
                shape: BoxShape.circle,
              ),
              width: 150.0,
              height: 150.0,
              isLive: true,
              hourHandColor: Colors.white,
              minuteHandColor: Colors.white,
              secondHandColor: Colors.white,
              numberColor: Colors.white,
              showAllNumbers: true,
              showTicks: true,
              textScaleFactor: 1.5,
              showDigitalClock: false,
              datetime: DateTime.now(),
            ),
            SizedBox(height: 25),
            Text(
              currentDate,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 5),
            Text(
              currentTime,
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (!isPresent) {
                  _takePicture();
                }
                setState(() {
                  isPresent = !isPresent;
                });
              },
              style: ElevatedButton.styleFrom(
                primary: isPresent ? Colors.red : Colors.green,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              ),
              child: Text(
                isPresent ? 'Leaving Work' : 'Attendance of Work',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    // Add custom logic for Break
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  ),
                  icon: Icon(Icons.timer),
                  label: Text(
                    'Break',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    // Add custom logic for Return
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  ),
                  icon: Icon(Icons.arrow_back),
                  label: Text(
                    'Return',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
