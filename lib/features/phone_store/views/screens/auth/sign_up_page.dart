import "package:bootstrap_icons/bootstrap_icons.dart";
import "package:flutter/material.dart";
import "../../../../../../config/themes/app_pallete.dart";
import "../../../../../core/constants/constants.dart";
import "../../widgets/signin_signup/auth_btn.dart";
import "../../widgets/signin_signup/input_text_field.dart";

class SignUpPage extends StatefulWidget {
  final void Function()? onTap;
  const SignUpPage({super.key, required this.onTap});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppPallete.blackColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildLogoAndTitle(),
            _buildAuthFieldAndButton(),
            _buildRegistrationPrompt(),
          ],
        ),
      ),
    );
  }

  _buildLogoAndTitle() {
    return Column(
      children: [
        // Logo Icon
        const Icon(
          BootstrapIcons.shop,
          size: logoSize,
          color: AppPallete.whiteColor,
        ),
        // Title Shop
        Text(
          'Thành viên mới'.toUpperCase(),
          style: const TextStyle(
            fontSize: titleLogoSize,
            fontWeight: FontWeight.bold,
            color: AppPallete.whiteColor,
          ),
        ),
        const SizedBox(height: elementSpacing),
      ],
    );
  }

  _buildAuthFieldAndButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: elementSpacing),
      child: Column(
        children: [
          // username field
          InputTextFiledWidget(
            controller: _usernameController,
            hintText: 'Số điện thoại hoặc Email',
          ),
          const SizedBox(height: elementSpacing),
          // password field
          InputTextFiledWidget(
            controller: _passwordController,
            hintText: 'Mật khẩu',
            isObscureText: true,
          ),
          const SizedBox(height: elementSpacing),
          // confirm password field
          InputTextFiledWidget(
            controller: _confirmPasswordController,
            hintText: 'Xác nhận mật khẩu',
            isObscureText: true,
            textInputAction: TextInputAction.done,
          ),
          const SizedBox(height: elementSpacing),
          // sign up button
          AuthButtonWidget(
            onAccountBtnPressed: () => _onAccountBtnPressed,
            buttonText: 'Đăng ký',
          ),
          const SizedBox(height: elementSpacing),
        ],
      ),
    );
  }

  _buildRegistrationPrompt() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: elementSpacing),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Text(
                'Đã có tài khoản? ',
                style: TextStyle(
                  fontSize: defaultFontSize,
                  fontWeight: FontWeight.normal,
                  color: AppPallete.whiteColor,
                ),
              ),
              GestureDetector(
                onTap: widget.onTap,
                child: const Text(
                  'Đăng nhập',
                  style: TextStyle(
                    fontSize: defaultFontSize,
                    fontWeight: FontWeight.bold,
                    color: AppPallete.btnColor,
                    decoration: TextDecoration.underline,
                    decorationColor: AppPallete.btnColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _onAccountBtnPressed(BuildContext context) {}
}
