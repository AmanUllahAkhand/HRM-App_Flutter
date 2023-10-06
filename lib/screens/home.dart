import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Repository/holiday_repository.dart';
import 'Attendance/attendance_screen.dart';
import 'Attendance/attendance_sheet_screen.dart';
import 'Employee List/employee_list_screen.dart';
import 'ProfileScreen/profile_screen.dart';
import 'auth/auth_screen.dart';
import 'employee_leaves_screen.dart';
import 'holiday.dart';
import 'leave_form_screen.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  bool _isExpanded = false;
  final List<String> cardTitles = [
    "Performance",
    "Leave",
    "Organization",
    "Timesheet",
    "Attendance",
    "Files",
    "Employees",
    "Profile",
    "Worksheet",
  ]; // Track the expansion state of the menu
  final List<String> cardImages = [
    'images/performance.jpeg',
    'images/leave.jpeg',
    'images/organization.jpeg',
    'images/timesheet.png',
    'images/attendance.png',
    'images/files.png',
    'images/employees.png',
    'images/profile.png',
    'images/worksheet.jpeg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () async {
              final SharedPreferences? prefs = await _prefs;
              prefs?.clear();
              Get.offAll(AuthScreen());
            },
            child: Text(
              'logout',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text("John Doe"), // Replace with the user's name
              accountEmail: Text("johndoe@example.com"), // Replace with the user's email
              currentAccountPicture: CircleAvatar(
                backgroundImage:
                AssetImage('images/aman.jpeg'), // Replace with the actual profile image asset
              ),
            ),
            ExpansionTile(
              leading: Icon(Icons.person),
              title: Text('Employees'),
              onExpansionChanged: (expanded) {
                setState(() {
                  _isExpanded = expanded;
                });
              },
              children: [
                ListTile(
                  title: Text('Holiday'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HolidayScreen(repository: HolidayRepository(apiUrl: "https://holidayapi.com/v1/holidays?pretty&key=79bac7ee-73ce-43df-9fb8-66933cf39140&country=BD&year=2022" )),
                      ),
                    );
                  },
                ),

                ListTile(
                  title: Text('Leaves'), // Add the "Leaves" option
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EmployeeLeavesScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
            if (!_isExpanded) // Show "Item 2" only when the menu is not expanded
              ListTile(
                title: Text('Item 2'),
                onTap: () {
                  // Handle item 2 tap
                },
              ),
          ],
        ),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // 3 cards per row
        ),
        itemCount: cardTitles.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              if (cardTitles[index] == "Performance") {
                // Handle Performance card click action
                // Example: Navigate to a PerformanceScreen
              } else if (cardTitles[index] == "Leave") {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FormScreen(),
                  ),
                );
              } else if (cardTitles[index] == "Organization") {
                // Handle Organization card click action
                // Example: Navigate to an OrganizationScreen
              } else if (cardTitles[index] == "Timesheet") {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AttendanceSheetScreen(),
                  ),
                );
              } else if (cardTitles[index] == "Attendance") {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AttendanceScreen(),
                  ),
                );
              } else if (cardTitles[index] == "Files") {

              } else if (cardTitles[index] == "Employees") {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EmployeeListScreen(),
                  ),
                );
              } else if (cardTitles[index] == "Profile") {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfileScreen(),
                  ),
                );
              } else if (cardTitles[index] == "Worksheet") {
                // Handle Worksheet card click action
                // Example: Navigate to a WorksheetScreen
              }
            },

            child: Card(
              elevation: 3,
              margin: EdgeInsets.all(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    cardImages[index], // Use the image asset path for this card
                    height: 100,
                  ),
                  SizedBox(height: 8),
                  Text(
                    cardTitles[index],
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
