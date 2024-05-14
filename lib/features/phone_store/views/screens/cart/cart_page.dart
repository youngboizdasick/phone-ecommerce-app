import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notification_center/notification_center.dart';
import 'package:phone_store_clean_architectutre/features/phone_store/models/cart.dart';
import 'package:phone_store_clean_architectutre/features/phone_store/services/api_services.dart';
import 'package:phone_store_clean_architectutre/features/phone_store/views/screens/cart/cart_tile.dart';
import 'package:phone_store_clean_architectutre/features/phone_store/views/widgets/app_bar/app_bar_custom.dart';
import 'package:phone_store_clean_architectutre/features/phone_store/views/widgets/text_format/text_widget.dart';
import '../../../../../config/themes/app_pallete.dart';
import '../../../../../core/constants/constants.dart';
import '../../widgets/text_format/format_price.dart';
import '../user/history_payment/historyPayment_page.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<bool> itemsChecked = [];
  bool isChecked = false;
  int price = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppPallete.whiteColor,
      appBar: _buildAppBar(),
      body: _buildBody(),
      bottomNavigationBar: _buildBottomNavBar(price, context),
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
    return FutureBuilder<CartModel?>(
      future: cartDetail,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CupertinoActivityIndicator());
        }
        if (!snapshot.hasData) {
          return Center(child: Image.asset('./assets/images/placeholder.jpg'));
        }
        final cartDetail = snapshot.data!;
        itemsChecked = List.filled(cartDetail.cartProducts!.length, false);
        return ListView.builder(
          shrinkWrap: true,
          itemCount: cartDetail.cartProducts!.length,
          itemBuilder: (context, index) => Column(
            children: [
              CartTile(
                cartProducts: cartDetail.cartProducts![index],
                isChoosed: isChecked,
              ),
              SizedBox(height: elementSpacing)
            ],
          ),
        );
      },
    );
  }

  _buildBottomNavBar(int price, BuildContext context) {
    return Container(
      height: 80,
      decoration: const BoxDecoration(
        color: AppPallete.whiteColor,
        border: Border(top: BorderSide(color: AppPallete.background)),
      ),
      child: Row(
        children: [
          _buildTotalPrice(price),
          _buildPaymentButton(context),
        ],
      ),
    );
  }

  _buildTotalPrice(int price) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // title
          TextWidget(
            text: 'Tổng tiền',
            fontSize: headerFontSize,
          ),
          // display price
          FormatPrice(price: price, color: AppPallete.errorColor, fontSize: 20),
        ],
      ),
    );
  }

  _buildPaymentButton(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () => _onTapPayment(context),
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
      ),
    );
  }

  _onTapPayment(BuildContext context) async {
    ApiServices apiServices = ApiServices();
    bool isSuccess = await apiServices.payment();
    isSuccess
        ? Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const HistoryPaymentPage(),
            ),
          )
        : ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Center(
                child: DefaultTextWidget(
                    text: 'Bạn chưa có thông tin giao hàng.'))));
    ;
  }

  @override
  void initState() {
    super.initState();
    isChecked = false;
    NotificationCenter().subscribe('deleteItem', (bool isSuccess) {
      setState(() {});
    });
    NotificationCenter().subscribe('currentPayment', (int payment) {
      setState(() {
        price = payment;
      });
    });
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
    NotificationCenter().unsubscribe('deleteItem');
    NotificationCenter().unsubscribe('increaseTotalPayment');
    NotificationCenter().unsubscribe('decreaseTotalPayment');
    NotificationCenter().unsubscribe('increaseQuantity');
    NotificationCenter().unsubscribe('decreaseQuantity');
    super.dispose();
  }
}
