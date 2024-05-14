import 'package:flutter/material.dart';
import 'package:notification_center/notification_center.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:phone_store_clean_architectutre/config/themes/app_pallete.dart';
import 'package:phone_store_clean_architectutre/features/phone_store/models/product_item.dart';
import '../../../../../core/constants/constants.dart';
import '../../../services/api_services.dart';
import '../../widgets/text_format/text_widget.dart';
import 'product_tile.dart';

class ProductView extends StatefulWidget {
  final String? title;
  const ProductView({super.key, this.title});

  @override
  State<ProductView> createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(elementSpacing),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextWidget(text: 'Sản phẩm', isBold: true),
          SizedBox(height: elementSpacing / 2),
          _buildGridView(context),
        ],
      ),
    );
  }

  _buildGridView(BuildContext context) {
    ApiServices api = ApiServices();
    Future<List<ProductItemModel>?> items;
    Future<int> total;
    paramGetItemsCatalog!.length > 3
        ? {
            items = api.getItemsByProductLine(
                name: paramGetItemsCatalog, page: currentPage! + 1),
            total = api.getTotalProductsByLine(name: paramGetItemsCatalog)
          }
        : {
            if (paramGetItemsCatalog != prev)
              {prev = paramGetItemsCatalog, currentPage = 0},
            items = api.getItemsByProductLine(
                productCode: paramGetItemsCatalog, page: currentPage! + 1),
            total =
                api.getTotalProductsByLine(productCode: paramGetItemsCatalog)
          };
    return FutureBuilder<List<ProductItemModel>?>(
      future: items,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        final items = snapshot.data!;

        if (items.isEmpty) {
          return Center(
            child: Image.asset('./assets/images/placeholder.jpg'),
          );
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: items.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: elementSpacing,
                crossAxisSpacing: elementSpacing,
                mainAxisExtent: MediaQuery.of(context).size.height * 0.32,
              ),
              itemBuilder: (context, index) {
                return ProductWidget(productDetailModel: items[index]);
              },
            ),
            _buildPagination(total),
          ],
        );
      },
    );
  }

  _buildPagination(Future<int> total) {
    return FutureBuilder(
        future: total,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final total = snapshot.data!;
          if (total == 0) {
            return NumberPaginator(
              numberPages: 1,
              initialPage: currentPage!,
              onPageChange: (int index) => {
                setState(() {
                  currentPage = index;
                })
              },
              config: _numberPaginatorUIConfig(),
            );
          }
          return NumberPaginator(
            numberPages: (total / 10).ceil(),
            initialPage: currentPage!,
            onPageChange: (int index) => {
              setState(() {
                currentPage = index;
              })
            },
            config: _numberPaginatorUIConfig(),
          );
        });
  }

  String? paramGetItemsCatalog;
  int? currentPage;
  String? prev;

  @override
  void initState() {
    super.initState();
    currentPage = 0;
    paramGetItemsCatalog = widget.title;
    NotificationCenter().subscribe('sendProductLineId', (String id) {
      setState(() {
        paramGetItemsCatalog = id;
      });
    });
  }

  @override
  void dispose() {
    NotificationCenter().unsubscribe('sendProductLineId');
    super.dispose();
  }

  NumberPaginatorUIConfig _numberPaginatorUIConfig() {
    return const NumberPaginatorUIConfig(
      buttonSelectedBackgroundColor: AppPallete.btnColor,
      buttonTextStyle:
          TextStyle(fontSize: defaultFontSize, fontWeight: FontWeight.bold),
      buttonUnselectedForegroundColor: AppPallete.blackColor,
    );
  }
}
