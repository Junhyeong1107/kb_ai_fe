import 'package:flutter/material.dart';

class MainPage1 extends StatelessWidget {
  final int currentPage;

  MainPage1({required this.currentPage});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          pinned: true,
          expandedHeight: 380,
          flexibleSpace: FlexibleSpaceBar(
            background: Column(
              children: [
                Flexible(
                  child: Stack(
                    children: [
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color(0xFFFF9900).withOpacity(0.5), // 위쪽 색상
                              Color(0xFFFFF9F0).withOpacity(0.5), // 아래쪽 색상
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(40),
                            bottomRight: Radius.circular(40),
                          ),
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
                                          const TextSpan(
                                            text: '원준 님, 이번 주는\n',
                                            style: TextStyle(
                                              fontFamily: 'Inter',
                                              fontSize: 25,
                                              fontWeight: FontWeight.w600,
                                              height: 30 / 25, // line-height를 반영하기 위해 fontSize로 나누어줌
                                              letterSpacing: -0.05,
                                            ),
                                          ),
                                          const TextSpan(
                                            text: '목요일의 ',
                                            style: TextStyle(
                                              fontFamily: 'Inter',
                                              fontSize: 25,
                                              fontWeight: FontWeight.w600,
                                              height: 30 / 25, // line-height를 반영하기 위해 fontSize로 나누어줌
                                              letterSpacing: -0.05,
                                            ),
                                          ),
                                          const TextSpan(
                                            text: '홧김소비 ',
                                            style: TextStyle(
                                              fontFamily: 'Inter',
                                              fontSize: 25,
                                              fontWeight: FontWeight.w600,
                                              height: 30 / 25, // line-height를 반영하기 위해 fontSize로 나누어줌
                                              letterSpacing: -0.05,
                                              color: Colors.orange,
                                            ),
                                          ),
                                          const TextSpan(
                                            text: '가 높아요',
                                            style: TextStyle(
                                              fontFamily: 'Inter',
                                              fontSize: 25,
                                              fontWeight: FontWeight.w600,
                                              height: 30 / 25, // line-height를 반영하기 위해 fontSize로 나누어줌
                                              letterSpacing: -0.05,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                                    child: Text(
                                      '배달, 할인상품 부분에서 많은 지출이 있었어요',
                                      style: TextStyle(
                                        fontFamily: 'Inter',
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        height: 15 / 23, // line-height를 반영하기 위해 fontSize로 나누어줌
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
                                  children: [
                                    _buildBar('월', 5, false, 21),
                                    _buildBar('화', 10, false, 21),
                                    _buildBar('수', 9, false, 21),
                                    _buildBar('목', 21, true, 21),
                                    _buildBar('금', 18, false, 21),
                                    _buildBar('토', 19, false, 21),
                                    _buildBar('일', 8, false, 21),
                                  ],
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
          ),
        ),
      ],
    );
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
            color: currentPage == index ? Colors.orange : Colors.grey,
            borderRadius: BorderRadius.circular(12),
          ),
        );
      }),
    );
  }

  Widget _buildBar(String label, int amount, bool isMax, int maxAmount) {
    return Flexible(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Stack(
            children: [
              Container(
                width: 48,
                height: amount * (100.0 / maxAmount),
                decoration: BoxDecoration(
                  color: isMax ? Color(0xFFFFA800) : Colors.transparent, // 최대값만 색상 적용
                  border: Border.all(
                    color: Color(0xFFFFA800),
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
            '$amount만 원',
            style: const TextStyle(
              fontFamily: 'Inter',
              fontSize: 10,
              fontWeight: FontWeight.w800,
              height: 1.5,
              letterSpacing: -0.05,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
