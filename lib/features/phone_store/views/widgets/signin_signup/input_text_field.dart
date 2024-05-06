import 'package:flutter/material.dart';
import '../../../../../core/constants/constants.dart';

class InputTextFiledWidget extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final bool isObscureText;
  final TextInputAction? textInputAction;

  const InputTextFiledWidget({
    super.key,
    required this.controller,
    required this.hintText,
    this.isObscureText = false,
    this.textInputAction = TextInputAction.next
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.emailAddress,
      textInputAction: textInputAction,
      obscureText: isObscureText,
      autocorrect: false,
      decoration: InputDecoration(hintText: hintText),
      style: const TextStyle(
        fontWeight: FontWeight.normal,
        fontSize: defaultFontSize,
      ),
    );
  }
}
