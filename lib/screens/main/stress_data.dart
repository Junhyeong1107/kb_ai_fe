import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

List<Map<String, dynamic>> stressData = [
  {"date": "2024-01-01", "stress": 14.0}
];

Future<void> initializeStressData() async {
  final prefs = await SharedPreferences.getInstance();
  final storedData = prefs.getString('stressData');

  if (storedData != null) {
    stressData = List<Map<String, dynamic>>.from(json.decode(storedData));
  } else {
    await prefs.setString('stressData', json.encode(stressData));
  }
}

Future<void> fetchStressDataFromServer() async {
  final url = Uri.parse('http://43.200.7.249:8080/getStressData');

  try {
    final response = await http.get(url);
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      stressData = data.map((item) => item as Map<String, dynamic>).toList();
      print('Stress data received: $stressData');

      // 데이터 저장
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('stressData', json.encode(stressData));
    } else {
      print('Failed to load stress data. Status code: ${response.statusCode}');
    }
  } catch (e) {
    print('Error fetching stress data: $e');
  }
}
