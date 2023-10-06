import 'dart:convert';
import 'package:http/http.dart' as http;

import '../Model/holiday_model.dart';

class HolidayRepository {
  final String apiUrl;

  HolidayRepository({required this.apiUrl});

  Future<List<Holiday>> getHolidays() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body)['holidays'];
      return jsonList.map((json) => Holiday.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load holidays');
    }
  }
}
