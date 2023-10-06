import 'package:flutter/material.dart';
import '../Model/holiday_model.dart';
import '../Repository/holiday_repository.dart';

class HolidayScreen extends StatefulWidget {
  final HolidayRepository repository;

  HolidayScreen({required this.repository});

  @override
  _HolidayScreenState createState() => _HolidayScreenState();
}

class _HolidayScreenState extends State<HolidayScreen> {
  late Future<List<Holiday>> _holidays;

  @override
  void initState() {
    super.initState();
    _holidays = widget.repository.getHolidays();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Holidays'),
      ),
      body: FutureBuilder<List<Holiday>>(
        future: _holidays,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            List<Holiday> holidays = snapshot.data!;
            return ListView.builder(
              itemCount: holidays.length,
              itemBuilder: (context, index) {
                Holiday holiday = holidays[index];
                // Check for 'New Year's Day' and set a specific image
                String imageUrl = holiday.name == "New Year's Day"
                    ? 'https://upload.wikimedia.org/wikipedia/commons/e/eb/Mexico_City_New_Years_2013%21_%288333128248%29.jpg'
                    : ''; // Set a default empty string if it's not 'New Year's Day'

                return Card(
                  elevation: 5,
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: ListTile(
                    contentPadding: EdgeInsets.all(10),
                    leading: imageUrl.isNotEmpty ? Image.network(imageUrl) : null,
                    title: Text(
                      holiday.name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Date: ${holiday.date}',
                          style: TextStyle(fontSize: 16),
                        ),
                        Text(
                          'Observed: ${holiday.observed}',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    trailing: holiday.isPublic ? Icon(Icons.public, color: Colors.blue) : Icon(Icons.person, color: Colors.green),
                    onTap: () {
                      // Handle onTap event if needed
                    },
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}

// Define your Holiday and HolidayRepository classes here
