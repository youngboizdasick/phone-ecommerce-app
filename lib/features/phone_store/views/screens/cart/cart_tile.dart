import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:notification_center/notification_center.dart';
import 'package:phone_store_clean_architectutre/config/themes/app_pallete.dart';
import 'package:phone_store_clean_architectutre/core/constants/constants.dart';
import 'package:phone_store_clean_architectutre/features/phone_store/models/cart.dart';
import 'package:phone_store_clean_architectutre/features/phone_store/services/api_services.dart';
import 'package:phone_store_clean_architectutre/features/phone_store/views/widgets/app_bar/app_bar_icon.dart';
import 'package:phone_store_clean_architectutre/features/phone_store/views/widgets/text_format/text_widget.dart';
import 'package:phone_store_clean_architectutre/features/phone_store/views/widgets/text_format/format_price.dart';

class CartTile extends StatefulWidget {
  final CartProducts cartProducts;
  final bool isChoosed;
  const CartTile(
      {super.key, required this.cartProducts, required this.isChoosed});

  @override
  State<CartTile> createState() => _CartTileState();
}

class _CartTileState extends State<CartTile> {
  bool? _isChecked;
  bool? prevChecked;
  int maxQuantity = 99;
  int? quantity;
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
          _buildImage(heightScreen),
          _buildDetailCartItem(),
          _buildDeleteBtn(),
        ],
      ),
    );
  }

  _buildImage(double heightScreen) {
    return Image.network(
      widget.cartProducts.productItemImageUrl!,
      height: heightScreen / 10,
    );
  }

  _buildDetailCartItem() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        // title product
        SizedBox(
            width: MediaQuery.of(context).size.width * 0.6,
            child: DefaultTextWidget(
                text: widget.cartProducts.productItemName ?? 'Đang tải')),
        // price
        FormatPrice(
            price: widget.cartProducts.price ?? 0,
            color: AppPallete.errorColor),
        // quantity adjustment
        _buildQuantityAdjusment(),
      ],
    );
  }

  _buildDeleteBtn() {
    return IconButtonWidget(
      icon: BootstrapIcons.trash,
      size: iconSize,
      color: AppPallete.errorColor,
      onPressed: () => _onDelProductToCart(),
    );
  }

  _onDelProductToCart() async {
    ApiServices apiServices = ApiServices();
    bool isSuccess = await apiServices.delProductToCart(
        id: widget.cartProducts.productItemId);
    isSuccess
        ? NotificationCenter().notify<bool>('deleteItem', data: true)
        : ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Center(
                child:
                    DefaultTextWidget(text: 'Có lỗi xảy ra. Thử lại sau.'))));
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
    int quantity = widget.cartProducts.quantity!;
    return IconButton(
      onPressed: quantity > 1
          ? (() {
              setState(() {
                quantity > 1 ? quantity-- : quantity;
                widget.cartProducts.quantity = quantity;
              });
              _onTapUpdateProduct();
              if (_isChecked == true) {
                NotificationCenter().notify<int>(
                  'decreaseQuantity',
                  data: widget.cartProducts.price,
                );
              }
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
        child: DefaultTextWidget(text: '${widget.cartProducts.quantity!}'),
      ),
    );
  }

  _buildIncreasebutton() {
    return IconButton(
      onPressed: quantity! < maxQuantity
          ? (() {
              setState(() {
                quantity = quantity! + 1;
                widget.cartProducts.quantity = quantity;
              });
              _onTapUpdateProduct();
              if (_isChecked == true) {
                NotificationCenter().notify<int>(
                  'increaseQuantity',
                  data: widget.cartProducts.price,
                );
              }
            })
          : null,
      icon: const Icon(BootstrapIcons.plus),
    );
  }

  _onTapUpdateProduct() async {
    ApiServices apiServices = ApiServices();
    await apiServices.updateProduct(
      id: widget.cartProducts.productItemId,
      quantity: quantity,
      price: widget.cartProducts.price,
    );
    print(quantity);
  }

  @override
  void initState() {
    super.initState();
    quantity = widget.cartProducts.quantity!;
    _isChecked = widget.isChoosed;
    NotificationCenter().subscribe('cartItemSelected', (bool isChecked) {
      NotificationCenter().notify<int>(
        'increaseTotalPayment',
        data: widget.cartProducts.quantity! * widget.cartProducts.price!,
      );
    });
  }

  @override
  void dispose() {
    NotificationCenter().unsubscribe('cartItemSelected');
    super.dispose();
  }
}
