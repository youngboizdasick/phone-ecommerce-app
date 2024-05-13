import 'package:flutter/material.dart';
import 'package:phone_store_clean_architectutre/features/phone_store/models/product_basic.dart';
import 'package:phone_store_clean_architectutre/features/phone_store/views/screens/product_catalog/product_line.dart';
import 'package:phone_store_clean_architectutre/features/phone_store/views/screens/product_catalog/product_view.dart';
import 'package:phone_store_clean_architectutre/features/phone_store/views/widgets/app_bar/app_bar_custom.dart';
import '../../../../../../config/themes/app_pallete.dart';
import '../../../../../core/constants/constants.dart';
import '../../../services/api_services.dart';
import '../../widgets/text_format/text_widget.dart';

class ProductCatalogPage extends StatefulWidget {
  final String titleCatalog;
  final String? brandId;
  const ProductCatalogPage({
    super.key,
    required this.titleCatalog,
    this.brandId,
  });

  @override
  State<ProductCatalogPage> createState() => _ProductCatalogPageState();
}

class _ProductCatalogPageState extends State<ProductCatalogPage> {
  int? currentPage = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppPallete.background,
      appBar: AppBarCustom(title: HeaderTextWidget(text: widget.titleCatalog)),
      body: _buildBody(context),
    );
  }

  _buildBody(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildModelFilter(),
          ProductView(title: widget.titleCatalog),
        ],
      ),
    );
  }

  _buildModelFilter() {
    ApiServices api = ApiServices();
    final productLine = api.getProductLineByBrand(brandId: widget.brandId);
    return FutureBuilder<List<ProductBasicModel>?>(
      future: productLine,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Padding(
            padding: const EdgeInsets.only(
              top: elementSpacing,
              left: elementSpacing,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextWidget(text: 'Dòng sản phẩm', isBold: true),
                Center(child: CircularProgressIndicator()),
              ],
            ),
          );
        }
        final productLine = snapshot.data!;
        return Padding(
          padding: const EdgeInsets.only(
            top: elementSpacing,
            left: elementSpacing,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextWidget(text: 'Dòng sản phẩm', isBold: true),
              SizedBox(height: elementSpacing / 2),
              SizedBox(
                height: 45,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: productLine.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: elementSpacing),
                      child: ProductLineView(
                        code: productLine[index].code,
                        title: productLine[index].name,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
