import 'package:flutter/material.dart';

class MainPage4 extends StatelessWidget {
  final int currentPage;

  MainPage4({required this.currentPage});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          pinned: true,
          expandedHeight: 429,
          flexibleSpace: FlexibleSpaceBar(
            background: Center(child: Text("Hello from Page 4")),
          ),
        ),
      ],
    );
  }
}
