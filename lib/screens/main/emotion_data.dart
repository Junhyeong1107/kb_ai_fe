import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

List<Map<String, dynamic>> emotionData = [
  {
    'date': '2024-07-29',
    'anger': 61.0,
    'happy': 10.0,
    'depression': 35.0,
    'unrest': 35.0
  },
  {
    'date': '2024-07-30',
    'anger': 0.0,
    'happy': 23.0,
    'depression': 0.0,
    'unrest': 0.0
  },
  {
    'date': '2024-08-01',
    'anger': 2.0,
    'happy': 33.0,
    'depression': 23.0,
    'unrest': 0.0
  },
  {
    'date': '2024-08-02',
    'anger': 28.0,
    'happy': 42.0,
    'depression': 3.0,
    'unrest': 2.0
  },
  {
    'date': '2024-08-03',
    'anger': 7.0,
    'happy': 29.0,
    'depression': 0.0,
    'unrest': 0.0
  },
  {
    'date': '2024-08-04',
    'anger': 1.0,
    'happy': 14.0,
    'depression': 6.0,
    'unrest': 42.0
  }
];

Future<void> initializeEmotionData() async {
  final prefs = await SharedPreferences.getInstance();
  final storedData = prefs.getString('emotionData');

  if (storedData != null) {
    // 기존에 저장된 데이터가 있으면 그것을 사용
    emotionData = List<Map<String, dynamic>>.from(json.decode(storedData));
  } else {
    // 처음 로그인 시에는 기본 데이터를 사용하고, 이를 저장
    await prefs.setString('emotionData', json.encode(emotionData));
  }
}

Future<void> fetchEmotionDataFromServer() async {
  final url = Uri.parse('http://43.200.7.249:8080/getEmotionData');

  try {
    final response = await http.get(url);
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      emotionData = data.map((item) => item as Map<String, dynamic>).toList();

      // 새로운 데이터를 SharedPreferences에 저장
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('emotionData', json.encode(emotionData));

      print('Emotion data received and stored: $emotionData');
    } else {
      print('Failed to load emotion data. Status code: ${response.statusCode}');
    }
  } catch (e) {
    print('Error fetching emotion data: $e');
  }
}

String getDominantEmotion() {
  double totalAnger = 0;
  double totalHappy = 0;
  double totalDepression = 0;
  double totalUnrest = 0;

  for (var day in emotionData) {
    totalAnger += day['anger'];
    totalHappy += day['happy'];
    totalDepression += day['depression'];
    totalUnrest += day['unrest'];
  }

  Map<String, double> totals = {
    'anger': totalAnger,
    'happy': totalHappy,
    'depression': totalDepression,
    'unrest': totalUnrest,
  };

  String dominantEmotion =
      totals.entries.reduce((a, b) => a.value > b.value ? a : b).key;

  return dominantEmotion;
}

Color getEmotionColor(String emotion) {
  switch (emotion) {
    case 'happy':
      return Color(0xFF00F0FF); // 기쁨
    case 'anger':
      return Color(0xFFFF5000); // 분노
    case 'depression':
      return Color(0xFF52A2FF); // 우울
    case 'unrest':
      return Color(0xFF30B3FC); // 불안
    default:
      return Colors.black;
  }
}
