import 'package:flutter/material.dart';

import '../../../../../../config/themes/app_pallete.dart';
import '../../../../../core/constants/constants.dart';

class IconButtonWidget extends StatelessWidget {
  final IconData? icon;
  final void Function()? onPressed;
  final Color? color;
  final double? size;
  const IconButtonWidget({
    super.key,
    this.icon,
    this.onPressed,
    this.color,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(
        icon,
        color: color ?? AppPallete.blackColor,
        size: size ?? iconSize,
      ),
    );
  }
}
