import 'package:flutter/material.dart';

class CustomButtonStyles {
  static ButtonStyle approveButtonStyle = ElevatedButton.styleFrom(
    primary: Colors.green, // Set the background color for the "Approve" button
    textStyle: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.bold,
    ),
  );

  static ButtonStyle rejectButtonStyle = ElevatedButton.styleFrom(
    primary: Colors.red, // Set the background color for the "Reject" button
    textStyle: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.bold,
    ),
  );

  static ButtonStyle editButtonStyle = ElevatedButton.styleFrom(
    primary: Colors.blue, // Set the background color for the "Edit" button
    textStyle: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.bold,
    ),
  );
}
