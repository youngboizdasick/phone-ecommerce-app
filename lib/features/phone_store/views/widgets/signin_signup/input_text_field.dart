import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:phone_store_clean_architectutre/config/themes/app_pallete.dart';
import 'package:phone_store_clean_architectutre/features/phone_store/views/screens/user/changePassword_page.dart';
import '../../../../../core/constants/constants.dart';

class InputTextFiledWidget extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final bool isObscureText;
  final TextInputAction? textInputAction;
  final bool? readOnly;
  final void Function(String)? onChanged;

  const InputTextFiledWidget({
    super.key,
    this.controller,
    this.hintText,
    this.isObscureText = false,
    this.textInputAction = TextInputAction.next,
    this.readOnly = false,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final focusNode = FocusNode();
    return TextField(
      controller: controller,
      onChanged: onChanged,
      focusNode: focusNode,
      canRequestFocus: !readOnly!,
      onTap: () => controller?.selection = TextSelection(
          baseOffset: 0, extentOffset: controller!.value.text.length),
      onTapOutside: (event) => focusNode.unfocus(),
      keyboardType: TextInputType.text,
      textInputAction: textInputAction,
      obscureText: isObscureText,
      autocorrect: false,
      readOnly: readOnly!,
      decoration: InputDecoration(
        hintText: hintText,
        filled: readOnly == true ? true : null,
        fillColor:
            readOnly == true ? AppPallete.background : AppPallete.whiteColor,
      ),
      style: const TextStyle(
        fontWeight: FontWeight.normal,
        fontSize: defaultFontSize,
      ),
    );
  }
}

class DatetimeField extends StatelessWidget {
  final TextEditingController? controller;

  const DatetimeField({super.key, this.controller});

  @override
  Widget build(BuildContext context) {
    final focusNode = FocusNode();
    return TextField(
      controller: controller,
      inputFormatters: [LengthLimitingTextInputFormatter(10)],
      onChanged: (value) => {
        value.endsWith('/')
            ? controller?.text = value.substring(0, value.length - 1)
            : (value.length == 2 || value.length == 5)
                ? controller?.text = "$value/"
                : controller?.text = value,
      },
      onTap: () => controller?.selection = TextSelection(
          baseOffset: 0, extentOffset: controller!.value.text.length),
      keyboardType: TextInputType.number,
      onTapOutside: (event) => focusNode.unfocus(),
      autocorrect: false,
      decoration: const InputDecoration(hintText: 'Nhấn để cập nhật ngày sinh'),
      style: const TextStyle(
        fontWeight: FontWeight.normal,
        fontSize: defaultFontSize,
      ),
    );
  }
}

class ChangePasswordField extends StatelessWidget {
  final TextEditingController? controller;

  const ChangePasswordField({super.key, this.controller});

  @override
  Widget build(BuildContext context) {
    final focusNode = FocusNode();
    return TextField(
      controller: controller,
      obscureText: true,
      canRequestFocus: false,
      onTapOutside: (event) => focusNode.unfocus(),
      decoration: InputDecoration(
        suffix: GestureDetector(
          onTap: () => {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ChangePassWordPage(),
              ),
            )
          },
          child: const Text(
            'Đổi mật khẩu',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                decoration: TextDecoration.underline,
                decorationThickness: 4),
          ),
        ),
      ),
      style: const TextStyle(
        fontWeight: FontWeight.normal,
        fontSize: defaultFontSize,
      ),
    );
  }
}
