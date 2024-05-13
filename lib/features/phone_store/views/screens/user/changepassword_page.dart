import 'package:flutter/material.dart';
import 'package:phone_store_clean_architectutre/config/themes/app_pallete.dart';
import 'package:phone_store_clean_architectutre/core/constants/constants.dart';
import 'package:phone_store_clean_architectutre/features/phone_store/services/api_services.dart';
import 'package:phone_store_clean_architectutre/features/phone_store/views/widgets/app_bar/app_bar_custom.dart';
import 'package:phone_store_clean_architectutre/features/phone_store/views/widgets/signin_signup/auth_btn.dart';
import 'package:phone_store_clean_architectutre/features/phone_store/views/widgets/signin_signup/input_text_field.dart';
import 'package:phone_store_clean_architectutre/features/phone_store/views/widgets/text_format/text_widget.dart';

import '../auth/signin_or_signup.dart';

class ChangePassWordPage extends StatefulWidget {
  const ChangePassWordPage({super.key});

  @override
  State<ChangePassWordPage> createState() => _ChangePassWordPageState();
}

class _ChangePassWordPageState extends State<ChangePassWordPage> {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController newPwdController = TextEditingController();
  final TextEditingController confirmPwdController = TextEditingController();

  @override
  void dispose() {
    passwordController.dispose();
    newPwdController.dispose();
    confirmPwdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppPallete.whiteColor,
      appBar: _buildAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: elementSpacing),
        child: Column(
          children: [
            _buildCurrentPwdField(passwordController),
            _buildNewPwdField(newPwdController),
            _buildConfirmPwdField(confirmPwdController),
            // change password button
            ButtonWidget(
                buttonText: 'Đổi mật khẩu',
                onAccountBtnPressed: () => _onTapChangePwd(context)),
          ],
        ),
      ),
    );
  }

  _buildAppBar() {
    return const BackButtonAndTitle(
        title: HeaderTextWidget(text: 'Đổi mật khẩu'));
  }

  _buildCurrentPwdField(TextEditingController passwordController) {
    return Column(
      children: [
        const Row(
            children: [TextWidget(text: 'Mật khẩu hiện tại', isBold: true)]),
        InputTextFiledWidget(controller: passwordController),
        const SizedBox(height: elementSpacing),
      ],
    );
  }

  _buildNewPwdField(TextEditingController newPwdController) {
    return Column(
      children: [
        const Row(children: [TextWidget(text: 'Mật khẩu mới', isBold: true)]),
        InputTextFiledWidget(controller: newPwdController),
        const SizedBox(height: elementSpacing),
      ],
    );
  }

  _buildConfirmPwdField(TextEditingController confirmPwdController) {
    return Column(
      children: [
        const Row(children: [
          TextWidget(text: 'Nhập lại mật khẩu mới', isBold: true)
        ]),
        InputTextFiledWidget(controller: confirmPwdController),
        const SizedBox(height: elementSpacing),
      ],
    );
  }

  _onTapChangePwd(BuildContext context) async {
    ApiServices apiServices = ApiServices();
    if (passwordController.text.trim().isEmpty ||
        newPwdController.text.trim().isEmpty ||
        confirmPwdController.text.trim().isEmpty) {
      return ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content:
              DefaultTextWidget(text: 'Vui lòng không bỏ trống thông tin')));
    }
    String? currentPwd = await apiServices.getPassword();
    if (passwordController.text.trim() != currentPwd) {
      return ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: DefaultTextWidget(text: 'Sai mật khẩu cũ')));
    }
    if (newPwdController.text.trim() != confirmPwdController.text.trim()) {
      return ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: DefaultTextWidget(text: 'Nhập lại mật khẩu không khớp')));
    }
    bool isSuccess = await apiServices.changePwd(newPwdController.text.trim());
    if (isSuccess) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: DefaultTextWidget(
              text:
                  'Đổi mật khẩu thành công. Đăng xuất sau giây lát.'),
        ),
      );
      Future.delayed(const Duration(seconds: 4), () {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const SignInOrSignUp(),
          ),
          (route) => false,
        );
      });
      return;
    }

    return ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: DefaultTextWidget(
            text: 'Có lỗi xảy ra, vui lòng thử lại sau giây lát.'),
      ),
    );
  }
}
