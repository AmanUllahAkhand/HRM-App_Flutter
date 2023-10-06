import 'package:flutter/material.dart';

class EmployeeListScreen extends StatefulWidget {
  @override
  _EmployeeListScreenState createState() => _EmployeeListScreenState();
}

class _EmployeeListScreenState extends State<EmployeeListScreen> {
  // Replace this with your data source, e.g., a list of employees with departments.
  final List<Map<String, dynamic>> employeeData = [
    {'name': 'Alimul Islam', 'department': 'Head Of Development','designation': 'Head Of Development', 'image': 'images/Employee/Alimul.png'},
    {'name': 'Md.Nazim Uddin', 'department': 'Country Manager', 'designation': 'Country Manager','image': 'images/Employee/nazim.png'},
    {'name': 'Ratul Uddin Ashraf', 'department': 'Web Developer','designation': 'Sr.Software Engineer', 'image': 'images/Employee/ratul.png'},
    {'name': 'Rakib Chowdhury', 'department': 'Web Developer', 'designation': 'Sr.Software Engineer','image': 'images/Employee/rakib.png'},
    {'name': 'Minhazul Islam', 'department': 'Web Developer', 'designation': 'Jr.Software Engineer','image': 'images/Employee/tupan.png'},
    {'name': 'Aman Ullah Akhand', 'department': 'App Developer', 'designation': 'Software Engineer Mobile App-iOS','image': 'images/Employee/aman.png'},
    {'name': 'Nur Hasan Nishad', 'department': 'UI/UX Designer','designation': 'UI/UX Designer', 'image': 'images/Employee/nishad.png'},
    {'name': 'Mehedi Hasan', 'department': 'IT Support','designation': 'Sr.IT Support Engineer', 'image': 'images/Employee/mahede.png'},
    {'name': 'Ahosanul Haque', 'department': 'IT Support','designation': 'Jr.IT Support Engineer', 'image': 'images/Employee/habib.jpeg'},
    {'name': 'Tanvir Ahmed', 'department': 'IT Support','designation': 'IT Support Engineer', 'image': 'images/Employee/habib.jpeg'},
  ];

  Map<String, List<Map<String, dynamic>>> groupedEmployees = {};
  Map<String, int> departmentEmployeeCount = {};
  Map<String, Color> departmentColors = {
    'Head Of Development' : Colors.green,
    'Country Manager': Colors.pinkAccent,
    'Web Developer': Colors.blue,
    'App Developer': Colors.teal,
    'IT Support': Colors.red,
    'UI/UX Designer': Colors.deepPurple,
  };

  @override
  void initState() {
    super.initState();
    // Initialize the groupedEmployees map.
    for (var employee in employeeData) {
      final department = employee['department'];
      if (!groupedEmployees.containsKey(department)) {
        groupedEmployees[department] = [];
      }
      groupedEmployees[department]!.add(employee);
    }

    // Calculate the employee count for each department.
    for (var department in groupedEmployees.keys) {
      departmentEmployeeCount[department] = groupedEmployees[department]!.length;
    }
  }

  List<Widget> buildCategoryButtons() {
    return groupedEmployees.keys.map((department) {
      final employeeCount = departmentEmployeeCount[department] ?? 0;
      final backgroundColor = departmentColors[department] ?? Colors.grey;

      return GestureDetector(
        onTap: () {
          // Set the selected category employees for display.
          setState(() {
            selectedEmployees = groupedEmployees[department]!;
          });
        },
        child: Container(
          padding: EdgeInsets.all(8),
          margin: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: backgroundColor,
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              Text(
                department,
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
              Text(
                'Employees: $employeeCount',
                style: TextStyle(fontSize: 12, color: Colors.white),
              ),
            ],
          ),
        ),
      );
    }).toList();
  }

  List<Map<String, dynamic>> selectedEmployees = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Employee List'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: buildCategoryButtons(),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: selectedEmployees.length,
              itemBuilder: (BuildContext context, int index) {
                final employee = selectedEmployees[index];
                return ListTile(
                  title: Text(employee['name']),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${employee['department']}'),
                      Text('${employee['designation']}'),
                    ],
                  ),
                  leading: CircleAvatar(
                    backgroundImage: AssetImage(employee['image']),
                    radius: 25,
                  ),
                  // Add other employee details or actions here.
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}


