import 'package:flutter/material.dart';
import 'package:phone_store_clean_architectutre/config/themes/app_pallete.dart';

import '../../../../../core/constants/constants.dart';
import '../../../models/smartphone.dart';
import '../../screens/product_catalog/product_catalog_page.dart';

class ProductCatalogWidget extends StatelessWidget {
  final List<SmartPhone> smartPhoneCategory;
  final String imagePATH;
  final String title;
  const ProductCatalogWidget({
    super.key,
    required this.smartPhoneCategory,
    required this.title,
    required this.imagePATH,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return ProductCatalogPage(
                titleCatalog: title,
                phones: smartPhoneCategory,
              );
            },
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(elementSpacing),
        decoration: BoxDecoration(
          color: AppPallete.whiteColor,
          borderRadius: BorderRadius.circular(radius),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // image
            Image.asset(imagePATH, height: 50),

            const SizedBox(height: elementSpacing / 2),
            // title
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.w500),
            )
          ],
        ),
      ),
    );
  }
}
