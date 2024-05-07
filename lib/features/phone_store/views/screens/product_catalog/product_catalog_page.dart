import 'package:flutter/material.dart';
import 'package:phone_store_clean_architectutre/features/phone_store/views/widgets/app_bar/app_bar_custom.dart';
import '../../../../../../config/themes/app_pallete.dart';
import '../../../../../core/constants/constants.dart';
import '../../../models/smartphone.dart';
import '../../../models/store.dart';
import '../../widgets/text_format/default_text.dart';
import '../../widgets/text_format/header_text.dart';
import '../../widgets/filter/product_filter_list_view.dart';
import 'product_tile.dart';

class ProductCatalogPage extends StatelessWidget {
  final List<SmartPhone> phones;
  final String titleCatalog;
  const ProductCatalogPage({
    super.key,
    required this.phones,
    required this.titleCatalog,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppPallete.background,
      appBar: AppBarCustom(title: HeaderTextWidget(text: titleCatalog)),
      body: _buildBody(context),
    );
  }

  _buildBody(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildModelFilter(),
          _buildPriceFilter(),
          _buildGridView(context),
        ],
      ),
    );
  }

  _buildModelFilter() {
    Store store = Store();
    List<SmartPhone> allPhones = store.getAllSmartPhones;
    return Padding(
      padding: const EdgeInsets.only(
        top: elementSpacing,
        left: elementSpacing,
      ),
      child: ProductFilterListViewWidget(
        optionList: store.getUniqueModelsByCategory(allPhones, titleCatalog),
      ),
    );
  }

  _buildPriceFilter() {
    return const Column(
      children: [
        Padding(
          padding: EdgeInsets.only(
            top: elementSpacing,
            left: elementSpacing,
          ),
          child: Row(children: [DefaultTextWidget(text: 'Khoảng giá')]),
        ),
        Padding(
          padding: EdgeInsets.only(
            top: elementSpacing,
            left: elementSpacing,
          ),
          child: ProductFilterListViewWidget(optionList: priceFilter),
        ),
      ],
    );
  }

  _buildGridView(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(elementSpacing),
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: phones.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: elementSpacing,
          crossAxisSpacing: elementSpacing,
          mainAxisExtent: MediaQuery.of(context).size.height * 0.32,
        ),
        itemBuilder: (context, index) {
          return ProductWidget(smartPhone: phones[index]);
        },
      ),
    );
  }
}
