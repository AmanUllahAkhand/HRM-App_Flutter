import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FormScreen extends StatefulWidget {
  @override
  _FormScreenState createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _employeeName = '';
  String _leaveType = 'Casual'; // Default value
  String _noOfDays = ''; // Initialize as empty
  String _reason = '';
  String _status = 'Pending'; // Default value
  DateTime _dateFrom = DateTime.now();
  DateTime _dateTo = DateTime.now();

  Future<void> _selectDateFrom(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _dateFrom,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _dateFrom) {
      setState(() {
        _dateFrom = picked;
        _calculateNoOfDays(); // Recalculate the number of days
      });
    }
  }

  Future<void> _selectDateTo(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _dateTo,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _dateTo) {
      setState(() {
        _dateTo = picked;
        _calculateNoOfDays(); // Recalculate the number of days
      });
    }
  }

  void _calculateNoOfDays() {
    if (_dateFrom != null && _dateTo != null) {
      final duration = _dateTo.difference(_dateFrom);
      final days = duration.inDays + 1; // Add 1 to include both start and end dates
      _noOfDays = days.toString();
    } else {
      _noOfDays = '';
    }
  }

  void _submitForm() {
    final form = _formKey.currentState;
    if (form!.validate()) {
      form.save();
      // Process or submit the form data
      print('Employee Name: $_employeeName');
      print('Leave Type: $_leaveType');
      print('Date From: ${DateFormat('yyyy-MM-dd').format(_dateFrom)}');
      print('Date To: ${DateFormat('yyyy-MM-dd').format(_dateTo)}');
      print('No of Days: $_noOfDays');
      print('Leave Reason: $_reason');
      print('Status: $_status');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Form Screen'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'Employee Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the Employee Name';
                  }
                  return null;
                },
                onSaved: (value) {
                  _employeeName = value!;
                },
              ),
              DropdownButtonFormField<String>(
                value: _leaveType,
                decoration: InputDecoration(labelText: 'Leave Type'),
                items: ['Casual', 'Medical'].map((leaveType) {
                  return DropdownMenuItem<String>(
                    value: leaveType,
                    child: Text(leaveType),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _leaveType = value!;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select the Leave Type';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Date From'),
                controller: TextEditingController(
                  text: DateFormat('yyyy-MM-dd').format(_dateFrom),
                ),
                onTap: () {
                  _selectDateFrom(context);
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Date To'),
                controller: TextEditingController(
                  text: DateFormat('yyyy-MM-dd').format(_dateTo),
                ),
                onTap: () {
                  _selectDateTo(context);
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'No of Days'),
                readOnly: true, // Make it read-only
                controller: TextEditingController(text: _noOfDays),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Leave Reason'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the Leave Reason';
                  }
                  return null;
                },
                onSaved: (value) {
                  _reason = value!;
                },
              ),
              DropdownButtonFormField<String>(
                value: _status,
                decoration: InputDecoration(labelText: 'Status'),
                items: ['Pending', 'Declined', 'Approved'].map((status) {
                  return DropdownMenuItem<String>(
                    value: status,
                    child: Text(status),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _status = value!;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select the Status';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


