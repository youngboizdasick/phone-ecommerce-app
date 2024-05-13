import 'package:flutter/material.dart';
import 'package:phone_store_clean_architectutre/features/phone_store/models/product_detail.dart';
import 'package:phone_store_clean_architectutre/features/phone_store/views/widgets/addToCart_button.dart';
import 'package:phone_store_clean_architectutre/features/phone_store/views/widgets/text_format/text_widget.dart';
import '../../../../../../config/themes/app_pallete.dart';
import '../../../../../core/constants/constants.dart';
import '../../screens/product_detail/product_detail_page.dart';
import '../text_format/format_price.dart';
import '../rating.dart';

class FeaturedProductCatalogWidget extends StatelessWidget {
  final ProductDetailModel productDetailModel;
  const FeaturedProductCatalogWidget({super.key, required this.productDetailModel});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        _buildFeaturedProductCatalog(context),
        AddToCartButton(size: iconSize, productDetailModel: productDetailModel),
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
            builder: (context) => ProductDetailPage(productDetailModel: productDetailModel),
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
        child: Image.network(productDetailModel.images![0].imageUrl!),
      ),
    );
  }

  _buildTitle(double heightTitle, double widthTitle) {
    return SizedBox(
      width: widthTitle,
      height: heightTitle,
      child: TextWidget(text: productDetailModel.name!, fontSize: 18),
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
                productDetailModel.attributes.toString(),
                softWrap: true,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),

              // rating point
              RatingWidget(rating: productDetailModel.rateCount!.toDouble())
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
              price: productDetailModel.listPriced!,
              fontSize: headerFontSize,
              color: AppPallete.errorColor,
            )
          ],
        ),
      ),
    );
  }
}
