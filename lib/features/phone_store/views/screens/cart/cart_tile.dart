import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:notification_center/notification_center.dart';
import 'package:phone_store_clean_architectutre/config/themes/app_pallete.dart';
import 'package:phone_store_clean_architectutre/core/constants/constants.dart';
import 'package:phone_store_clean_architectutre/features/phone_store/models/cart.dart';
import 'package:phone_store_clean_architectutre/features/phone_store/views/widgets/text_format/text_widget.dart';
import 'package:phone_store_clean_architectutre/features/phone_store/views/widgets/text_format/format_price.dart';

class CartTile extends StatefulWidget {
  final CartModel cartModel;
  final bool isChoosed;
  const CartTile({super.key, required this.cartModel, required this.isChoosed});

  @override
  State<CartTile> createState() => _CartTileState();
}

class _CartTileState extends State<CartTile> {
  bool? _isChecked;
  bool? prevChecked;

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
      value: _isChecked,
      checkColor: AppPallete.background,
      activeColor: AppPallete.btnColor,
      onChanged: (bool? value) {
        setState(() {
          _isChecked = value!;
          widget.cartModel.isChoosed = _isChecked;
        });
        _isChecked == true
            ? NotificationCenter().notify<int>(
                'increaseTotalPayment',
                data: widget.cartModel.quantity! * widget.cartModel.price!,
              )
            : NotificationCenter().notify<int>(
                'decreaseTotalPayment',
                data: widget.cartModel.quantity! * widget.cartModel.price!,
              );
      },
    );
  }

  _buildImage(double heightScreen) {
    return Image.asset(
      widget.cartModel.image ?? './assets/images/gray.jpg',
      height: heightScreen / 10,
    );
  }

  _buildDetailCartItem() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        // title product
        DefaultTextWidget(text: widget.cartModel.name ?? 'Đang tải'),
        // price
        FormatPrice(
            price: widget.cartModel.price ?? 0, color: AppPallete.errorColor),
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
    int quantity = widget.cartModel.quantity!;
    return IconButton(
      onPressed: quantity != 0
          ? (() {
              setState(() {
                quantity > 0 ? quantity-- : quantity;
                widget.cartModel.quantity = quantity;
                if (_isChecked == true) {
                  NotificationCenter().notify<int>(
                    'decreaseQuantity',
                    data: widget.cartModel.price,
                  );
                }
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
        child: DefaultTextWidget(text: '${widget.cartModel.quantity!}'),
      ),
    );
  }

  _buildIncreasebutton() {
    int quantity = widget.cartModel.quantity!;
    return IconButton(
      onPressed: quantity < maxQuantity
          ? (() {
              setState(() {
                quantity++;
                widget.cartModel.quantity = quantity;
              });
              if (_isChecked == true) {
                NotificationCenter().notify<int>(
                  'increaseQuantity',
                  data: widget.cartModel.price,
                );
              }
            })
          : null,
      icon: const Icon(BootstrapIcons.plus),
    );
  }

  @override
  void initState() {
    super.initState();
    _isChecked = widget.isChoosed;
    NotificationCenter().subscribe('cartItemSelected', (bool isChecked) {
      setState(() {
        prevChecked = _isChecked;
        _isChecked = isChecked;
      });
      if (prevChecked == false) {
        NotificationCenter().notify<int>(
          'increaseTotalPayment',
          data: widget.cartModel.quantity! * widget.cartModel.price!,
        );
      }
      if (_isChecked == false) {
        NotificationCenter().notify<int>(
          'decreaseTotalPayment',
          data: widget.cartModel.quantity! * widget.cartModel.price!,
        );
      }
    });
  }

  @override
  void dispose() {
    NotificationCenter().unsubscribe('cartItemSelected');
    super.dispose();
  }
}
