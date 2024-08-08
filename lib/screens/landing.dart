import 'package:flutter/material.dart';
import 'login.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: [
          _buildPageContent(
            context,
            'assets/kb_logo.png',
            '소비 패턴을 분석하고\n심리 분석을 제공해요',
            'AI를 통해 소비 습관을 분석하고\n당신의 마음을 알아보세요',
            'assets/landing_illustration.png',
          ),
          _buildPageContent(
            context,
            'assets/kb_logo.png',
            '다른 제목',
            '다른 설명 텍스트',
            'assets/landing_illustration.png',
          ),
        ],
      ),
    );
  }

  Widget _buildPageContent(
    BuildContext context,
    String logoPath,
    String title,
    String subtitle,
    String imagePath,
  ) {
    return Stack(
      children: [
        Positioned.fill(
          child: Container(
            color: Colors.white, // 전체 배경색 설정
          ),
        ),
        Positioned(
          top: 50,
          left: 20,
          child: Image.asset(
            logoPath,
            width: 100, // 로고 이미지 크기 조정
          ),
        ),
        SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, // 텍스트를 왼쪽 정렬
              children: [
                SizedBox(height: 130), // 로고와 텍스트 사이의 간격 조정
                Padding(
                  padding: const EdgeInsets.only(left: 10.0), // 텍스트를 살짝 왼쪽으로 이동
                  child: Text(
                    title,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 30,
                
                      fontWeight: FontWeight.w900,
                      height: 40 / 30, // line-height
                      letterSpacing: -0.05, // letter-spacing
                      color: Colors.black.withOpacity(0.8),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0), // 텍스트를 살짝 왼쪽으로 이동
                  child: Text(
                    subtitle,
                    textAlign: TextAlign.left, // 왼쪽 정렬
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      height: 23 / 15, // line-height 설정
                      letterSpacing: -0.05, // letter-spacing
                      color: Colors.black.withOpacity(0.6),
                    ),
                  ),
                ),
                SizedBox(height: 40),
                Center(
                  child: Image.asset(
                    imagePath,
                    width: 300, // 일러스트레이션 이미지 크기 조정
                  ),
                ),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // 회원가입 버튼 클릭 이벤트 처리
                      },
                      child: Text('회원가입'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        minimumSize: Size(150, 50),
                        side: BorderSide(color: Colors.black),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginPage(),
                          ),
                        );
                      },
                      child: Text('로그인'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.yellow,
                        foregroundColor: Colors.black,
                        minimumSize: Size(150, 50),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
