import 'package:flutter/material.dart';
import 'package:phone_store_clean_architectutre/features/phone_store/models/product_item.dart';
import 'package:phone_store_clean_architectutre/features/phone_store/views/widgets/addToCart_button.dart';
import '../../../../../../config/themes/app_pallete.dart';
import '../../../../../core/constants/constants.dart';
import '../../widgets/text_format/text_widget.dart';
import '../../widgets/text_format/format_price.dart';
import '../product_detail/product_detail_page.dart';

class ProductWidget extends StatelessWidget {
  final ProductItemModel productDetailModel;
  const ProductWidget({super.key, required this.productDetailModel});

  @override
  Widget build(BuildContext context) {
    double heightScreen = MediaQuery.of(context).size.height;
    double widthScreen = MediaQuery.of(context).size.width;
    double widthCard = (widthScreen - elementSpacing * 3) / 2;
    double heightCard = heightScreen * 0.32;
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
      GestureDetector(
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
            ],
          ),
        ),
      ),
      AddToCartButton(productDetailModel: productDetailModel),
    ]);
  }

  _buildImage(double heightCard) {
    String path;
    productDetailModel.images!.isEmpty
        ? path = './assets/images/product_empty.jpg'
        : path = productDetailModel.images![0].imageUrl!;
    return SizedBox(
      height: heightCard * 0.55,
      child: path.contains('http')
          ? Padding(
              padding: const EdgeInsets.only(top: elementSpacing),
              child: Image.network(path),
            )
          : Image.asset(path),
    );
  }

  _buildTitle(double heightCard, double widthCard) {
    return SizedBox(
      width: widthCard * 0.8,
      height: heightCard * 0.20,
      child: TextWidget(
        text: productDetailModel.name!,
        fontSize: 18,
      ),
    );
  }

  _buildPrice(double heightCard) {
    return SizedBox(
      height: heightCard * 0.15,
      child: FormatPrice(
        price: productDetailModel.listPriced!,
        fontSize: headerFontSize,
        color: AppPallete.errorColor,
      ),
    );
  }

  void _onTap(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            ProductDetailPage(productDetailModel: productDetailModel),
      ),
    );
  }
}
