import 'package:flutter/material.dart';

import '../../../../core/constants/constants.dart';

class InputTextFiledWidget extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final bool isObscureText;

  const InputTextFiledWidget({
    super.key,
    required this.controller,
    required this.hintText,
    this.isObscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
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
