import 'package:flutter/material.dart';

class EmotionDetailPage extends StatefulWidget {
  @override
  _EmotionDetailPageState createState() => _EmotionDetailPageState();
}

class _EmotionDetailPageState extends State<EmotionDetailPage> {
  final ScrollController _scrollController = ScrollController();
  double _dragOffset = 0.0;
  final double _threshold = 100.0; // 드래그가 summary.dart로 이동하기 위한 임계값

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onVerticalDragUpdate(DragUpdateDetails details) {
    setState(() {
      _dragOffset += details.primaryDelta!;
    });
  }

  void _onVerticalDragEnd(DragEndDetails details) {
    if (_dragOffset.abs() > _threshold) {
      Navigator.pop(context);
    }
    setState(() {
      _dragOffset = 0.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Column(
        children: [
          Container(
            height: screenHeight * 0.2, // 화면의 20%를 상단 텍스트에 할당
            width: screenWidth,
            alignment: Alignment.center,
            child: Text(
              "이번 주는 슬픔도가 가장 높아요",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
          ),
          GestureDetector(
            onVerticalDragUpdate: _onVerticalDragUpdate,
            onVerticalDragEnd: _onVerticalDragEnd,
            child: Container(
              width: screenWidth * 0.8,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Text(
                  "스크롤",
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildEmotionCard(context, '슬픔 지수', Colors.blue),
                    _buildEmotionCard(context, '분노 지수', Colors.red),
                    _buildEmotionCard(context, '기쁨 지수', Colors.orange),
                    _buildEmotionCard(context, '걱정 지수', Colors.green),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmotionCard(BuildContext context, String title, Color color) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
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
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          SizedBox(height: 16),
          _buildEmotionBarChart(color),
          SizedBox(height: 8),
          Text(
            '감소하고 있지만 감정 기록이 높아요',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmotionBarChart(Color color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildBar('월', 5, color),
        _buildBar('화', 10, color),
        _buildBar('수', 9, color),
        _buildBar('목', 18, color),
        _buildBar('금', 21, color),
        _buildBar('토', 19, color),
        _buildBar('일', 19, color),
      ],
    );
  }

  Widget _buildBar(String label, int percentage, Color color) {
    return Column(
      children: [
        Text('$percentage%', style: TextStyle(fontSize: 12)),
        SizedBox(height: 4),
        Container(
          width: 20,
          height: percentage.toDouble() * 2,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        SizedBox(height: 4),
        Text(label, style: TextStyle(fontSize: 12)),
      ],
    );
  }
}
