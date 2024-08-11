import 'package:flutter/material.dart';
import 'emotion_detail1.dart';
import 'emotion_detail2.dart';
import 'emotion_detail3.dart';
import 'emotion_detail4.dart';
import '../emotion_data.dart';
import '../summary.dart';

class EmotionDetailPage extends StatefulWidget {
  @override
  _EmotionDetailPageState createState() => _EmotionDetailPageState();
}

class _EmotionDetailPageState extends State<EmotionDetailPage> {
  double containerHeight = 0.80; // 초기 컨테이너 높이 비율

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // 감정 합 계산
    final totalHappy =
        emotionData.fold(0.0, (sum, item) => sum + item['happy']);
    final totalAnger =
        emotionData.fold(0.0, (sum, item) => sum + item['anger']);
    final totalDepression =
        emotionData.fold(0.0, (sum, item) => sum + item['depression']);
    final totalUnrest =
        emotionData.fold(0.0, (sum, item) => sum + item['unrest']);

    // 가장 큰 값과 해당 감정에 따라 배경 색상 및 이미지 결정
    String leadingEmotion = '기쁨도';
    Color emotionColor = Color(0xFF00F0FF);
    String backgroundImage = 'assets/happy.png';

    if (totalAnger > totalHappy &&
        totalAnger > totalDepression &&
        totalAnger > totalUnrest) {
      leadingEmotion = '분노도';
      emotionColor = Color(0xFFFF5000);
      backgroundImage = 'assets/anger.png';
    } else if (totalDepression > totalHappy &&
        totalDepression > totalAnger &&
        totalDepression > totalUnrest) {
      leadingEmotion = '우울도';
      emotionColor = Color(0xFF52A2FF);
      backgroundImage = 'assets/depression.png';
    } else if (totalUnrest > totalHappy &&
        totalUnrest > totalAnger &&
        totalUnrest > totalDepression) {
      leadingEmotion = '불안도';
      emotionColor = Color(0xFF30B3FC);
      backgroundImage = 'assets/unrest.png';
    }

    return Scaffold(
      body: Stack(
        children: [
          // 배경 이미지 설정
          Positioned.fill(
            child: Opacity(
              opacity: 0.3, // 배경 사진 투명도
              child: Image.asset(
                backgroundImage,
                fit: BoxFit.cover,
              ),
            ),
          ),

          // 상단의 텍스트 영역
          Positioned(
            top: 10,
            left: 0,
            right: 0,
            child: Container(
              width: screenWidth,
              height: screenHeight * 0.20,
              alignment: Alignment.center,
              padding: EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center, // 텍스트를 중앙으로 정렬
                children: [
                  RichText(
                    textAlign: TextAlign.center, // 텍스트 중앙 정렬
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "이번 주는 ",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color:
                                Color(0xFFFFFFFF).withOpacity(0.8), // 80% 불투명도
                          ),
                        ),
                        TextSpan(
                          text: "$leadingEmotion ",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: emotionColor, // 감정 색상
                          ),
                        ),
                        TextSpan(
                          text: "가장 높아요",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color:
                                Color(0xFFFFFFFF).withOpacity(0.8), // 80% 불투명도
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // 아래에서부터 시작하는 스크롤 가능한 컨테이너 영역
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: GestureDetector(
              onVerticalDragUpdate: (details) {
                setState(() {
                  containerHeight -= details.primaryDelta! / screenHeight;
                  containerHeight =
                      containerHeight.clamp(0.5, 0.80); // 컨테이너 높이 제한
                });
              },
              onVerticalDragEnd: (details) {
                if (containerHeight <= 0.65) {
                  // 50% 이하로 내려가면 SummaryPage로 이동
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => SummaryPage()),
                  );
                } else {
                  setState(() {
                    containerHeight = 0.80; // 컨테이너 높이 원래대로 복귀
                  });
                }
              },
              child: Container(
                width: screenWidth,
                height: screenHeight * containerHeight,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    // 드래그 가능한 바 추가
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Container(
                        width: 180,
                        height: 6,
                        decoration: BoxDecoration(
                          color: Colors.grey[400],
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                    ),
                    // 스크롤 가능한 영역
                    Expanded(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            children: [
                              EmotionDetail1(),
                              EmotionDetail2(),
                              EmotionDetail3(),
                              EmotionDetail4(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
