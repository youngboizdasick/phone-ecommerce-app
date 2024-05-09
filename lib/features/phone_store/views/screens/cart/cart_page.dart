import 'package:flutter/material.dart';
import 'package:notification_center/notification_center.dart';
import 'package:phone_store_clean_architectutre/features/phone_store/models/cart.dart';
import 'package:phone_store_clean_architectutre/features/phone_store/views/screens/cart/cart_tile.dart';
import 'package:phone_store_clean_architectutre/features/phone_store/views/widgets/app_bar/app_bar_custom.dart';
import 'package:phone_store_clean_architectutre/features/phone_store/views/widgets/text_format/text_widget.dart';
import '../../../../../config/themes/app_pallete.dart';
import '../../../../../core/constants/constants.dart';
import '../../widgets/text_format/format_price.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<CartModel> cartItems = [
    CartModel(
      image: './assets/images/iPhone/14_black.png',
      name: 'iPhone 14',
      price: 20000000,
      quantity: 1,
    ),
    CartModel(
      image: './assets/images/iPhone/14_promax_black.png',
      name: 'iPhone 14 Pro Max',
      price: 30000000,
      quantity: 1,
    ),
    CartModel(
      image: './assets/images/iPhone/15_black.png',
      name: 'iPhone 15',
      price: 25000000,
      quantity: 1,
    ),
  ];
  bool isChecked = false;
  int price = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppPallete.whiteColor,
      appBar: _buildAppBar(),
      body: _buildBody(),
      bottomNavigationBar: _buildBottomNavBar(price),
    );
  }

  _buildAppBar() {
    return BackButtonAndTitle(title: HeaderTextWidget(text: 'Giỏ hàng'));
  }

  _buildBody() {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: _buildCartItemListView(),
    );
  }

  _buildCartItemListView() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: cartItems.length,
      itemBuilder: (context, index) =>
          CartTile(cartModel: cartItems[index], isChoosed: isChecked),
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
                  isChecked = value!;
                  for (var item in cartItems) {
                    item.isChoosed = isChecked;
                  }
                  setState(() {});
                  NotificationCenter()
                      .notify<bool>('cartItemSelected', data: isChecked);
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

  @override
  void initState() {
    super.initState();
    NotificationCenter().subscribe('increaseTotalPayment', (int itemPayment) {
      setState(() {
        price += itemPayment;
      });
    });
    NotificationCenter().subscribe('decreaseTotalPayment', (int itemPayment) {
      setState(() {
        price < itemPayment ? price == 0 : price -= itemPayment;
      });
    });
    NotificationCenter().subscribe('increaseQuantity', (int itemPayment) {
      setState(() {
        price += itemPayment;
      });
    });
    NotificationCenter().subscribe('decreaseQuantity', (int itemPayment) {
      setState(() {
        price < itemPayment ? price == 0 : price -= itemPayment;
      });
    });
  }

  @override
  void dispose() {
    NotificationCenter().unsubscribe('increaseTotalPayment');
    NotificationCenter().unsubscribe('decreaseTotalPayment');
    NotificationCenter().unsubscribe('increaseQuantity');
    NotificationCenter().unsubscribe('decreaseQuantity');
    super.dispose();
  }
}
