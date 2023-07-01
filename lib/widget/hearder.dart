import 'package:flutter/material.dart';

class AppHeader extends StatelessWidget {
  const AppHeader({super.key, required this.title, this.size = 30});
  final String title;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: size, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
