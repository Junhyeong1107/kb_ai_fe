// emotion_data.dart
import 'package:flutter/material.dart';

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
