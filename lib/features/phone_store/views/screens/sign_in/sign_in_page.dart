import "package:flutter/material.dart";
import 'package:bootstrap_icons/bootstrap_icons.dart';
import "package:flutter_bloc/flutter_bloc.dart";
import "package:phone_store_clean_architectutre/features/phone_store/blocs/login/login_bloc.dart";
import "package:phone_store_clean_architectutre/features/phone_store/data_sources/api_services.dart";
import "package:phone_store_clean_architectutre/features/phone_store/views/widgets/bottom_nav_bar/bottom_tab_bar.dart";
import "package:phone_store_clean_architectutre/features/phone_store/views/widgets/default_text.dart";
import "../../../../../../config/themes/app_pallete.dart";
import "../../../../../core/constants/constants.dart";
import "../../widgets/auth_btn.dart";
import "../../widgets/input_text_field.dart";

class SignInPage extends StatefulWidget {
  final void Function()? onTap;
  const SignInPage({super.key, required this.onTap});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  ApiServices auth = ApiServices();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppPallete.blackColor,
      body: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: DefaultTextWidget(text: state.error)));
          }
          if (state is LoginSuccess) {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const BottomTabBar(),
                ),
                (route) => false);
          }
        },
        builder: (context, state) {
          if (state is LoginLoading) {
            // do nothing
          }
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildLogoAndTitle(),
                _buildAuthFieldAndButton(),
                _buildRegistrationPrompt(),
              ],
            ),
          );
        },
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
          'SPhone'.toUpperCase(),
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
          // sign in button
          AuthButtonWidget(
            onAccountBtnPressed: () => _onLoginPressed(),
            buttonText: 'Đăng nhập',
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
                'Chưa có tài khoản? ',
                style: TextStyle(
                  fontSize: defaultFontSize,
                  fontWeight: FontWeight.normal,
                  color: AppPallete.whiteColor,
                ),
              ),
              GestureDetector(
                onTap: widget.onTap,
                child: const Text(
                  'Đăng ký',
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

  void _onLoginPressed() {
    context.read<LoginBloc>().add(
          LoginRequested(
            username: _usernameController.text.trim(),
            password: _passwordController.text.trim(),
          ),
        );
  }
}
