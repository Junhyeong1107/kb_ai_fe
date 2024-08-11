import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SpinKitFadingCircle(
              size: 50.0,
              itemBuilder: (BuildContext context, int index) {
                List<Color> colors = [
                  const Color(0xFFFFA1DF),
                  const Color(0xFF31A427),
                  const Color(0xFF6082F7),
                  const Color(0xFFF79260),
                  const Color(0xFFE285EA)
                ];
                return DecoratedBox(
                  decoration: BoxDecoration(
                    color: colors[index % colors.length],
                    shape: BoxShape.circle,
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            const Text(
              '박준형 님의 계좌를 분석중이에요..',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
