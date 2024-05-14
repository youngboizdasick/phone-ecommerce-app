import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:notification_center/notification_center.dart';
import '../../../../../config/themes/app_pallete.dart';
import '../../../../../core/constants/constants.dart';
import '../text_format/text_widget.dart';
import 'app_bar_icon.dart';

class CartLeadView extends StatefulWidget {
  const CartLeadView({super.key});

  @override
  State<CartLeadView> createState() => _CartLeadViewState();
}

class _CartLeadViewState extends State<CartLeadView> {
  int? cartLength;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: elementSpacing),
      child: (cartLength! > 0)
          ? Stack(
              alignment: Alignment.topRight,
              children: [
                IconButtonWidget(
                  icon: BootstrapIcons.bag,
                  onPressed: () => {
                    NotificationCenter()
                        .notify<bool>('cartItemSelected', data: true),
                    Navigator.pushNamed(context, '/CartPage')
                  },
                ),
                Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppPallete.errorColor,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: TextWidget(
                      text: '$cartLength',
                      fontSize: 14,
                      isBold: true,
                      color: AppPallete.whiteColor,
                    ),
                  ),
                )
              ],
            )
          : IconButtonWidget(
              icon: BootstrapIcons.bag,
              onPressed: () => Navigator.pushNamed(context, '/CartPage'),
            ),
    );
  }

  @override
  void initState() {
    super.initState();
    cartLength = 0;
    NotificationCenter().subscribe('currentCartLength', (int length) {
      setState(() {
        cartLength = length;
      });
    });
    NotificationCenter().subscribe('putProductToCart', (int quantity) {
      setState(() {
        cartLength = cartLength! + quantity;
      });
    });
  }

  @override
  void dispose() {
    NotificationCenter().unsubscribe('currentCartLength');
    NotificationCenter().unsubscribe('putProductToCart');
    super.dispose();
  }
}
