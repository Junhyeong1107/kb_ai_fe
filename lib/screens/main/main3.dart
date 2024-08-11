import 'package:flutter/material.dart';
import 'emotion_data.dart';

class MainPage3 extends StatelessWidget {
  final int currentPage;

  MainPage3({required this.currentPage});

  @override
  Widget build(BuildContext context) {
    final highestDay = _getHighestEmotionDay(emotionData, 'depression');
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          backgroundColor: Colors.transparent, // AppBar의 배경을 투명으로 설정하여 이미지가 보이게 합니다.
          elevation: 0,
          pinned: true,
          expandedHeight: 380,
          flexibleSpace: FlexibleSpaceBar(
            background: Stack(
              children: [
                Positioned.fill(
                  child: Image.asset(
                    'assets/depression.png', // 배경 이미지 경로
                    fit: BoxFit.cover,
                    color: Colors.black.withOpacity(0.3), // 흐릿하게 만들기
                    colorBlendMode: BlendMode.darken,
                  ),
                ),
                Column(
                  children: [
                    Flexible(
                      child: Stack(
                        children: [
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(40),
                                bottomRight: Radius.circular(40),
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 50.0), // 텍스트와 차트를 아래로 내리기 위한 패딩
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Text.rich(
                                          TextSpan(
                                            children: [
                                              TextSpan(
                                                text: '박준형 님, ',
                                                style: TextStyle(
                                                  fontFamily: 'Inter',
                                                  fontSize: 25,
                                                  fontWeight: FontWeight.w900, // 나머지 텍스트 스타일
                                                  height: 30 / 25, // line-height를 반영하기 위해 fontSize로 나누어줌
                                                  letterSpacing: -0.05,
                                                  color: Colors.white, // 흰색으로 설정
                                                ),
                                              ),
                                              TextSpan(
                                                text: '이번 주는\n',
                                                style: TextStyle(
                                                  fontFamily: 'Inter',
                                                  fontSize: 25,
                                                  fontWeight: FontWeight.w400, // '이번 주는' 부분의 스타일
                                                  height: 30 / 25, // line-height를 반영하기 위해 fontSize로 나누어줌
                                                  letterSpacing: -0.05,
                                                  color: Colors.white, // 흰색으로 설정
                                                ),
                                              ),
                                              TextSpan(
                                                text: '$highestDay요일의 ',
                                                style: TextStyle(
                                                  fontFamily: 'Inter',
                                                  fontSize: 25,
                                                  fontWeight: FontWeight.w900, // 나머지 텍스트 스타일
                                                  height: 30 / 25, // line-height를 반영하기 위해 fontSize로 나누어줌
                                                  letterSpacing: -0.05,
                                                  color: Colors.white, // 흰색으로 설정
                                                ),
                                              ),
                                              TextSpan(
                                                text: '우울도가',
                                                style: TextStyle(
                                                  fontFamily: 'Inter',
                                                  fontSize: 25,
                                                  fontWeight: FontWeight.w900, // 나머지 텍스트 스타일
                                                  height: 30 / 25, // line-height를 반영하기 위해 fontSize로 나누어줌
                                                  letterSpacing: -0.05,
                                                  color: Color(0xFF52A2FF), // 기쁨도의 색상
                                                ),
                                              ),
                                              TextSpan(
                                                text: ' 높아요',
                                                style: TextStyle(
                                                  fontFamily: 'Inter',
                                                  fontSize: 25,
                                                  fontWeight: FontWeight.w900, // 나머지 텍스트 스타일
                                                  height: 30 / 25, // line-height를 반영하기 위해 fontSize로 나누어줌
                                                  letterSpacing: -0.05,
                                                  color: Colors.white, // 흰색으로 설정
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                                        child: Text(
                                          '이번 주의 우울 지수를 살펴보세요',
                                          style: TextStyle(
                                            fontFamily: 'Inter',
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600,
                                            height: 15 / 23,
                                            letterSpacing: -0.05,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: List.generate(emotionData.length, (index) {
                                        final dateData = emotionData[index];
                                        return _buildBar(
                                          _getWeekdayLabel(dateData['date']),
                                          dateData['depression'].toInt(),
                                          dateData['depression'] == _getHighestValue(emotionData, 'depression'),
                                          100,
                                        );
                                      }),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 16),
                                _buildPageIndicator(), // 페이지 인디케이터 추가
                                const SizedBox(height: 16),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          actions: [
            IconButton(
              icon: Image.asset('assets/setting_icon.png'),
              onPressed: () {
                // 설정 아이콘 클릭 시 동작 정의
              },
              iconSize: 30.0, // 아이콘 크기 조절
            ),
            IconButton(
              icon: Image.asset('assets/alarm_icon.png'),
              onPressed: () {
                // 알람 아이콘 클릭 시 동작 정의
              },
              iconSize: 30.0, // 아이콘 크기 조절
            ),
          ],
        ),
      ],
    );
  }

  String _getWeekdayLabel(String dateString) {
    final date = DateTime.parse(dateString);
    final weekday = date.weekday;
    const weekDays = ['월', '화', '수', '목', '금', '토', '일'];
    return weekDays[weekday - 1];
  }

  String _getHighestEmotionDay(List<Map<String, dynamic>> data, String emotion) {
    double highestValue = 0;
    String highestDay = '';
    for (var item in data) {
      if (item[emotion] > highestValue) {
        highestValue = item[emotion];
        highestDay = _getWeekdayLabel(item['date']);
      }
    }
    return highestDay;
  }

  double _getHighestValue(List<Map<String, dynamic>> data, String emotion) {
    double highestValue = 0;
    for (var item in data) {
      if (item[emotion] > highestValue) {
        highestValue = item[emotion];
      }
    }
    return highestValue;
  }

  Widget _buildPageIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(4, (index) {
        return AnimatedContainer(
          duration: Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 4.0),
          height: 8.0,
          width: currentPage == index ? 24.0 : 8.0,
          decoration: BoxDecoration(
            color: currentPage == index ? Color(0xFF52A2FF) : Colors.grey, // 기쁨도 색상으로 인디케이터 설정
            borderRadius: BorderRadius.circular(12),
          ),
        );
      }),
    );
  }

Widget _buildBar(String label, int percentage, bool isMax, int maxPercentage) {
  double baseHeight = 15; // 기본 높이 10px
  double additionalHeight = (percentage.toDouble() / maxPercentage) * 100; // 퍼센트에 비례한 추가 높이
  double barHeight = baseHeight + additionalHeight; // 기본 높이 + 퍼센트에 비례한 높이

  return Flexible(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Stack(
          children: [
            Container(
              width: 48,
              height: barHeight * 2, // 최종 계산된 높이 적용
              decoration: BoxDecoration(
                color: isMax ? Color(0xFF52A2FF) : Colors.transparent, // 최대값만 색상 적용
                border: Border.all(
                  color: Color(0xFF52A2FF),
                  width: 1.5,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            Positioned(
              bottom: 10, // 텍스트 위치를 바닥에서 10px 위로 조정
              left: 8,
              child: Text(
                label,
                style: const TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 13,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w900,
                  height: 13 / 30,
                  letterSpacing: -0.05,
                  color: Colors.white, // 요일 텍스트를 흰색으로 설정
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          '$percentage%',
          style: const TextStyle(
            fontFamily: 'Inter',
            fontSize: 10,
            fontWeight: FontWeight.w800,
            height: 1.5,
            letterSpacing: -0.05,
            color: Colors.white, // 퍼센트 텍스트를 흰색으로 설정
          ),
        ),
      ],
    ),
  );
}
}
