import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:phone_store_clean_architectutre/config/themes/app_pallete.dart';
import 'package:phone_store_clean_architectutre/features/phone_store/models/cart.dart';
import 'package:phone_store_clean_architectutre/features/phone_store/services/api_services.dart';
import 'package:phone_store_clean_architectutre/features/phone_store/views/screens/user/history_payment/historyPaymentDetail_page.dart';
import 'package:phone_store_clean_architectutre/features/phone_store/views/widgets/app_bar/app_bar_custom.dart';
import 'package:phone_store_clean_architectutre/features/phone_store/views/widgets/text_format/text_widget.dart';

import '../../../../../../core/constants/constants.dart';
import '../../../widgets/app_bar/app_bar_icon.dart';
import '../../../widgets/text_format/format_price.dart';

class HistoryPaymentPage extends StatefulWidget {
  const HistoryPaymentPage({super.key});

  @override
  State<HistoryPaymentPage> createState() => _HistoryPaymentPageState();
}

class _HistoryPaymentPageState extends State<HistoryPaymentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppPallete.whiteColor,
      appBar: _buildAppBar(),
      body: Padding(
        padding: EdgeInsets.only(
          top: elementSpacing,
          left: elementSpacing,
          right: elementSpacing,
        ),
        child: _buildHistoryPaymentBill(),
      ),
    );
  }

  _buildHistoryPaymentBill() {
    ApiServices apiServices = ApiServices();
    final historyCart = apiServices.getHistoryCart();

    return FutureBuilder<List<OldCartModel>?>(
      future: historyCart,
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
        if (!snapshot.hasData) {
          return const SizedBox(width: 1);
        }

        final historyCart = snapshot.data!;

        return ListView.builder(
          shrinkWrap: true,
          itemCount: historyCart.length,
          itemBuilder: (context, index) {
            return Stack(
              alignment: Alignment.bottomRight,
              children: [
                GestureDetector(
                  onTap: () => historyCart[index].workflowState!.code != '7'
                      ? _onTapPaymentBill(historyCart[index])
                      : _doNothing(),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: elementSpacing),
                    child: Container(
                      decoration: BoxDecoration(
                        color: int.parse(
                                    historyCart[index].workflowState!.code!) !=
                                7
                            ? AppPallete.successColor.withOpacity(0.15)
                            : AppPallete.errorColor.withOpacity(0.15),
                        border: Border.all(
                            color: int.parse(historyCart[index]
                                        .workflowState!
                                        .code!) !=
                                    7
                                ? AppPallete.successColor
                                : AppPallete.errorColor),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(radius)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              top: elementSpacing,
                              left: elementSpacing,
                              bottom: elementSpacing,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                HeaderTextWidget(
                                    text:
                                        'Mã đơn hàng #${historyCart[index].id!.substring(0, 8)}'),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      right: elementSpacing),
                                  child: TextWidget(
                                    text: historyCart[index]
                                        .workflowState!
                                        .name
                                        .toString(),
                                    color: int.parse(historyCart[index]
                                                .workflowState!
                                                .code!) !=
                                            7
                                        ? AppPallete.successColor
                                        : AppPallete.errorColor,
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              border: Border(
                                top: BorderSide(
                                    color: int.parse(historyCart[index]
                                                .workflowState!
                                                .code!) !=
                                            7
                                        ? AppPallete.successColor
                                        : AppPallete.errorColor),
                              ),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    // icon
                                    IconButtonWidget(
                                        icon: BootstrapIcons.telephone,
                                        size: 20),
                                    // title
                                    TextWidget(
                                        text: historyCart[index]
                                            .customerPhone!
                                            .phoneNumber
                                            .toString()),
                                  ],
                                ),
                                Row(
                                  children: [
                                    // icon
                                    IconButtonWidget(
                                        icon: BootstrapIcons.geo_alt, size: 20),
                                    // title
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.8,
                                      child: TextWidget(
                                          text: historyCart[index]
                                              .customerAddress!
                                              .address
                                              .toString()),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    IconButtonWidget(
                                        icon: BootstrapIcons.cart_check,
                                        size: 20),
                                    TextWidget(text: 'Thanh toán: '),
                                    FormatPrice(
                                      price: historyCart[index].totalPrice!,
                                      color: AppPallete.errorColor,
                                    )
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                (historyCart[index].workflowState!.code == '2' ||
                        historyCart[index].workflowState!.code == '3')
                    ? Padding(
                        padding: const EdgeInsets.only(
                          bottom: elementSpacing + elementSpacing,
                          right: elementSpacing,
                        ),
                        child: _buildCancelBill(historyCart[index].id),
                      )
                    : const SizedBox(width: 1, height: 1)
              ],
            );
          },
        );
      },
    );
  }

  _onTapPaymentBill(OldCartModel index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HistoryPaymentDetail(
          oldCartModel: index,
        ),
      ),
    );
  }

  _buildCancelBill(String? id) {
    return GestureDetector(
      onTap: () => _onTapCancelBill(id),
      child: Container(
        padding: EdgeInsets.all(elementSpacing / 2),
        decoration: BoxDecoration(
            color: AppPallete.errorColor.withOpacity(0.8),
            borderRadius: BorderRadius.circular(radius)),
        child: TextWidget(
          text: 'Huỷ đơn hàng',
          color: AppPallete.whiteColor,
          isBold: true,
        ),
      ),
    );
  }

  _onTapCancelBill(String? id) async {
    ApiServices apiServices = ApiServices();
    bool isSuccess = await apiServices.cancelCart(id: id);
    isSuccess
        ? setState(() {})
        : ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Center(
                child: DefaultTextWidget(text: 'Có lỗi xảy ra. Thử lại sau'))));
  }

  _doNothing() {}

  _buildAppBar() {
    return BackButtonAndTitle(
      title: HeaderTextWidget(text: 'Lịch sử thanh toán'),
    );
  }
}
