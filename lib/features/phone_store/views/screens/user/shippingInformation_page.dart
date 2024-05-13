import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:phone_store_clean_architectutre/config/themes/app_pallete.dart';
import 'package:phone_store_clean_architectutre/core/constants/constants.dart';
import 'package:phone_store_clean_architectutre/features/phone_store/models/customer.dart';
import 'package:phone_store_clean_architectutre/features/phone_store/services/api_services.dart';
import 'package:phone_store_clean_architectutre/features/phone_store/views/screens/user/address_phone/add_page.dart';
import 'package:phone_store_clean_architectutre/features/phone_store/views/screens/user/address_phone/fix_page.dart';
import 'package:phone_store_clean_architectutre/features/phone_store/views/widgets/app_bar/app_bar_custom.dart';
import 'package:phone_store_clean_architectutre/features/phone_store/views/widgets/signin_signup/auth_btn.dart';
import 'package:phone_store_clean_architectutre/features/phone_store/views/widgets/text_format/text_widget.dart';

class ShippingInformationPage extends StatefulWidget {
  const ShippingInformationPage({super.key});

  @override
  State<ShippingInformationPage> createState() =>
      _ShippingInformationPageState();
}

class _ShippingInformationPageState extends State<ShippingInformationPage> {
  @override
  Widget build(BuildContext context) {
    double widthSize = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppPallete.whiteColor,
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(elementSpacing),
          child: Column(
            children: [
              _buildShippingInformation(widthSize),
              ButtonWidget(
                buttonText: 'Thêm địa chỉ giao hàng',
                onAccountBtnPressed: () => _onPressedAddMoreAddress(context),
              )
            ],
          ),
        ),
      ),
    );
  }

  _buildAppBar() {
    return BackButtonAndTitle(
      title: HeaderTextWidget(text: 'Thông tin giao hàng'),
    );
  }

  _buildShippingInformation(double widthSize) {
    ApiServices apiServices = ApiServices();
    final customerInformation = apiServices.getCustomerInformation();

    return FutureBuilder<CustomerModel?>(
      future: customerInformation,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: Text(
              'Đang tải',
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
          );
        }

        final customerInformation = snapshot.data!;

        if (customerInformation.customerAddresses!.isEmpty ||
            customerInformation.customerPhones!.isEmpty) {
          return SizedBox(width: 1, height: 1);
        }
        return ListView.builder(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          itemCount: customerInformation.customerAddresses!.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: elementSpacing),
              child: GestureDetector(
                onTap: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FixPage(
                        customerAddresses:
                            customerInformation.customerAddresses![index],
                        customerPhones:
                            customerInformation.customerPhones![index],
                        isPrimary: customerInformation
                            .customerAddresses![index].isPrimary!,
                      ),
                    ),
                  ),
                },
                child: Stack(
                  alignment: Alignment.topRight,
                  children: [
                    Container(
                      width: widthSize,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(radius),
                        border: Border.all(
                          color: (customerInformation.customerAddresses![index]
                                          .isPrimary! ==
                                      true &&
                                  customerInformation
                                          .customerPhones![index].isPrimary! ==
                                      true)
                              ? AppPallete.btnColor
                              : AppPallete.background,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(elementSpacing),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Icon(BootstrapIcons.telephone, size: 16),
                                SizedBox(width: elementSpacing / 2),
                                TextWidget(
                                    text: customerInformation
                                        .customerPhones![index].phoneNumber!),
                              ],
                            ),
                            SizedBox(height: elementSpacing / 2),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(BootstrapIcons.geo_alt, size: 16),
                                SizedBox(width: elementSpacing / 2),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width - 72,
                                  child: TextWidget(
                                      text: formatAddress(customerInformation
                                          .customerAddresses?[index])!),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    (customerInformation.customerAddresses![index].isPrimary! ==
                                true &&
                            customerInformation
                                    .customerPhones![index].isPrimary! ==
                                true)
                        ? Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: AppPallete.btnColor),
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(radius),
                                bottomLeft: Radius.circular(radius),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(elementSpacing / 2),
                              child: TextWidget(
                                text: 'Mặc định',
                                color: AppPallete.btnColor,
                              ),
                            ),
                          )
                        : SizedBox(height: 0, width: 0)
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  _onPressedAddMoreAddress(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AddPage(),
      ),
    );
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
}
