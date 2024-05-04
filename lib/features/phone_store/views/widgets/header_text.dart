import 'package:flutter/material.dart';

import '../../../../core/constants/constants.dart';

class HeaderTextWidget extends StatelessWidget {
  final String text;
  const HeaderTextWidget({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontSize: headerFontSize,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}