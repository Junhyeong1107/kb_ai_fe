import 'package:flutter/material.dart';
import 'main1.dart';
import 'main2.dart';
import 'main3.dart';
import 'main4.dart';
import 'stress.dart';
import 'category_spending.dart';

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
    if (delta < -50 && _currentPage < 3) {
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
                  height: screenHeight * 0.55, // 화면의 60%를 main 페이지에 할당
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
                    StressIndex(),
                    SizedBox(height: 16),
                    CategorySpending(),
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
