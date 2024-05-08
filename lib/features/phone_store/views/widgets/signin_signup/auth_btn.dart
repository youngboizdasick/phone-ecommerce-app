import "package:flutter/material.dart";
import "package:phone_store_clean_architectutre/config/themes/app_pallete.dart";

import "../../../../../core/constants/constants.dart";

class ButtonWidget extends StatelessWidget {
  final Function()? onAccountBtnPressed;
  final String buttonText;

  const ButtonWidget({
    super.key,
    this.onAccountBtnPressed,
    required this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: elementSpacing),
        decoration: BoxDecoration(
          color: AppPallete.btnColor,
          borderRadius: BorderRadius.circular(radius),
        ),
        child: Center(
          child: Text(
            buttonText,
            style: const TextStyle(
              color: AppPallete.whiteColor,
              fontSize: defaultFontSize,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  void _onTap() {
    if (onAccountBtnPressed != null) {
      onAccountBtnPressed!();
    }
  }
}
