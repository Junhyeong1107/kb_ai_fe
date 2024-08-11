import 'package:flutter/material.dart';
import 'main1.dart';
import 'main2.dart';
import 'main3.dart';
import 'main4.dart';
import 'stress.dart';
import 'CategorySpendingPage.dart'; // CategorySpendingPage를 import

class SummaryPage extends StatefulWidget {
  @override
  _SummaryPageState createState() => _SummaryPageState();
}

class _SummaryPageState extends State<SummaryPage> {
  int _currentPage = 0;
  final PageController _pageController = PageController();

  void _onPageChanged(int page) {
    setState(() {
      _currentPage = page;
    });
  }

  void _onPageSwiped(double delta) {
    if (delta < -50 && _currentPage < 4) { // 페이지 수에 맞게 조정
      // 오른쪽으로 스와이프
      setState(() {
        _currentPage++;
        _pageController.animateToPage(
          _currentPage,
          duration: Duration(milliseconds: 600),
          curve: Curves.easeInOut,
        );
      });
    } else if (delta > 50 && _currentPage > 0) {
      // 왼쪽으로 스와이프
      setState(() {
        _currentPage--;
        _pageController.animateToPage(
          _currentPage,
          duration: Duration(milliseconds: 600),
          curve: Curves.easeInOut,
        );
      });
    }
  }

  Color _getButtonColor(int page) {
    switch (page) {
      case 0:
        return Color(0xFF00F0FF); // 기쁨
      case 1:
        return Color(0xFFFF5000); // 분노
      case 2:
        return Color(0xFF52A2FF); // 슬픔
      case 3:
        return Color(0xFF30B3FC); // 불안
      default:
        return Color(0xFFFF5000); // 기본 색상 (분노)
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: screenWidth,
          child: Column(
            children: [
              GestureDetector(
                onHorizontalDragEnd: (details) {
                  _onPageSwiped(details.primaryVelocity ?? 0);
                },
                child: Container(
                  height: screenHeight * 0.53, // 화면의 53%를 main 페이지에 할당
                  width: double.infinity,
                  child: PageView(
                    controller: _pageController,
                    onPageChanged: _onPageChanged,
                    children: [
                      MainPage1(currentPage: _currentPage),
                      MainPage2(currentPage: _currentPage),
                      MainPage3(currentPage: _currentPage),
                      MainPage4(currentPage: _currentPage),
                    ],
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                child: Column(
                  children: [
                    StressIndex(
                      buttonColor: _getButtonColor(_currentPage), // 페이지에 따른 버튼 색상 전달
                    ),
                    SizedBox(height: 16),
                    // CategorySpendingPage을 직접 추가하여 위치 조정
                    Container(
                      height: screenHeight * 0.45, // 화면의 45%를 CategorySpendingPage에 할당
                      width: double.infinity,
                      child: CategorySpendingPage(pageIndex: _currentPage), // 현재 페이지 인덱스를 전달합니다.
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
