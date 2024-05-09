import 'package:flutter/material.dart';
import 'package:phone_store_clean_architectutre/config/themes/app_pallete.dart';
import 'package:phone_store_clean_architectutre/core/constants/constants.dart';
import 'package:phone_store_clean_architectutre/features/phone_store/views/widgets/app_bar/app_bar_custom.dart';
import 'package:phone_store_clean_architectutre/features/phone_store/views/widgets/signin_signup/auth_btn.dart';
import 'package:phone_store_clean_architectutre/features/phone_store/views/widgets/signin_signup/input_text_field.dart';
import 'package:phone_store_clean_architectutre/features/phone_store/views/widgets/text_format/text_widget.dart';

class ChangePassWordPage extends StatelessWidget {
  const ChangePassWordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppPallete.whiteColor,
      appBar: _buildAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: elementSpacing),
        child: Column(
          children: [
            _buildCurrentPwdField(),
            _buildNewPwdField(),
            _buildConfirmPwdField(),
            // change password button
            const ButtonWidget(buttonText: 'Đổi mật khẩu'),
          ],
        ),
      ),
    );
  }

  _buildAppBar() {
    return const BackButtonAndTitle(
        title: HeaderTextWidget(text: 'Đổi mật khẩu'));
  }

  _buildCurrentPwdField() {
    TextEditingController _passwordController =
        TextEditingController(text: 'nguyen.manh');
    return Column(
      children: [
        const Row(
            children: [TextWidget(text: 'Mật khẩu hiện tại', isBold: true)]),
        InputTextFiledWidget(
            controller: _passwordController),
        const SizedBox(height: elementSpacing),
      ],
    );
  }

  _buildNewPwdField() {
    TextEditingController _newPwdController = TextEditingController();
    return Column(
      children: [
        const Row(children: [TextWidget(text: 'Mật khẩu mới', isBold: true)]),
        InputTextFiledWidget(controller: _newPwdController,),
        const SizedBox(height: elementSpacing),
      ],
    );
  }

  _buildConfirmPwdField() {
    TextEditingController _confirmPwdController = TextEditingController();
    return Column(
      children: [
        const Row(children: [
          TextWidget(text: 'Nhập lại mật khẩu mới', isBold: true)
        ]),
        InputTextFiledWidget(controller: _confirmPwdController),
        const SizedBox(height: elementSpacing),
      ],
    );
  }
}
