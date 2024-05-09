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
    return Scaffold(
      backgroundColor: AppPallete.whiteColor,
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  _buildAppBar() {
    return const BackButtonAndTitle(
        title: HeaderTextWidget(text: 'Thông tin cá nhân'));
  }

  _buildBody() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: elementSpacing),
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            _buildUsernameField(),
            _buildPasswordField(),
            _buildNameField(),
            _buildDatetimeField(),
            _buildEmailField(),
            _buildPhoneField(),
            _buildAddressField(),
            // save button
            const ButtonWidget(buttonText: 'Lưu'),
          ],
        ),
      ),
    );
  }

  _buildUsernameField() {
    TextEditingController _usernameController =
        TextEditingController(text: 'nguyenvana');
    return Column(
      children: [
        const Row(children: [TextWidget(text: 'Tên đăng nhập', isBold: true)]),
        InputTextFiledWidget(controller: _usernameController, readOnly: true),
        const SizedBox(height: elementSpacing),
      ],
    );
  }

  _buildPasswordField() {
    TextEditingController _passwordController =
        TextEditingController(text: 'nguyen.manh');
    return Column(
      children: [
        const Row(children: [TextWidget(text: 'Mật khẩu', isBold: true)]),
        ChangePasswordField(controller: _passwordController),
        const SizedBox(height: elementSpacing),
      ],
    );
  }

  _buildNameField() {
    TextEditingController _nameController =
        TextEditingController(text: 'Nguyễn Văn A');
    return Column(
      children: [
        const Row(children: [TextWidget(text: 'Họ và tên', isBold: true)]),
        InputTextFiledWidget(controller: _nameController),
        const SizedBox(height: elementSpacing),
      ],
    );
  }

  _buildDatetimeField() {
    TextEditingController _datetimeController = TextEditingController();
    return Column(
      children: [
        const Row(children: [TextWidget(text: 'Ngày sinh', isBold: true)]),
        DatetimeField(controller: _datetimeController),
        const SizedBox(height: elementSpacing),
      ],
    );
  }

  _buildEmailField() {
    TextEditingController _emailController =
        TextEditingController(text: 'nguyenvana@gmail.com');
    return Column(
      children: [
        const Row(children: [TextWidget(text: 'Email', isBold: true)]),
        InputTextFiledWidget(
          controller: _emailController,
          readOnly: true,
        ),
        const SizedBox(height: elementSpacing),
      ],
    );
  }

  _buildPhoneField() {
    TextEditingController _phoneController =
        TextEditingController(text: '0123456789');
    return Column(
      children: [
        const Row(children: [TextWidget(text: 'Số điện thoại', isBold: true)]),
        InputTextFiledWidget(
          controller: _phoneController,
          readOnly: true,
        ),
        const SizedBox(height: elementSpacing),
      ],
    );
  }

  _buildAddressField() {
    TextEditingController _addressController =
        TextEditingController(text: 'Đường A1, phường B2, quận C3, Tp. HCM');
    return Column(
      children: [
        const Row(children: [TextWidget(text: 'Địa chỉ', isBold: true)]),
        InputTextFiledWidget(
          controller: _addressController,
          hintText: 'Phường/Xã, Quận/Huyện, Thành phố/Tỉnh',
        ),
        const SizedBox(height: elementSpacing),
      ],
    );
  }
}
