import 'package:flutter/material.dart';
import 'package:phone_store_clean_architectutre/features/phone_store/models/brand.dart';
import 'package:phone_store_clean_architectutre/features/phone_store/models/product_item.dart';
import 'package:phone_store_clean_architectutre/features/phone_store/views/widgets/app_bar/app_bar_custom.dart';
import '../../../../../../config/themes/app_pallete.dart';
import '../../../../../core/constants/constants.dart';
import '../../../services/api_services.dart';
import '../../widgets/text_format/text_widget.dart';
import '../../widgets/home_page/featured_product_catalog_tile.dart';
import '../../widgets/home_page/product_catalog_tile.dart';
import '../../widgets/search_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController _searchController = TextEditingController();
    return Scaffold(
      backgroundColor: AppPallete.background,
      appBar: SearchBarAndCart(
          title: SearchBarWidget(
        controller: _searchController,
      )),
      body: _buildBody(context),
    );
  }

  _buildBody(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildProductCatalog(),
          _buildListViewFeaturedProductCatalog(context),
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
          child: buildListViewProductCatalog(),
        ),
      ],
    );
  }

  Widget buildListViewProductCatalog() {
    ApiServices api = ApiServices();
    final brands = api.getBrands();
    return FutureBuilder<List<BrandModel>?>(
      future: brands,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox(
            height: 100,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        final brands = snapshot.data!;
        return SizedBox(
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: brands.length,
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.only(right: elementSpacing),
              child: ProductCatalogWidget(
                imagePATH: brands[index].avatarLink,
                title: brands[index].name ?? '',
                brandId: brands[index].id,
              ),
            ),
          ),
        );
      },
    );
  }

  _buildListViewFeaturedProductCatalog(BuildContext context) {
    ApiServices api = ApiServices();
    final items = api.getItemsByProductLine(name: 'iphone');
    double heightScreen = MediaQuery.of(context).size.height;
    double heightCard = heightScreen * 0.5;

    return FutureBuilder<List<ProductItemModel>?>(
      future: items,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
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
                child: SizedBox(
                  height: heightCard,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),
            ],
          );
        }
        final items = snapshot.data!;
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
              child: SizedBox(
                height: heightCard,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: items.length,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.only(right: elementSpacing),
                    child: FeaturedProductCatalogWidget(
                      productDetailModel: items[index],
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
