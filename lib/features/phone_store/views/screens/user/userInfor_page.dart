import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:phone_store_clean_architectutre/config/themes/app_pallete.dart';
import 'package:phone_store_clean_architectutre/core/constants/constants.dart';
import 'package:phone_store_clean_architectutre/features/phone_store/models/customer.dart';
import 'package:phone_store_clean_architectutre/features/phone_store/services/api_services.dart';
import 'package:phone_store_clean_architectutre/features/phone_store/views/widgets/app_bar/app_bar_custom.dart';
import 'package:phone_store_clean_architectutre/features/phone_store/views/widgets/signin_signup/auth_btn.dart';
import 'package:phone_store_clean_architectutre/features/phone_store/views/widgets/signin_signup/input_text_field.dart';
import 'package:phone_store_clean_architectutre/features/phone_store/views/widgets/text_format/text_widget.dart';

class UserInfoPage extends StatefulWidget {
  const UserInfoPage({super.key});

  @override
  State<UserInfoPage> createState() => _UserInfoPageState();
}

class _UserInfoPageState extends State<UserInfoPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _birthdayController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
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
    ApiServices apiServices = ApiServices();
    final information = apiServices.getCustomerInformation();
    return FutureBuilder<CustomerModel?>(
      future: information,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: Text(
              'Đang tải',
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
          );
        }

        final information = snapshot.data!;

        if (information.customerAddresses?.isEmpty == true ||
            information.customerPhones?.isEmpty == true) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: elementSpacing),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  // _buildUsernameField(),
                  // _buildPasswordField(),
                  _buildEmailField(information.email),
                  _buildNameField(information.name),
                  _buildDatetimeField(
                      convertEpochMilliToDate(information.birthday)),
                  _buildPhoneField(null),
                  _buildAddressField(null),
                  // save button
                  ButtonWidget(
                    buttonText: 'Lưu',
                    onAccountBtnPressed:() => _onSavedInformation(context),
                  ),
                ],
              ),
            ),
          );
        }

        String? primaryPhone =
            getPrimaryPhone(information.customerPhones)!.phoneNumber;
        String? primaryAdress =
            formatAddress(getPrimaryAddress(information.customerAddresses));

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: elementSpacing),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                // _buildUsernameField(),
                // _buildPasswordField(),
                _buildEmailField(information.email),
                _buildNameField(information.name),
                _buildDatetimeField(
                    convertEpochMilliToDate(information.birthday)),
                _buildPhoneField(primaryPhone),
                _buildAddressField(primaryAdress),
                // save button
                const ButtonWidget(buttonText: 'Lưu'),
              ],
            ),
          ),
        );
      },
    );
  }

  // _buildUsernameField() {
  _buildNameField(String? name) {
    _nameController = TextEditingController(text: name ?? '');
    return Column(
      children: [
        const Row(children: [TextWidget(text: 'Họ và tên', isBold: true)]),
        InputTextFiledWidget(controller: _nameController),
        const SizedBox(height: elementSpacing),
      ],
    );
  }

  _buildDatetimeField(String? birthday) {
    _birthdayController = TextEditingController(text: birthday ?? '');
    return Column(
      children: [
        const Row(children: [TextWidget(text: 'Ngày sinh', isBold: true)]),
        DatetimeField(controller: _birthdayController),
        const SizedBox(height: elementSpacing),
      ],
    );
  }

  _buildEmailField(String? email) {
    _emailController = TextEditingController(text: email ?? '');
    return Column(
      children: [
        const Row(children: [TextWidget(text: 'Email', isBold: true)]),
        InputTextFiledWidget(controller: _emailController),
        const SizedBox(height: elementSpacing),
      ],
    );
  }

  _buildPhoneField(String? phone) {
    _phoneController = TextEditingController(text: phone ?? '');
    return Column(
      children: [
        const Row(children: [TextWidget(text: 'Số điện thoại', isBold: true)]),
        InputTextFiledWidget(
          readOnly: true,
          controller: _phoneController,
          hintText: 'Nhấn để cập nhật số điện thoại',
        ),
        const SizedBox(height: elementSpacing),
      ],
    );
  }

  _buildAddressField(String? address) {
    _addressController = TextEditingController(text: address ?? '');
    return Column(
      children: [
        const Row(
            children: [TextWidget(text: 'Địa chỉ giao hàng', isBold: true)]),
        InputTextFiledWidget(
          readOnly: true,
          controller: _addressController,
          hintText: 'Nhấn để cập nhật địa chỉ giao hàng',
        ),
        const SizedBox(height: elementSpacing),
      ],
    );
  }

  String convertEpochMilliToDate(int? epochMilli) {
    // Create a DateTime object from the milliseconds since epoch
    DateTime date = DateTime.fromMillisecondsSinceEpoch(epochMilli ?? 0);

    // Format the date in the desired format ("dd/MM/yyyy")
    DateFormat formatter = DateFormat('dd/MM/yyyy');
    String formattedDate = formatter.format(date);

    return formattedDate;
  }

  CustomerAddresses? getPrimaryAddress(List<CustomerAddresses>? addresses) {
    return addresses?.firstWhere((address) => address.isPrimary == true);
  }

  String? formatAddress(CustomerAddresses? addressData) {
    List<String> addressComponents = [
      addressData?.address ?? '',
      addressData?.ward?.name ?? '',
      addressData?.district?.name ?? '',
      addressData?.province?.name ?? '',
    ];
    return addressComponents.join(', ');
  }

  CustomerPhones? getPrimaryPhone(List<CustomerPhones>? phones) {
    return phones?.firstWhere((phone) => phone.isPrimary == true);
  }

  int convertBirthdayToEpochMilli(String birthdayString) {
    DateTime parsedDate = DateFormat('dd/MM/yyyy').parse(birthdayString);
    String formattedDateString = DateFormat('yyyy-MM-dd').format(parsedDate);
    DateTime birthday = DateTime.parse(formattedDateString);
    int epochMilli = birthday.millisecondsSinceEpoch;
    return epochMilli;
  }

  _onSavedInformation(BuildContext context) {
    ApiServices apiServices = ApiServices();
    final isSuccess = apiServices.changeInformation(
      name: _nameController.text.trim(),
      email: _emailController.text.trim(),
      birthday: convertBirthdayToEpochMilli(_birthdayController.text.trim()),
    );

    isSuccess.then(
      (value) => value
          ? setState(() {})
          : ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: DefaultTextWidget(text: 'Có lỗi xảy ra. Thử lại sau.'))),
    );
  }
}
