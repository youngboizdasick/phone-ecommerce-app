import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notification_center/notification_center.dart';
import 'package:phone_store_clean_architectutre/features/phone_store/models/customer.dart';
import 'package:phone_store_clean_architectutre/features/phone_store/views/screens/user/address_phone/district_picker.dart';
import 'package:phone_store_clean_architectutre/features/phone_store/views/screens/user/address_phone/ward_picker.dart';
import 'package:phone_store_clean_architectutre/features/phone_store/views/widgets/app_bar/app_bar_custom.dart';

import '../../../../../../config/themes/app_pallete.dart';
import '../../../../../../core/constants/constants.dart';
import '../../../../models/address.dart';
import '../../../../services/api_services.dart';
import '../../../widgets/signin_signup/auth_btn.dart';
import '../../../widgets/signin_signup/input_text_field.dart';
import '../../../widgets/text_format/text_widget.dart';

class FixPage extends StatefulWidget {
  final CustomerAddresses customerAddresses;
  final CustomerPhones customerPhones;
  final bool isPrimary;
  const FixPage({
    super.key,
    required this.customerAddresses,
    required this.customerPhones,
    required this.isPrimary,
  });

  @override
  State<FixPage> createState() => _FixPageState();
}

class _FixPageState extends State<FixPage> {
  TextEditingController _addressController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  int selectedIndex = 0;
  int? wardCode;
  int? districtCode;
  int? provinceCode;
  @override
  Widget build(BuildContext context) {
    double heightTitleAddress = MediaQuery.of(context).size.height * 0.03;
    double heightValueAddress = MediaQuery.of(context).size.height * 0.047;
    return Scaffold(
      backgroundColor: AppPallete.whiteColor,
      appBar: _buildAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(elementSpacing),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPhoneField(),
            _buildAddressField(),
            Row(
              children: [
                _buildWardField(heightTitleAddress, heightValueAddress),
                _buildDistrictField(heightTitleAddress, heightValueAddress),
                _buildProvinceField(heightTitleAddress, heightValueAddress),
              ],
            ),
            SizedBox(height: elementSpacing),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 20,
                  height: 20,
                  child: Checkbox(
                    value: isChecked,
                    checkColor: AppPallete.background,
                    activeColor: AppPallete.btnColor,
                    onChanged: (value) => {
                      setState(() {
                        isChecked = value!;
                      }),
                    },
                  ),
                ),
                SizedBox(width: elementSpacing / 2),
                TextWidget(
                  text: 'Đặt làm địa chỉ mặc định',
                  fontSize: 18,
                )
              ],
            ),
            SizedBox(height: elementSpacing),
            ButtonWidget(
              buttonText: 'Xong',
              onAccountBtnPressed: () => _onTapSaveChange(),
            )
          ],
        ),
      ),
    );
  }

  _buildAppBar() {
    return BackButtonAndTitle(
      title: HeaderTextWidget(
        text: 'Sửa thông tin giao hàng',
      ),
    );
  }

  _buildPhoneField() {
    return Column(
      children: [
        TextWidget(text: 'Số điện thoại'),
        InputTextFiledWidget(
          controller: _phoneController,
          hintText: 'Số điện thoại',
        ),
        SizedBox(height: elementSpacing),
      ],
    );
  }

  _buildAddressField() {
    return Column(children: [
      TextWidget(text: 'Số nhà, Đường'),
      InputTextFiledWidget(
        controller: _addressController,
        hintText: 'Số nhà, Đường. Ví dụ: Số 99, Đường A',
      ),
      SizedBox(height: elementSpacing),
    ]);
  }

  _buildWardField(double heightTitleAddress, double heightValueAddress) {
    return Expanded(
      flex: 1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: heightTitleAddress,
            child: TextWidget(text: 'Phường/Xã'),
          ),
          SizedBox(
            height: heightValueAddress,
            child: WardPickerView(),
          ),
        ],
      ),
    );
  }

  _buildDistrictField(double heightTitleAddress, double heightValueAddress) {
    return Expanded(
      flex: 1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: heightTitleAddress,
            child: TextWidget(text: 'Quận/Huyện'),
          ),
          SizedBox(
            height: heightValueAddress,
            child: DistrictPickerView(),
          ),
        ],
      ),
    );
  }

  _buildProvinceField(double heightTitleAddress, double heightValueAddress) {
    return Expanded(
      flex: 1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: heightTitleAddress,
            child: TextWidget(text: 'Thành phố/Tỉnh'),
          ),
          SizedBox(
            height: heightValueAddress,
            child: _buildProvincePicker(),
          )
        ],
      ),
    );
  }

  void _showDialog(Widget child) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => Container(
        height: 216,
        padding: const EdgeInsets.only(top: 6.0),
        // The Bottom margin is provided to align the popup above the system navigation bar.
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        // Provide a background color for the popup.
        color: CupertinoColors.systemBackground.resolveFrom(context),
        // Use a SafeArea widget to avoid system overlaps.
        child: SafeArea(
          top: false,
          child: child,
        ),
      ),
    );
  }

  _buildProvincePicker() {
    ApiServices apiServices = ApiServices();
    final provinces = apiServices.getListProvince();
    return FutureBuilder<List<AddressModel>?>(
      future: provinces,
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
        final provinces = snapshot.data!;
        return CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () => _showDialog(
            CupertinoPicker(
              useMagnifier: true,
              magnification: 1.2,
              itemExtent: 32,
              onSelectedItemChanged: (index) {
                setState(() {
                  selectedIndex = index;
                  NotificationCenter().notify<int>('provinceSelected',
                      data: provinces[selectedIndex].code);
                });
              },
              children:
                  provinces.map((province) => Text(province.name!)).toList(),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(right: elementSpacing),
            child: TextWidget(
              text: provinces[selectedIndex].name!,
              color: AppPallete.btnColor,
              fontSize: 18,
            ),
          ),
        );
      },
    );
  }

  _onTapSaveChange() async {
    ApiServices apiServices = ApiServices();

    (_phoneController.text.trim().isEmpty ||
            _addressController.text.trim().isEmpty)
        ? {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Center(
                    child: DefaultTextWidget(text: 'Chưa điền đủ thông tin'))))
          }
        : {
            apiServices.changePhone(
                id: widget.customerPhones.id,
                isPrimary: isChecked,
                phoneNumber: _phoneController.text.trim()),
            apiServices.changeAddress(
              id: widget.customerAddresses.id,
              address: _addressController.text.trim(),
              isPrimary: isChecked,
              wardCode: wardCode,
              districtCode: districtCode,
              provinceCode: provinceCode,
            ),
            setState(() {}),
          };
  }

  bool? isChecked;

  @override
  void initState() {
    super.initState();

    _addressController =
        TextEditingController(text: widget.customerAddresses.address);
    _phoneController =
        TextEditingController(text: widget.customerPhones.phoneNumber);

    wardCode = widget.customerAddresses.ward?.code;
    districtCode = widget.customerAddresses.district?.code;
    provinceCode = widget.customerAddresses.province?.code;

    NotificationCenter().subscribe('selectedAddressCode', (List<int> code) {
      wardCode = code[0];
      districtCode = code[1];
      provinceCode = code[2];
    });

    isChecked = widget.isPrimary;
  }

  @override
  void dispose() {
    NotificationCenter().unsubscribe('selectedAddressCode');
    NotificationCenter().unsubscribe('provinceSelected');
    super.dispose();
  }
}
