import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import '../../../../../../config/themes/app_pallete.dart';
import '../../../../../core/constants/constants.dart';
import '../text_format/format_price.dart';

class BottomNavBarProductDetailWidget extends StatelessWidget {
  final int price;
  final void Function()? onFavoritePressed;
  final void Function()? onAddToCartPressed;
  const BottomNavBarProductDetailWidget({
    super.key,
    required this.price,
    this.onAddToCartPressed,
    this.onFavoritePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: const BoxDecoration(
        color: AppPallete.whiteColor,
        border: Border(top: BorderSide(color: AppPallete.background)),
      ),
      child: Row(
        children: [
          _buildFavoriteBtn(),
          _buildAddToCartBtn(),
          _buildTotalPrice(),
        ],
      ),
    );
  }

  _buildFavoriteBtn() {
    return Expanded(
      child: Container(
        decoration: const BoxDecoration(
          border: Border(right: BorderSide(width: 1)),
        ),
        child: IconButton(
            onPressed: onFavoritePressed,
            icon: const Icon(
              BootstrapIcons.heart,
              color: AppPallete.blackColor,
            ),
            iconSize: iconSize),
      ),
    );
  }

  _buildAddToCartBtn() {
    return Expanded(
      child: IconButton(
          onPressed: onAddToCartPressed,
          icon: const Icon(
            BootstrapIcons.bag_plus,
            color: AppPallete.blackColor,
          ),
          iconSize: iconSize),
    );
  }

  _buildTotalPrice() {
    return Expanded(
      flex: 2,
      child: Container(
        color: AppPallete.btnColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'mua với giá'.toUpperCase(),
              style: const TextStyle(
                fontSize: headerFontSize,
                fontWeight: FontWeight.bold,
                color: AppPallete.whiteColor,
              ),
            ),
            FormatPrice(
              price: price,
              fontSize: headerFontSize,
              color: AppPallete.whiteColor,
            ),
          ],
        ),
      ),
    );
  }
}
