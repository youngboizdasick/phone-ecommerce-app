import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import '../../../../../config/themes/app_pallete.dart';
import '../../../../core/constants/constants.dart';
import '../../models/smartphone.dart';
import '../screens/product_detail/product_detail_page.dart';
import 'text_format/default_text.dart';
import 'text_format/format_price.dart';
import 'rating.dart';

class ProductWidget extends StatelessWidget {
  final SmartPhone smartPhone;
  const ProductWidget({super.key, required this.smartPhone});

  @override
  Widget build(BuildContext context) {
    double heightScreen = MediaQuery.of(context).size.height;
    double widthScreen = MediaQuery.of(context).size.width;
    double widthCard = (widthScreen - elementSpacing * 3) / 2;
    double heightCard = heightScreen * 0.32;
    return GestureDetector(
      onTap: () => _onTap(context),
      child: Container(
        width: widthCard,
        decoration: BoxDecoration(
          color: AppPallete.whiteColor,
          borderRadius: BorderRadius.circular(radius),
        ),
        child: Column(
          children: [
            _buildImage(heightCard),
            _buildTitle(heightCard, widthCard),
            _buildPrice(heightCard),
            _buildRatingAndFavorite(heightCard),
          ],
        ),
      ),
    );
  }

  _buildImage(double heightCard) {
    return SizedBox(
      height: heightCard * 0.6,
      child: Image.asset(smartPhone.imagePATH),
    );
  }

  _buildTitle(double heightCard, double widthCard) {
    return SizedBox(
      width: widthCard * 0.8,
      height: heightCard * 0.15,
      child: DefaultTextWidget(text: smartPhone.name),
    );
  }

  _buildPrice(double heightCard) {
    return SizedBox(
      height: heightCard * 0.1,
      child: FormatPrice(
        price: smartPhone.price,
        fontSize: headerFontSize,
        color: AppPallete.blackColor,
      ),
    );
  }

  _buildRatingAndFavorite(double heightCard) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: elementSpacing),
      height: heightCard * 0.15,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          RatingWidget(rating: smartPhone.rating),
          const Icon(
            BootstrapIcons.heart,
            size: headerFontSize,
          )
        ],
      ),
    );
  }

  void _onTap(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductDetailPage(smartPhone: smartPhone),
      ),
    );
  }
}
