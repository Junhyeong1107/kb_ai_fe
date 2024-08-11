import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:device_preview/device_preview.dart';
import 'package:workmanager/workmanager.dart';
import 'providers/UserProvider.dart';
import 'screens/landing.dart';
import './screens/main/stress_data.dart';

void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    print("Background Task: $task executed");

    // 서버에서 데이터를 가져오는 작업 실행
    await fetchStressDataFromServer();

    return Future.value(true);
  });
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 첫 실행 시 기존에 저장된 데이터 불러오기
  await initializeStressData();

  Workmanager().initialize(
    callbackDispatcher,
    isInDebugMode: true,
  );

  // 월요일 새벽 3시에 작업을 예약
  scheduleWeeklyTask();

  runApp(
    DevicePreview(
      enabled: true,
      builder: (context) => MyApp(),
    ),
  );
}

void scheduleWeeklyTask() {
  Workmanager().cancelAll(); // 기존 작업을 취소

  // 월요일 새벽 3시에 작업을 예약
  Workmanager().registerPeriodicTask(
    "weeklyStressDataTask",
    "fetchStressData",
    frequency: Duration(days: 7),
    initialDelay: calculateInitialDelay(), // 월요일 새벽 3시로 설정
    constraints: Constraints(
      networkType: NetworkType.connected, // 네트워크 연결 필요
    ),
  );
}

Duration calculateInitialDelay() {
  final now = DateTime.now();
  final nextMonday = now.add(Duration(days: (8 - now.weekday) % 7)); // 다음 월요일
  final nextMonday3AM =
      DateTime(nextMonday.year, nextMonday.month, nextMonday.day, 3, 0, 0);
  return nextMonday3AM.difference(now);
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
