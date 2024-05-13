import 'package:flutter/material.dart';
import 'package:notification_center/notification_center.dart';

import '../../../../../config/themes/app_pallete.dart';
import '../../../../../core/constants/constants.dart';

class ProductLineView extends StatefulWidget {
  final String? code;
  final String? title;
  const ProductLineView({super.key, this.code, this.title});

  @override
  State<ProductLineView> createState() => _ProductLineViewState();
}

class _ProductLineViewState extends State<ProductLineView> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {
        _toggleBorderColor(),
        NotificationCenter().notify<String>(
          'sendProductLineId',
          data: widget.code,
        ),
        Future.delayed(const Duration(seconds: 2), _toggleBorderColor),
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: MediaQuery.of(context).size.width / 4,
            alignment: Alignment.center,
            padding: const EdgeInsets.all(elementSpacing),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(radius),
                color: AppPallete.whiteColor,
                border: Border.all(color: borderColor, width: 2)),
          ),
          Text(widget.title!)
        ],
      ),
    );
  }

  Color borderColor = AppPallete.whiteColor;

  _toggleBorderColor() {
    setState(() {
      borderColor = borderColor == AppPallete.whiteColor
          ? AppPallete.btnColor
          : AppPallete.whiteColor;
    });
  }
}
