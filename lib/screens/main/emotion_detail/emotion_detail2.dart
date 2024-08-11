import 'package:flutter/material.dart';
import '../emotion_data.dart';

class EmotionDetail2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Color mainColor = Color(0xFFFF3D00);

    return _buildEmotionCard(
      context,
      '이번 주의 분노 지수',
      LinearGradient(
        colors: [
          Color(0xFFFFA590), // 위쪽 색상
          Color(0xFFFFFFFF), // 아래쪽 색상
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      'anger',
      mainColor, // 분노와 평균 23%의 색상
    );
  }

  Widget _buildEmotionCard(BuildContext context, String title,
      LinearGradient gradient, String emotionKey, Color textColor) {
    final emotionValues =
        emotionData.map((e) => e[emotionKey] as double).toList();
    final averageValue = emotionValues.isNotEmpty
        ? emotionValues.reduce((a, b) => a + b) / emotionValues.length
        : 0.0;

    return Container(
      width: double.infinity,
      height: 270,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: gradient, // 그라데이션 적용
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
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "이번 주의 ",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2E2E2E).withOpacity(0.5),
                  ),
                ),
                TextSpan(
                  text: "분노 ",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: textColor, // 분노의 색상 적용
                  ),
                ),
                TextSpan(
                  text: "지수",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2E2E2E).withOpacity(0.5),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Container(
                width: 31,
                height: 24,
                child: Center(
                  child: Text(
                    '평균',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFA6A6A6).withOpacity(0.5),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 5),
              Text(
                '${averageValue.toStringAsFixed(0)}%',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: textColor, // 평균 23%의 색상 적용
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: _buildEmotionBarChart(textColor, emotionValues),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmotionBarChart(Color color, List<double> emotionValues) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: List.generate(emotionValues.length, (index) {
        return Expanded(
          child: _buildBar(_getWeekdayLabel(emotionData[index]['date']),
              emotionValues[index].toInt(), color),
        );
      }),
    );
  }

  Widget _buildBar(String label, int percentage, Color color) {
    final maxBarHeight = 145.0; // 차트 바의 최대 높이 설정
    final barHeight =
        15 + (percentage / 100) * maxBarHeight; // 최소 5px, 비율에 따라 차트 바의 높이 계산

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 38,
          height: barHeight,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 4.0, bottom: 4.0),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                '$percentage%',
                style: TextStyle(
                  fontSize: 8,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 13,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.w900,
            height: 1.3,
            letterSpacing: -0.05,
            color: color,
          ),
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
}
