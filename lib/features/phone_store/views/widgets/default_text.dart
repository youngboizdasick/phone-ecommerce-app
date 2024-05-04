import 'package:flutter/material.dart';

import '../../../../core/constants/constants.dart';

class DefaultTextWidget extends StatelessWidget {
  final String text;
  const DefaultTextWidget({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontSize: defaultFontSize,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
