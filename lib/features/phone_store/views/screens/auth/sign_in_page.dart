import "package:flutter/material.dart";
import 'package:bootstrap_icons/bootstrap_icons.dart';
import "package:flutter_bloc/flutter_bloc.dart";
import "package:phone_store_clean_architectutre/features/phone_store/blocs/login/login_bloc.dart";
import "package:phone_store_clean_architectutre/features/phone_store/services/api_services.dart";
import "package:phone_store_clean_architectutre/features/phone_store/services/firebase_auth/auth_service.dart";
import "package:phone_store_clean_architectutre/features/phone_store/views/screens/user/user_page.dart";
import "package:phone_store_clean_architectutre/features/phone_store/views/widgets/bottom_nav_bar/bottom_tab_bar.dart";
import "package:phone_store_clean_architectutre/features/phone_store/views/widgets/text_format/text_widget.dart";
import "../../../../../../config/themes/app_pallete.dart";
import "../../../../../core/constants/constants.dart";
import "../../widgets/signin_signup/auth_btn.dart";
import "../../widgets/signin_signup/input_text_field.dart";

class SignInPage extends StatefulWidget {
  final void Function()? onTap;
  const SignInPage({super.key, required this.onTap});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController _usernameController = TextEditingController(text: 'test2@gmail.com');
  final TextEditingController _passwordController = TextEditingController(text: '123');
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
            auth.storeUsername(_usernameController.text.trim());
            auth.storePwd(_passwordController.text.trim());
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
                _buildOrUseOption(),
                _buildLoginUsingOtherOption(),
                const SizedBox(height: elementSpacing),
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
            textInputAction: TextInputAction.done,
          ),
          const SizedBox(height: elementSpacing),
          // sign in button
          ButtonWidget(
            onAccountBtnPressed: () => _onLoginPressed(),
            buttonText: 'Đăng nhập',
          ),
          const SizedBox(height: elementSpacing),
        ],
      ),
    );
  }

  _buildRegistrationPrompt() {
    return Padding(
      padding: const EdgeInsets.only(right: elementSpacing),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
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
    );
  }

  _buildOrUseOption() {
    return const Padding(
      padding: EdgeInsets.only(
        bottom: elementSpacing,
        right: elementSpacing,
        left: elementSpacing,
      ),
      child: Row(
        children: [
          Expanded(
            child: Divider(
              color: AppPallete.whiteColor,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: elementSpacing),
            child: TextWidget(
              text: 'Hoặc sử dụng',
              color: AppPallete.whiteColor,
              isBold: true,
            ),
          ),
          Expanded(
            child: Divider(
              color: AppPallete.whiteColor,
            ),
          ),
        ],
      ),
    );
  }

  _buildLoginUsingOtherOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildOptionGoogleAccount(),
      ],
    );
  }

  _buildOptionGoogleAccount() {
    return GestureDetector(
      onTap: () => _onLoginUsingGoogleAccount(),
      child: Container(
        decoration: BoxDecoration(
          color: AppPallete.whiteColor,
          borderRadius: BorderRadius.circular(radius),
        ),
        child: Padding(
          padding: const EdgeInsets.all(elementSpacing / 2),
          child: Image.asset('./assets/google.png', height: 50),
        ),
      ),
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

  _onLoginUsingGoogleAccount() async {
    if (await AuthService().signInWithGoogle() != null) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const UserPage(),
          ),
          (route) => false);
    }
  }
}
