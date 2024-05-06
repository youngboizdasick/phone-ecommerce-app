import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../../config/themes/app_pallete.dart';

class FormatPrice extends StatelessWidget {
  final int price;
  final double? fontSize;
  final Color? color;
  const FormatPrice({
    super.key,
    required this.price,
    this.fontSize,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    NumberFormat numberFormat = NumberFormat('#,##0');
    return Text(
      '${numberFormat.format(price.ceil()).replaceAll(',', '.')} đ',
      style: TextStyle(
        color: color ?? AppPallete.btnColor,
        fontWeight: FontWeight.bold,
        fontSize: fontSize ?? 14,
      ),
    );
  }
}
