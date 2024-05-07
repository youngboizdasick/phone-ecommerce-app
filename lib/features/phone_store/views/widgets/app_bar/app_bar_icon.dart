import 'package:flutter/material.dart';

import '../../../../../../config/themes/app_pallete.dart';
import '../../../../../core/constants/constants.dart';

class IconButtonWidget extends StatelessWidget {
  final IconData? icon;
  final void Function()? onPressed;
  const IconButtonWidget({
    super.key,
    this.icon,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(icon),
      iconSize: iconSize,
      color: AppPallete.blackColor,
    );
  }
}
