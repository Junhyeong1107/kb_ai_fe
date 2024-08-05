import 'package:flutter/material.dart';

class SummaryPage1 extends StatefulWidget {
  @override
  _SummaryPage1State createState() => _SummaryPage1State();
}

class _SummaryPage1State extends State<SummaryPage1> {
  int _currentPage = 0;
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (int page) {
                setState(() {
                  _currentPage = page;
                });
              },
              children: [
                _buildPage1(),
                _buildPage2(),
                _buildPage3(),
                _buildPage4(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPage1() {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          pinned: true,
          expandedHeight: 429,
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
                              padding: const EdgeInsets.only(top: 80.0), // 텍스트와 차트를 아래로 내리기 위한 패딩
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
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                _buildStressIndex(context),
                const SizedBox(height: 16),
                _buildCategorySpending(),
                const SizedBox(height: 16),
  
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPage2() {
    return Center(child: Text("Page 2"));
  }

  Widget _buildPage3() {
    return Center(child: Text("Page 3"));
  }

  Widget _buildPage4() {
    return Center(child: Text("Page 4"));
  }

  Widget _buildPageIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(4, (index) {
        return AnimatedContainer(
          duration: Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 4.0),
          height: 8.0,
          width: _currentPage == index ? 24.0 : 8.0,
          decoration: BoxDecoration(
            color: _currentPage == index ? Colors.orange : Colors.grey,
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

  Widget _buildStressIndex(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double filledWidth = constraints.maxWidth * 0.7; // 색칠된 부분의 너비 계산

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
                      // 전체보기 클릭 시 수행할 작업 추가
                    },
                    child: const Text(
                      '전체보기',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        height: 23 / 13, // line-height
                        letterSpacing: -0.05, // letter-spacing
                        color: Color(0xFFFF5000), // #FF5000 색상 적용
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
                    height: 10,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.grey[200],
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        height: 10,
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
                    top: -5, // 아이콘을 그래프 위로 올림
                    child: Image.asset(
                      'assets/stress_icon.png',
                      height: 20,
                      width: 20,
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

  Widget _buildCategorySpending() {
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
          const Text(
            '카테고리 별 지출',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          _buildCategoryItem('음식', '-370,191원'),
          _buildCategoryItem('빅맥', '-12,000원', subLabel: '7.28'),
          _buildCategoryItem('핫밧', '-2,300원', subLabel: '7.28'),
          _buildCategoryItem('슈퍼두퍼 코엑스', '-13,300원', subLabel: '7.28'),
        ],
      ),
    );
  }

  Widget _buildCategoryItem(String label, String amount, {String subLabel = ''}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Icon(Icons.fastfood, color: Colors.orange),
              const SizedBox(width: 8),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
              if (subLabel.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(left: 4.0),
                  child: Text(
                    subLabel,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                ),
            ],
          ),
          Text(
            amount,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}
