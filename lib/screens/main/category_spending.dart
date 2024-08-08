import 'package:flutter/material.dart';

class CategorySpending extends StatelessWidget {
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
          _buildCategoryItem('음식', '-370,191원', isHeader: true),
          _buildCategoryItem('빅맥', '-12,000원', subLabel: '7.28'),
          _buildCategoryItem('핫밧', '-2,300원', subLabel: '7.28'),
          _buildCategoryItem('슈퍼두퍼 코엑스', '-13,300원', subLabel: '7.28'),
        ],
      ),
    );
  }

  Widget _buildCategoryItem(String label, String amount, {String subLabel = '', bool isHeader = false}) {
    return Container(
      width: 349,
      height: 71,
      decoration: BoxDecoration(
        color: isHeader ? Color(0xFFFFF6EC) : Colors.white,
        borderRadius: isHeader ? BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ) : BorderRadius.zero,
        border: isHeader ? Border.all(color: Colors.transparent) : Border.all(color: Colors.transparent),
      ),
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      margin: const EdgeInsets.only(bottom: 4.0), // Adds spacing between items
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                Icons.fastfood,
                color: isHeader ? Colors.orange : Colors.transparent, // 첫 번째 항목에만 아이콘 색상 적용
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
