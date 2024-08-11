import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

List<Map<String, dynamic>> stressData = [];

Future<void> fetchStressDataFromServer() async {
  final url = Uri.parse('http://43.200.7.249:8080/getStressData');

  try {
    final response = await http.get(url);
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      stressData = data.map((item) => item as Map<String, dynamic>).toList();
      print('Stress data received: $stressData');
    } else {
      print('Failed to load stress data. Status code: ${response.statusCode}');
    }
  } catch (e) {
    print('Error fetching stress data: $e');
  }
}
