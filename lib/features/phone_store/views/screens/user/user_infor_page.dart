import 'package:flutter/material.dart';
import 'package:phone_store_clean_architectutre/config/themes/app_pallete.dart';
import 'package:phone_store_clean_architectutre/core/constants/constants.dart';
import 'package:phone_store_clean_architectutre/features/phone_store/views/widgets/app_bar/app_bar_custom.dart';
import 'package:phone_store_clean_architectutre/features/phone_store/views/widgets/signin_signup/auth_btn.dart';
import 'package:phone_store_clean_architectutre/features/phone_store/views/widgets/signin_signup/input_text_field.dart';
import 'package:phone_store_clean_architectutre/features/phone_store/views/widgets/text_format/text_widget.dart';

class UserInfoPage extends StatelessWidget {
  const UserInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController _usernameController = TextEditingController(text: 'nguyenvana');
    TextEditingController _passwordController = TextEditingController(text: '********');
    TextEditingController _nameController = TextEditingController(text: 'Nguyễn Văn A');
    TextEditingController _emailController = TextEditingController(text: 'nguyenvana@gmail.com');
    TextEditingController _phoneController = TextEditingController(text: '0123456789');
    TextEditingController _addressController = TextEditingController(text: 'Đường A1, phường B2, quận C3, Tp. HCM');
    return Scaffold(
      backgroundColor: AppPallete.whiteColor,
      appBar: BackButtonAndTitle(
          title: HeaderTextWidget(text: 'Thông tin cá nhân')),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: elementSpacing),
        child: Column(
          children: [
            InputTextFiledWidget(controller: _usernameController, readOnly: true),
            SizedBox(height: elementSpacing),
            InputTextFiledWidget(controller: _passwordController),
            SizedBox(height: elementSpacing),
            InputTextFiledWidget(controller: _nameController),
            SizedBox(height: elementSpacing),
            InputTextFiledWidget(controller: _emailController),
            SizedBox(height: elementSpacing),
            InputTextFiledWidget(controller: _phoneController),
            SizedBox(height: elementSpacing),
            InputTextFiledWidget(controller: _addressController),
            SizedBox(height: elementSpacing),
            ButtonWidget(buttonText: 'Lưu'),
          ],
        ),
      ),
    );
  }
}
