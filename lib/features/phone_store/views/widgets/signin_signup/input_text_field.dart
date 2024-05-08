import 'package:flutter/material.dart';
import 'package:phone_store_clean_architectutre/config/themes/app_pallete.dart';
import '../../../../../core/constants/constants.dart';

class InputTextFiledWidget extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final bool isObscureText;
  final TextInputAction? textInputAction;
  final bool? readOnly;

  const InputTextFiledWidget({
    super.key,
    this.controller,
    this.hintText,
    this.isObscureText = false,
    this.textInputAction = TextInputAction.next,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.emailAddress,
      textInputAction: textInputAction,
      obscureText: isObscureText,
      autocorrect: false,
      readOnly: readOnly!,
      decoration: InputDecoration(
        hintText: hintText,
        filled: readOnly!,
        fillColor: readOnly! ? AppPallete.background : AppPallete.whiteColor,
      ),
      style: const TextStyle(
        fontWeight: FontWeight.normal,
        fontSize: defaultFontSize,
      ),
    );
  }
}
