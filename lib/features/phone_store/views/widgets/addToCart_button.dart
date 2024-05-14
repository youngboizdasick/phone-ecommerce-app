import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:notification_center/notification_center.dart';
import 'package:phone_store_clean_architectutre/features/phone_store/models/product_item.dart';
import 'package:phone_store_clean_architectutre/features/phone_store/services/api_services.dart';

import '../../../../config/themes/app_pallete.dart';
import '../../../../core/constants/constants.dart';

class AddToCartButton extends StatelessWidget {
  final ProductItemModel productDetailModel;
  final double? size;
  const AddToCartButton(
      {super.key, this.size, required this.productDetailModel});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _onTapPutProductToCart(),
      child: Container(
        padding: EdgeInsets.all(
            size == iconSize ? elementSpacing : elementSpacing / 2),
        decoration: const BoxDecoration(
          color: AppPallete.btnColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(radius),
            bottomRight: Radius.circular(radius),
          ),
        ),
        child: Icon(
          BootstrapIcons.bag_plus,
          size: size ?? iconSize,
          color: AppPallete.whiteColor,
        ),
      ),
    );
  }

  _onTapPutProductToCart() {
    ApiServices apiServices = ApiServices();
    final isSuccess = apiServices.postProductToCart(
      productItemId: productDetailModel.id,
      productItemName: productDetailModel.name,
      productItemImageUrl: productDetailModel.images?[0].imageUrl,
      price: productDetailModel.listPriced,
    );
    print(productDetailModel.name);
    isSuccess.then(
      (value) => value
          ? NotificationCenter().notify<int>('putProductToCart', data: 1)
          : NotificationCenter().notify<int>('putProductToCart', data: 0),
    );
  }
}
