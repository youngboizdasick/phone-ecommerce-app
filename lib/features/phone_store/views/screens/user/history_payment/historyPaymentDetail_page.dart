import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:notification_center/notification_center.dart';
import 'package:phone_store_clean_architectutre/config/themes/app_pallete.dart';
import 'package:phone_store_clean_architectutre/features/phone_store/models/cart.dart';
import 'package:phone_store_clean_architectutre/features/phone_store/views/widgets/app_bar/app_bar_custom.dart';
import 'package:phone_store_clean_architectutre/features/phone_store/views/widgets/text_format/text_widget.dart';

import '../../../../../../core/constants/constants.dart';
import '../../../widgets/app_bar/app_bar_icon.dart';
import '../../../widgets/text_format/format_price.dart';

class HistoryPaymentDetail extends StatefulWidget {
  final OldCartModel oldCartModel;
  const HistoryPaymentDetail({super.key, required this.oldCartModel});

  @override
  State<HistoryPaymentDetail> createState() => _HistoryPaymentDetailState();
}

class _HistoryPaymentDetailState extends State<HistoryPaymentDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppPallete.whiteColor,
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildShippingInformation(),
            Padding(
              padding: const EdgeInsets.all(elementSpacing),
              child: TextWidget(text: 'Thông tin sản phẩm', fontSize: 18),
            ),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: widget.oldCartModel.cartProducts!.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    _buildDetail(widget.oldCartModel.cartProducts![index]),
                    _buildRating(rating, canRate!)
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  _buildAppBar() {
    return BackButtonAndTitle(
      title: HeaderTextWidget(
          text: 'Mã đơn hàng #${widget.oldCartModel.id!.substring(0, 8)}'),
    );
  }

  _buildShippingInformation() {
    return Padding(
      padding: const EdgeInsets.only(
        top: elementSpacing,
        left: elementSpacing,
        right: elementSpacing,
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          border: Border.all(
            color: AppPallete.background,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                  border:
                      Border(bottom: BorderSide(color: AppPallete.background))),
              child: Padding(
                padding: const EdgeInsets.only(
                    top: elementSpacing, left: elementSpacing, bottom: elementSpacing),
                child:
                    TextWidget(text: 'Thông tin người nhận hàng', fontSize: 18),
              ),
            ),
            Row(children: [
              IconButtonWidget(icon: BootstrapIcons.telephone, size: 20),
              TextWidget(
                  text: widget.oldCartModel.customerPhone!.phoneNumber
                      .toString()),
            ]),
            Row(children: [
              IconButtonWidget(icon: BootstrapIcons.geo_alt, size: 20),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: TextWidget(
                    text: widget.oldCartModel.customerAddress!.address
                        .toString()),
              )
            ])
          ],
        ),
      ),
    );
  }

  _buildDetail(CartProducts cartProducts) {
    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: AppPallete.background)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: elementSpacing),
        child: Row(
          children: [
            _buildImage(cartProducts.productItemImageUrl),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTitle(cartProducts.productItemName),
                _buildQuantity(cartProducts.quantity),
                _buildPrice('Giá gốc', cartProducts.price), // cost
                _buildPrice('Thanh toán', cartProducts.price), // payment
              ],
            ),
          ],
        ),
      ),
    );
  }

  _buildImage(String? url) {
    return Image.network(url.toString(), height: 100);
  }

  _buildTitle(String? name) {
    return DefaultTextWidget(text: name.toString());
  }

  _buildQuantity(int? quantity) {
    return Text(
      'Số lượng: $quantity',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontStyle: FontStyle.italic,
        color: Colors.grey,
      ),
    );
  }

  _buildPrice(String title, int? price) {
    return Row(
      children: [
        DefaultTextWidget(text: '$title:'),
        SizedBox(width: elementSpacing),
        FormatPrice(price: price!, color: AppPallete.errorColor)
      ],
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
                    setState(() {
                      rating = newRating;
                      canRate = false;
                      Future.delayed(Duration(seconds: 2), () {
                        NotificationCenter()
                            .notify<bool>('isRatedProduct', data: canRate);
                      });
                    });
                  })
              : DefaultTextWidget(text: 'Đã đánh giá sản phẩm')
        ],
      ),
    );
  }

  double rating = 0;
  bool? canRate;

  @override
  void initState() {
    super.initState();
    canRate = true;
    NotificationCenter().subscribe('isRatedProduct', (bool isRated) {
      setState(() {
        canRate = isRated;
      });
    });
  }

  @override
  void dispose() {
    NotificationCenter().unsubscribe('isRatedProduct');
    super.dispose();
  }
}
