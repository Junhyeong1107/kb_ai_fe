import 'package:flutter/material.dart';
import 'emotion_data.dart';
import 'alarm.dart';

class MainPage1 extends StatefulWidget {
  final int currentPage;

  MainPage1({required this.currentPage});

  @override
  _MainPage1State createState() => _MainPage1State();
}

class _MainPage1State extends State<MainPage1> {
  bool _isDropdownVisible = false;

  void _toggleDropdown() {
    setState(() {
      _isDropdownVisible = !_isDropdownVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    final highestDay = _getHighestEmotionDay(emotionData, 'happy');
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            pinned: true,
            expandedHeight: 380,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                children: [
                  Positioned.fill(
                    child: Image.asset(
                      'assets/happy.png',
                      fit: BoxFit.cover,
                      color: Colors.black.withOpacity(0.3),
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
                                    padding: const EdgeInsets.only(top: 50.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                                    fontWeight: FontWeight.w900,
                                                    height: 30 / 25,
                                                    letterSpacing: -0.05,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: '이번 주는\n',
                                                  style: TextStyle(
                                                    fontFamily: 'Inter',
                                                    fontSize: 25,
                                                    fontWeight: FontWeight.w400,
                                                    height: 30 / 25,
                                                    letterSpacing: -0.05,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: '$highestDay요일의 ',
                                                  style: TextStyle(
                                                    fontFamily: 'Inter',
                                                    fontSize: 25,
                                                    fontWeight: FontWeight.w900,
                                                    height: 30 / 25,
                                                    letterSpacing: -0.05,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: '기쁨도가',
                                                  style: TextStyle(
                                                    fontFamily: 'Inter',
                                                    fontSize: 25,
                                                    fontWeight: FontWeight.w900,
                                                    height: 30 / 25,
                                                    letterSpacing: -0.05,
                                                    color: Color(0xFF00F0FF),
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: ' 높아요',
                                                  style: TextStyle(
                                                    fontFamily: 'Inter',
                                                    fontSize: 25,
                                                    fontWeight: FontWeight.w900,
                                                    height: 30 / 25,
                                                    letterSpacing: -0.05,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 16.0),
                                          child: Text(
                                            '이번 주의 기쁨 지수를 살펴보세요',
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
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: List.generate(
                                            emotionData.length, (index) {
                                          final dateData = emotionData[index];
                                          return _buildBar(
                                            _getWeekdayLabel(dateData['date']),
                                            dateData['happy'].toInt(),
                                            dateData['happy'] ==
                                                _getHighestValue(
                                                    emotionData, 'happy'),
                                            100,
                                          );
                                        }),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  _buildPageIndicator(),
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
                iconSize: 30.0,
              ),
              IconButton(
                icon: Image.asset('assets/alarm_icon.png'),
                onPressed: () {
                  AlarmPage.showAlarmPopup(context);
                },
                iconSize: 30.0,
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _getWeekdayLabel(String dateString) {
    final date = DateTime.parse(dateString);
    final weekday = date.weekday;
    const weekDays = ['월', '화', '수', '목', '금', '토', '일'];
    return weekDays[weekday - 1];
  }

  String _getHighestEmotionDay(
      List<Map<String, dynamic>> data, String emotion) {
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
          width: widget.currentPage == index ? 24.0 : 8.0,
          decoration: BoxDecoration(
            color:
                widget.currentPage == index ? Color(0xFF00F0FF) : Colors.grey,
            borderRadius: BorderRadius.circular(12),
          ),
        );
      }),
    );
  }

  Widget _buildBar(
      String label, int percentage, bool isMax, int maxPercentage) {
    double baseHeight = 15;
    double additionalHeight = (percentage.toDouble() / maxPercentage) * 100;
    double barHeight = baseHeight + additionalHeight;

    return Flexible(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Stack(
            children: [
              Container(
                width: 48,
                height: barHeight * 2,
                decoration: BoxDecoration(
                  color: isMax ? Color(0xFF00F0FF) : Colors.transparent,
                  border: Border.all(
                    color: Color(0xFF00F0FF),
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              Positioned(
                bottom: 10,
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
                    color: Colors.white,
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
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
