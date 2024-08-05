import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'screens/landing.dart';

void main() {
  runApp(
    DevicePreview(
      enabled: true,
      builder: (context) => MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: DevicePreview.appBuilder,
      locale: DevicePreview.locale(context),
      theme: ThemeData(
        fontFamily: 'Inter',
      ),
      home: LandingPage(),
    );
  }
}
