import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:device_preview/device_preview.dart';
import 'package:workmanager/workmanager.dart';
import 'providers/UserProvider.dart';
import 'screens/landing.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    print("Background Task: $task executed");

    // 테스트용: 서버에서 데이터를 가져오는 작업 실행
    await fetchEmotionDataFromServer();

    return Future.value(true);
  });
}

Future<void> fetchEmotionDataFromServer() async {
  final url = Uri.parse('http://43.200.7.249:8080/getEmotionData');

  try {
    final response = await http.get(url);
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      print('Emotion data received: $data');
    } else {
      print('Failed to load emotion data. Status code: ${response.statusCode}');
    }
  } catch (e) {
    print('Error fetching emotion data: $e');
  }
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  Workmanager().initialize(
    callbackDispatcher,
    isInDebugMode: true,
  );

  // 현재 시간 기준으로 1분 후에 작업을 예약
  scheduleTestTask(Duration(minutes: 1));

  runApp(
    DevicePreview(
      enabled: true,
      builder: (context) => MyApp(),
    ),
  );
}

void scheduleTestTask(Duration delay) {
  Workmanager().cancelAll(); // 기존 작업을 취소

  Workmanager().registerOneOffTask(
    "immediateTask",
    "fetchEmotionData",
    initialDelay: delay, // 테스트용으로 1분 후 실행
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: MaterialApp(
        builder: DevicePreview.appBuilder,
        locale: DevicePreview.locale(context),
        theme: ThemeData(
          fontFamily: 'Inter',
        ),
        home: LandingPage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
