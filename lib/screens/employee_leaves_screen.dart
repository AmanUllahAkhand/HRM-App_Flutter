import 'package:flutter/material.dart';
import '../Model/leave_recode_model.dart';
import '../Style/leave_button_style.dart';
import 'leave_form_screen.dart';

class EmployeeLeavesScreen extends StatelessWidget {
  final List<LeaveRecord> leaveRecords = [
    LeaveRecord(
      employeeName: "Aman Ullah",
      appliedDate: "Applied on 19 Nov 2022",
      leaveType: "Medical Leave",
      leaveDate: "Leave Date: 19 Nov - 19 Nov 2022",
      duration: "Duration: 1 day(s)",
      reason: "Reason: High fever",
      imageAsset: 'images/aman.jpeg', // Specify Abhay Kumar's image
    ),
    LeaveRecord(
      employeeName: "Tanvir Akhand",
      appliedDate: "Applied on 20 Nov 2022",
      leaveType: "Casual Leave",
      leaveDate: "Leave Date: 25 Nov - 30 Nov 2022",
      duration: "Duration: 6 day(s)",
      reason: "Reason: Family vacation",
      imageAsset: 'images/tanvir.jpeg', // Specify John Doe's image
    ),
    LeaveRecord(
      employeeName: "Akash Ahamed",
      appliedDate: "Applied on 23 Nov 2022",
      leaveType: "Casual Leave",
      leaveDate: "Leave Date: 29 Nov - 30 Nov 2022",
      duration: "Duration: 2 day(s)",
      reason: "Reason: Family vacation",
      imageAsset: 'images/akash.jpeg', // Specify John Doe's image
    ),
    LeaveRecord(
      employeeName: "Abdul Al Noman",
      appliedDate: "Applied on 28 Dec 2023",
      leaveType: "Medical Leave",
      leaveDate: "Leave Date: 25 Dec - 27 Dec 2023",
      duration: "Duration: 3 day(s)",
      reason: "Reason: High fever",
      imageAsset: 'images/noman.jpeg', // Specify John Doe's image
    ),
    // Add more leave records here as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Employee Leaves'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            for (var leaveRecord in leaveRecords)
              Card(
                elevation: 3,
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          CircleAvatar(
                            // Set the backgroundImage based on the record's imageAsset field
                            backgroundImage: AssetImage(leaveRecord.imageAsset),
                          ),
                          SizedBox(width: 8), // Add spacing between image and text
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                leaveRecord.employeeName,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                leaveRecord.appliedDate,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Container(
                        width: 120,
                        height: 20,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: leaveRecord.leaveType == "Casual Leave" ? Colors.amberAccent : Colors.red,
                        ),
                        child: Center(
                          child: Text(
                            leaveRecord.leaveType,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Text(
                        leaveRecord.leaveDate,
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        leaveRecord.duration,
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        leaveRecord.reason,
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          ElevatedButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text("Approve Leave"),
                                    content: Text("Are you sure you want to approve this leave?"),
                                    actions: <Widget>[
                                      TextButton(
                                        child: Text("CANCEL"),
                                        onPressed: () {
                                          Navigator.of(context).pop(); // Close the dialog
                                        },
                                      ),
                                      ElevatedButton(
                                        // Apply the approveButtonStyle here
                                        style: CustomButtonStyles.approveButtonStyle,
                                        onPressed: () {
                                          print("Approve");
                                          Navigator.of(context).pop(); // Close the dialog
                                        },
                                        child: Text("APPROVE"),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            child: Text("APPROVE"),
                            style: CustomButtonStyles.approveButtonStyle,
                          ),

                          ElevatedButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text("Reject Leave"),
                                    content: Text("Are you sure you want to reject this leave?"),
                                    actions: <Widget>[
                                      TextButton(
                                        child: Text("CANCEL"),
                                        onPressed: () {
                                          Navigator.of(context).pop(); // Close the dialog
                                        },
                                      ),
                                      ElevatedButton(
                                        // Apply the rejectButtonStyle here
                                        style: CustomButtonStyles.rejectButtonStyle,
                                        onPressed: () {
                                          Navigator.of(context).pop(); // Close the dialog
                                        },
                                        child: Text("REJECT"),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            child: Text("REJECT"),
                            style: CustomButtonStyles.rejectButtonStyle,
                          ),

                          ElevatedButton(
                            onPressed: () {
                              // ...
                            },
                            child: Text("EDIT"),
                            style: CustomButtonStyles.editButtonStyle,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FormScreen(),
            ),
          );
          print("Add button clicked");
        },
        child: Icon(Icons.add),
      ),
    );
  }
}