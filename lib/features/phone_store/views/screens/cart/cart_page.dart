import 'package:flutter/material.dart';
import 'package:notification_center/notification_center.dart';
import 'package:phone_store_clean_architectutre/features/phone_store/models/cart_model.dart';
import 'package:phone_store_clean_architectutre/features/phone_store/services/api_services.dart';
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
    ApiServices apiServices = ApiServices();
    final cartDetail = apiServices.getCurrentCart();
    return FutureBuilder<CartModelApi?>(
      future: cartDetail,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: TextWidget(text: 'Đang tải'));
        }
        final cartDetail = snapshot.data!;
        if (cartDetail.cartProducts!.isEmpty) {
          return const SizedBox(height: 1);
        }
        return ListView.builder(
          shrinkWrap: true,
          itemCount: cartDetail.cartProducts!.length,
          itemBuilder: (context, index) => CartTile(
              cartProducts: cartDetail.cartProducts![index],
              isChoosed: isChecked),
        );
      },
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
    ApiServices apiServices = ApiServices();
    final cart = apiServices.getCurrentCart();

    return FutureBuilder<CartModelApi?>(
      future: cart,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: TextWidget(text: 'Đang tải'));
        }

        final currentCart = snapshot.data!;
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
                      for (var item in currentCart.cartProducts!) {
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
      },
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
