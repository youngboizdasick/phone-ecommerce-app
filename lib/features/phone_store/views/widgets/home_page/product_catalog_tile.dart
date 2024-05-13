import 'package:flutter/material.dart';
import 'package:phone_store_clean_architectutre/config/themes/app_pallete.dart';
import '../../../../../core/constants/constants.dart';
import '../../screens/product_catalog/product_catalog_page.dart';

class ProductCatalogWidget extends StatelessWidget {
  final String? imagePATH;
  final String title;
  final String? brandId;
  const ProductCatalogWidget({
    super.key,
    required this.title,
    required this.imagePATH,
    this.brandId,
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
                brandId: brandId,
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
            imagePATH != null
                ? Image.network(imagePATH!, height: 50, width: 50)
                : Image.asset('./assets/images/iPhone/14_black.png',
                    height: 50, width: 70),

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
