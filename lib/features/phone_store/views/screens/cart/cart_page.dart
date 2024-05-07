import 'package:flutter/material.dart';
import 'package:phone_store_clean_architectutre/features/phone_store/views/screens/cart/cart_tile.dart';
import 'package:phone_store_clean_architectutre/features/phone_store/views/widgets/app_bar/app_bar_custom.dart';
import 'package:phone_store_clean_architectutre/features/phone_store/views/widgets/text_format/default_text.dart';
import 'package:phone_store_clean_architectutre/features/phone_store/views/widgets/text_format/header_text.dart';

import '../../../../../config/themes/app_pallete.dart';
import '../../../../../core/constants/constants.dart';
import '../../widgets/text_format/format_price.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppPallete.whiteColor,
      appBar: BackButtonAndTitle(title: HeaderTextWidget(text: 'Giỏ hàng')),
      body: CartTile(),
      bottomNavigationBar: _buildBottomNavBar(99999999),
    );
  }

  _buildBottomNavBar(int price) {
    return Container(
      height: 80,
      decoration: const BoxDecoration(
        color: AppPallete.whiteColor,
        border: Border(top: BorderSide(color: AppPallete.background)),
      ),
      child: Row(
        children: [
          _buildCheckAllButton(),
          _buildTotalPrice(price),
          _buildPaymentButton(),
        ],
      ),
    );
  }

  _buildCheckAllButton() {
    return Expanded(
      flex: 2,
      child: Container(
        decoration: const BoxDecoration(
          border: Border(right: BorderSide(width: 1)),
        ),
        child: Row(
          children: [
            // check all
            Transform.scale(
              scale: 1.5,
              child: Checkbox(
                value: isChecked,
                checkColor: AppPallete.background,
                activeColor: AppPallete.btnColor,
                side: BorderSide(width: 1),
                onChanged: (bool? value) {
                  setState(() {
                    isChecked = value!;
                  });
                },
              ),
            ),
            // title
            DefaultTextWidget(text: 'Tất cả'),
          ],
        ),
      ),
    );
  }

  _buildTotalPrice(int price) {
    return Expanded(
      flex: 3,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // title
          DefaultTextWidget(text: 'Tổng tiền'),
          // display price
          FormatPrice(price: price, color: AppPallete.errorColor, fontSize: 20),
        ],
      ),
    );
  }

  _buildPaymentButton() {
    return Expanded(
      flex: 3,
      child: Container(
        color: AppPallete.btnColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'thanh toán'.toUpperCase(),
              style: const TextStyle(
                fontSize: headerFontSize,
                fontWeight: FontWeight.bold,
                color: AppPallete.whiteColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
