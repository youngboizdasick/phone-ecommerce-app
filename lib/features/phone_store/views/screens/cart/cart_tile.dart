import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:phone_store_clean_architectutre/config/themes/app_pallete.dart';
import 'package:phone_store_clean_architectutre/core/constants/constants.dart';
import 'package:phone_store_clean_architectutre/features/phone_store/views/widgets/text_format/text_widget.dart';
import 'package:phone_store_clean_architectutre/features/phone_store/views/widgets/text_format/format_price.dart';

class CartTile extends StatefulWidget {
  const CartTile({super.key});

  @override
  State<CartTile> createState() => _CartTileState();
}

class _CartTileState extends State<CartTile> {
  bool isChecked = false;
  int quantity = 1;
  int maxQuantity = 5;
  @override
  Widget build(BuildContext context) {
    double heightScreen = MediaQuery.of(context).size.height;
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: AppPallete.background,
            width: 1,
          ),
        ),
      ),
      height: heightScreen / 8, // 1/8 of height screen
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _buildCheckbox(),
          _buildImage(heightScreen),
          _buildDetailCartItem(),
        ],
      ),
    );
  }

  _buildCheckbox() {
    return Checkbox(
      value: isChecked,
      checkColor: AppPallete.background,
      activeColor: AppPallete.btnColor,
      onChanged: (bool? value) {
        setState(() {
          isChecked = value!;
        });
      },
    );
  }

  _buildImage(double heightScreen) {
    return Image.asset(
      './assets/images/iPhone/14_black.png',
      height: heightScreen / 10,
    );
  }

  _buildDetailCartItem() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        // title product
        const DefaultTextWidget(text: 'iPhone 14'),
        // price
        const FormatPrice(price: 1000000, color: AppPallete.errorColor),
        // quantity adjustment
        _buildQuantityAdjusment(),
      ],
    );
  }

  _buildQuantityAdjusment() {
    return Row(
      children: [
        _buildDecreaseButton(),
        _buildDisplayQuantity(),
        _buildIncreasebutton(),
      ],
    );
  }

  _buildDecreaseButton() {
    return IconButton(
      onPressed: quantity != 0
          ? (() {
              setState(() {
                quantity > 0 ? quantity-- : quantity;
              });
            })
          : null,
      icon: const Icon(BootstrapIcons.dash),
    );
  }

  _buildDisplayQuantity() {
    return Container(
      decoration: const BoxDecoration(
        border: Border.symmetric(
          vertical: BorderSide(
            color: AppPallete.background,
            width: 2,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: elementSpacing),
        child: DefaultTextWidget(text: '$quantity'),
      ),
    );
  }

  _buildIncreasebutton() {
    return IconButton(
      onPressed: quantity < maxQuantity
          ? (() {
              setState(() {
                quantity++;
              });
            })
          : null,
      icon: const Icon(BootstrapIcons.plus),
    );
  }

  void _decreaseQuantity() {}
}
