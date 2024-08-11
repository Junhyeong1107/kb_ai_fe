import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'category_spending.dart';

class CategorySpendingPage extends StatefulWidget {
  final int pageIndex; // 페이지 인덱스를 추가합니다.

  CategorySpendingPage({required this.pageIndex}); // 생성자에서 pageIndex를 받습니다.

  @override
  _CategorySpendingPageState createState() => _CategorySpendingPageState();
}

class _CategorySpendingPageState extends State<CategorySpendingPage> {
  String? topCategory;
  String? totalAmount;
  List<Map<String, String>> details = [];

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    try {
      final response = await http.get(Uri.parse(
          'http://43.200.7.249:8080/csv/data?referenceDate=2023-01-18'));

      if (response.statusCode == 200) {
        // UTF-8로 디코딩하여 한글이 깨지지 않도록 처리
        final data = json.decode(utf8.decode(response.bodyBytes))
            as Map<String, dynamic>;

        // Parsing weeklyData
        final weeklyData = data['weeklyData'] as Map<String, dynamic>;

        // Use first key in weeklyData (assuming there is only one week in this example)
        final firstKey = weeklyData.keys.first;
        final weekData = weeklyData[firstKey] as Map<String, dynamic>;

        setState(() {
          topCategory = weekData['topCategory'] as String?;
          totalAmount = '${weekData['totalAmount']}원';

          details = (weekData['details'] as List<dynamic>).map((item) {
            final itemMap = item as Map<String, dynamic>;
            return {
              'businessType': itemMap['businessType'] as String,
              'amount': '${itemMap['amount']}원',
              'date': itemMap['date'] as String,
            };
          }).toList();
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: topCategory != null && totalAmount != null
          ? CategorySpending(
              topCategory: topCategory!,
              totalAmount: totalAmount!,
              details: details,
              pageIndex: widget.pageIndex, // pageIndex를 전달합니다.
            )
          : Center(child: CircularProgressIndicator()),
    );
  }
}
