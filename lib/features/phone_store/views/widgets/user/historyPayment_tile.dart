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
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: AppPallete.background),
        ),
      ),
      child: Column(
        children: [
          _buildDetail(),
          _buildStatus(),
          _buildRating(rating, canRate),
        ],
      ),
    );
  }

  _buildDetail() {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: AppPallete.background),
        ),
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

  _buildStatus() {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: AppPallete.background),
        ),
      ),
      child: Row(
        children: [
          // icon
          IconButtonWidget(
            icon: BootstrapIcons.truck,
            color: AppPallete.successColor,
            size: 20,
          ),
          // title
          TextWidget(
            text: 'Đơn hàng được giao thành công',
            color: AppPallete.successColor,
          )
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
