import 'package:flutter/material.dart';

import '../../../../../core/constants/constants.dart';

class TextWidget extends StatelessWidget {
  final String text;
  final bool? isBold;
  final double? fontSize;
  const TextWidget(
      {super.key, required this.text, this.isBold = false, this.fontSize});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: fontSize ?? defaultFontSize,
        fontWeight: isBold == true ? FontWeight.bold : FontWeight.w500,
      ),
    );
  }
}

class DefaultTextWidget extends TextWidget {
  const DefaultTextWidget({super.key, required super.text})
      : super(fontSize: null, isBold: false);
}

class HeaderTextWidget extends TextWidget {
  const HeaderTextWidget({super.key, required super.text})
      : super(fontSize: headerFontSize, isBold: true);
}
