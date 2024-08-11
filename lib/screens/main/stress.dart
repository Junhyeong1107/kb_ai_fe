import 'package:flutter/material.dart';
import 'emotion_detail/emotion_detail.dart';

class StressIndex extends StatelessWidget {
  final Color buttonColor; // 버튼 색상을 받기 위한 파라미터

  StressIndex({required this.buttonColor});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double filledWidth = constraints.maxWidth * 0.07; // 색칠된 부분의 너비 계산

        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 3,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    '이번 주의 스트레스 지수',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      height: 23 / 15, // line-height
                      letterSpacing: -0.05, // letter-spacing
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => EmotionDetailPage()),
                      );
                    },
                    child: Text(
                      '전체보기',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        height: 23 / 13, // line-height
                        letterSpacing: -0.05, // letter-spacing
                        color: buttonColor, // 페이지에 따른 색상 적용
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    height: 15,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.grey[200],
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        height: 15,
                        width: filledWidth, // 계산된 너비를 사용하여 색칠된 부분 설정
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          gradient: const LinearGradient(
                            colors: [Color(0xFF80C4E9), Color(0xFFEC509B)],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: filledWidth - 10, // 색칠된 부분 끝에 아이콘 배치
                    top: -9, // 아이콘을 그래프 위로 올림
                    child: Image.asset(
                      'assets/stress_icon.png',
                      height: 30,
                      width: 30,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
