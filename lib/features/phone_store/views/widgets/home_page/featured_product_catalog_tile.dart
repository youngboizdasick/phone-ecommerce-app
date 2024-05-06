import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import '../../../../../../config/themes/app_pallete.dart';
import '../../../../../core/constants/constants.dart';
import '../../../models/smartphone.dart';
import '../../screens/product_detail/product_detail_page.dart';
import '../text_format/format_price.dart';
import '../text_format/header_text.dart';
import '../rating.dart';

class FeaturedProductCatalogWidget extends StatelessWidget {
  final SmartPhone smartPhone;
  const FeaturedProductCatalogWidget({super.key, required this.smartPhone});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        _buildFeaturedProductCatalog(context),
        _buildAddToCartBtn(),
      ],
    );
  }

  _buildFeaturedProductCatalog(BuildContext context) {
    double heightScreen = MediaQuery.of(context).size.height;
    double widthScreen = MediaQuery.of(context).size.width;
    double heightCard = heightScreen * 0.5;
    double heightImage = heightCard * 0.47;
    double heightTitle = heightCard * 0.13;
    double heightDescription = heightCard * 0.2;
    double heightPrice = heightCard * 0.1;
    double widthCard = widthScreen * 0.65;
    double widthTitle = widthCard - elementSpacing * 4;
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailPage(smartPhone: smartPhone),
          ),
        );
      },
      child: Container(
        width: widthCard,
        height: heightCard,
        decoration: BoxDecoration(
          color: AppPallete.whiteColor,
          borderRadius: BorderRadius.circular(radius),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildImage(heightImage),
            _buildTitle(heightTitle, widthTitle),
            _buildDescription(heightDescription, widthTitle),
            _buildPrice(heightPrice),
          ],
        ),
      ),
    );
  }

  _buildImage(double heightImage) {
    return SizedBox(
      height: heightImage,
      child: Padding(
        padding: const EdgeInsets.only(top: elementSpacing),
        child: Image.asset(smartPhone.imagePATH),
      ),
    );
  }

  _buildTitle(double heightTitle, double widthTitle) {
    return SizedBox(
      width: widthTitle,
      height: heightTitle,
      child: HeaderTextWidget(text: smartPhone.name),
    );
  }

  _buildDescription(double heightDescription, double widthTitle) {
    return SizedBox(
      height: heightDescription,
      child: Container(
        width: widthTitle,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          color: AppPallete.background,
        ),
        child: Padding(
          padding: const EdgeInsets.all(elementSpacing),
          child: Column(
            children: [
              Text(
                smartPhone.description,
                softWrap: true,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),

              // rating point
              RatingWidget(rating: smartPhone.rating)
            ],
          ),
        ),
      ),
    );
  }

  _buildPrice(double heightPrice) {
    return SizedBox(
      height: heightPrice,
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: elementSpacing * 2,
            vertical: elementSpacing),
        child: Row(
          children: [
            FormatPrice(
              price: smartPhone.price,
              fontSize: headerFontSize,
              color: AppPallete.blackColor,
            )
          ],
        ),
      ),
    );
  }

  _buildAddToCartBtn() {
    return Container(
      padding: const EdgeInsets.all(elementSpacing),
      decoration: const BoxDecoration(
        color: AppPallete.btnColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(radius),
          bottomRight: Radius.circular(radius),
        ),
      ),
      child: const Icon(
        BootstrapIcons.bag_plus,
        size: iconSize,
        color: AppPallete.whiteColor,
      ),
    );
  }
}
