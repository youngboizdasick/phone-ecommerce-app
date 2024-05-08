import 'package:flutter/material.dart';
import 'package:phone_store_clean_architectutre/features/phone_store/views/widgets/app_bar/app_bar_custom.dart';
import '../../../../../../config/themes/app_pallete.dart';
import '../../../../../core/constants/constants.dart';
import '../../../models/smartphone.dart';
import '../../../models/store.dart';
import '../../widgets/text_format/text_widget.dart';
import '../../widgets/home_page/featured_product_catalog_tile.dart';
import '../../widgets/home_page/product_catalog_tile.dart';
import '../../widgets/search_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppPallete.background,
      appBar: SearchBarAndCart(title: SearchBarWidget()),
      body: _buildBody(context),
    );
  }

  _buildBody(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildProductCatalog(),
          _buildFeaturedProductCatalog(context),
        ],
      ),
    );
  }

  _buildProductCatalog() {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(elementSpacing),
          child: Row(
            children: [DefaultTextWidget(text: 'Danh mục sản phẩm')],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: elementSpacing),
          child: _buildListViewProductCatalog(),
        ),
      ],
    );
  }

  _buildListViewProductCatalog() {
    Store store = Store();
    List<SmartPhone> smartPhones =
        store.getFirstProductOfEachCategory(store.getAllSmartPhones);
    List<String> categories = store.getSmartPhoneCategoriesAsStringList();

    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: smartPhones.length,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.only(right: elementSpacing),
          child: ProductCatalogWidget(
            imagePATH: smartPhones[index].imagePATH,
            title: categories[index],
            smartPhoneCategory:
                store.getSmartPhonesByCategory(smartPhones[index].category),
          ),
        ),
      ),
    );
  }

  _buildFeaturedProductCatalog(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(elementSpacing),
          child: Row(
            children: [
              HeaderTextWidget(text: 'Sản phẩm nổi bật 🔥'),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: elementSpacing),
          child: _buildListViewFeaturedProductCatalog(context),
        ),
      ],
    );
  }

  _buildListViewFeaturedProductCatalog(BuildContext context) {
    double heightScreen = MediaQuery.of(context).size.height;
    double heightCard = heightScreen * 0.5;
    double popularPoint = 4.5;
    Store store = Store();
    List<SmartPhone> popularSmartPhones =
        store.getSmartPhonesPopular(popularPoint, store.getAllSmartPhones);

    return SizedBox(
      height: heightCard,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: popularSmartPhones.length,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.only(right: elementSpacing),
          child: FeaturedProductCatalogWidget(
              smartPhone: popularSmartPhones[index]),
        ),
      ),
    );
  }
}
