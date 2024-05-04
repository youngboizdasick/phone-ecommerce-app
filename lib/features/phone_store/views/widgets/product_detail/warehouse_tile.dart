import 'package:flutter/material.dart';

import '../../../../../../config/themes/app_pallete.dart';
import '../../../../../core/constants/constants.dart';

class WarehouseTile extends StatelessWidget {
  final String address;
  final Color color;
  const WarehouseTile({super.key, required this.address, required this.color});

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    double widthCard = (widthScreen - elementSpacing * 2);
    return Container(
      width: widthCard,
      decoration: BoxDecoration(
        color: color,
      ),
      child: _buildLabel(),
    );
  }

  _buildLabel() {
    return Text(
      address,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(
        fontSize: defaultFontSize,
        fontWeight: FontWeight.w500,
        color: AppPallete.btnColor,
        decoration: TextDecoration.underline,
        decorationColor: AppPallete.btnColor,
      ),
    );
  }
}
