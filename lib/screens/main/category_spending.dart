import 'package:flutter/material.dart';

class CategorySpending extends StatelessWidget {
  final String topCategory;
  final String totalAmount;
  final List<Map<String, String>> details;
  final int pageIndex; // 페이지 인덱스를 추가합니다.

  CategorySpending({
    required this.topCategory,
    required this.totalAmount,
    required this.details,
    required this.pageIndex, // 생성자에 pageIndex를 추가합니다.
  });

  @override
  Widget build(BuildContext context) {
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
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 카테고리 별 지출과 전체보기를 같은 줄에 배치
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  '카테고리 별 지출',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    // 전체보기 버튼을 눌렀을 때의 동작을 정의합니다.
                  },
                  child: Text(
                    '전체보기',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: _getPageColor(pageIndex), // 전체보기 버튼 색상을 페이지에 맞게 변경합니다.
                    ),
                  ),
                ),
              ],
            ),
            const Text(
              '이번주',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 12,
                fontWeight: FontWeight.w600,
                height: 23 / 14,
                letterSpacing: -0.05,
                color: Color(0xFFD2D2D2),
              ),
            ),
            const SizedBox(height: 16),
            // Top Category Header
            _buildCategoryItem(
              label: topCategory,
              amount: '-${totalAmount}',
              isHeader: true,
              icon: _getCategoryIcon(topCategory, pageIndex), // 페이지 인덱스에 따라 아이콘 색상을 설정합니다.
            ),
            // List of transactions under the top category
            ...details.map((detail) {
              return _buildCategoryItem(
                label: detail['businessType']!,
                amount: '-${detail['amount']}',
                subLabel: detail['date']!,
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  // 아이콘 색상을 페이지 인덱스에 따라 다르게 설정합니다.
  IconData _getCategoryIcon(String category, int pageIndex) {
    switch (category) {
      case '교통':
        return Icons.directions_car;
      case '식비':
        return Icons.fastfood;
      case '쇼핑':
        return Icons.shopping_cart;
      case '엔터테인먼트':
        return Icons.movie;
      default:
        return Icons.category;
    }
  }

  Color _getPageColor(int pageIndex) {
    switch (pageIndex) {
      case 0: // MainPage1
        return Color(0xFF00F0FF);
      case 1: // MainPage2
        return Color(0xFFFF5000);
      case 2: // MainPage3
        return Color(0xFF52A2FF);
      case 3: // MainPage4
        return Color(0xFF30B3FC);
      default:
        return Colors.orange; // 기본 색상
    }
  }

  Widget _buildCategoryItem({
    required String label,
    required String amount,
    String subLabel = '',
    bool isHeader = false,
    IconData? icon,
  }) {
    return Container(
      width: double.infinity,
      height: 71,
      decoration: BoxDecoration(
        color: isHeader ? _getPageColor(pageIndex).withOpacity(0.2) : Colors.white, // 배경색도 페이지에 따라 설정
        borderRadius: isHeader
            ? BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              )
            : BorderRadius.zero,
        border: Border.all(color: Colors.transparent),
      ),
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      margin: const EdgeInsets.only(bottom: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              if (icon != null)
                Icon(
                  icon,
                  color: _getPageColor(pageIndex), // 페이지 색상에 맞게 아이콘 색상 설정
                ),
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
