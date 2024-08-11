import 'package:flutter/material.dart';
import 'summary.dart'; // summary.dart 파일을 import

class AdvertisePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/ad.png', // 제공된 배경 이미지를 사용
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 40,
            left: 16,
            child: Image.asset(
              'assets/kb_logo.png', // KB 로고 이미지
              width: 50,
              height: 50,
            ),
          ),
          Positioned(
            top: 40,
            right: 16,
            child: IconButton(
              icon: Icon(Icons.close, color: Colors.white),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => SummaryPage()),
                );
              },
            ),
          ),
          Positioned(
            top: 100,
            left: 16,
            right: 16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 8),
                Text(
                  '스트레스를 날리는 가장 확실한 방법',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  '원준 투어 [하와이 패키지 여행] 특가 찬스!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 40, // 하단에 위치
            right: 16, // 오른쪽에 위치
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, // 왼쪽 상단으로 이동
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10.0), // 글씨를 살짝 왼쪽으로 이동
                  child: Text(
                    '바로가기',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                CustomPaint(
                  size: Size(MediaQuery.of(context).size.width * 0.25, 20),
                  painter: ArrowPainter(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ArrowPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final path = Path();
    path.moveTo(0, size.height / 2);
    path.lineTo(size.width - 10, size.height / 2);
    path.lineTo(size.width - 20, size.height / 2 - 10);
    path.moveTo(size.width - 10, size.height / 2);
    path.lineTo(size.width - 20, size.height / 2 + 10);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
