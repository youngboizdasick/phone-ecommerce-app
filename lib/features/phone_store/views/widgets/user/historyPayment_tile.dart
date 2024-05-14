import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../../../../config/themes/app_pallete.dart';
import '../../../../../core/constants/constants.dart';
import '../app_bar/app_bar_icon.dart';
import '../text_format/format_price.dart';
import '../text_format/text_widget.dart';

class HistoryPaymentWidget extends StatefulWidget {
  const HistoryPaymentWidget({super.key});

  @override
  State<HistoryPaymentWidget> createState() => _HistoryPaymentWidgetState();
}

class _HistoryPaymentWidgetState extends State<HistoryPaymentWidget> {
  bool canRate = true;
  double rating = 0;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: elementSpacing,
        left: elementSpacing,
        right: elementSpacing,
      ),
      child: GestureDetector(
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: AppPallete.background),
            borderRadius: const BorderRadius.all(Radius.circular(radius)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: elementSpacing,
                  left: elementSpacing,
                  bottom: elementSpacing,
                ),
                child: HeaderTextWidget(text: 'Mã đơn hàng #1'),
              ),
              _buildShippingInformation(),
            ],
          ),
        ),
      ),
    );
  }

  _buildDetail() {
    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: AppPallete.background)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: elementSpacing),
        child: Row(
          children: [
            _buildImage(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTitle(),
                _buildQuantity(),
                _buildPrice('Giá gốc', 0), // cost
                _buildPrice('Thanh toán', 0), // payment
              ],
            ),
          ],
        ),
      ),
    );
  }

  _buildImage() {
    return Image.asset('./assets/images/iPhone/14_black.png', height: 72);
  }

  _buildTitle() {
    return Row(children: [DefaultTextWidget(text: 'iPhone 14')]);
  }

  _buildQuantity() {
    return Text(
      'Số lượng: 1',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontStyle: FontStyle.italic,
        color: Colors.grey,
      ),
    );
  }

  _buildPrice(String title, int price) {
    return Row(
      children: [
        DefaultTextWidget(text: '$title:'),
        SizedBox(width: elementSpacing),
        FormatPrice(price: price, color: AppPallete.errorColor)
      ],
    );
  }

  _buildShippingInformation() {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: AppPallete.background),
          top: BorderSide(color: AppPallete.background),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              // icon
              IconButtonWidget(icon: BootstrapIcons.telephone, size: 20),
              // title
              TextWidget(text: '0123456789'),
            ],
          ),
          Row(
            children: [
              // icon
              IconButtonWidget(icon: BootstrapIcons.geo_alt, size: 20),
              // title
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: TextWidget(
                    text:
                        'So 58, Duong AA, Phuong Tay Thanh, Quan Binh Tan, Thanh pho Ho Chi Minh'),
              )
            ],
          ),
          Row(
            children: [
              IconButtonWidget(icon: BootstrapIcons.cart_check, size: 20),
              TextWidget(text: 'Thanh toán: '),
              FormatPrice(price: 99999999, color: AppPallete.errorColor,)
            ],
          ),
        ],
      ),
    );
  }

  _buildRating(double rating, bool canRate) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: elementSpacing),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // title
          Text(
            'Đánh giá sản phẩm này ?',
            style: TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: defaultFontSize,
              color: Colors.grey,
              fontStyle: FontStyle.italic,
            ),
          ),

          // rating
          canRate
              ? RatingBar.builder(
                  initialRating: rating,
                  minRating: 1,
                  maxRating: 5,
                  itemCount: 5,
                  itemSize: iconSize,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: elementSpacing / 2),
                    child: Icon(
                      index < rating
                          ? BootstrapIcons.star
                          : BootstrapIcons.star_fill,
                      color: const Color(0xFFFCDC2A),
                    ),
                  ),
                  onRatingUpdate: (newRating) {
                    if (canRate) {
                      setState(() {
                        rating = newRating;
                        canRate = false;
                        print(canRate);
                        // after rating 2s, POST result to api
                        Future.delayed(Duration(seconds: 2), () {});
                      });
                    }
                  },
                )
              : DefaultTextWidget(text: 'Đã đánh giá')
        ],
      ),
    );
  }
}
