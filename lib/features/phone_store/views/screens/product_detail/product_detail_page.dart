import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:notification_center/notification_center.dart';
import 'package:phone_store_clean_architectutre/features/phone_store/models/product_detail.dart';
import 'package:phone_store_clean_architectutre/features/phone_store/views/widgets/app_bar/app_bar_custom.dart';
import '../../../../../../config/themes/app_pallete.dart';
import '../../../../../core/constants/constants.dart';
import '../../widgets/text_format/text_widget.dart';
import '../../widgets/text_format/format_price.dart';
import '../../widgets/product_detail/image_slider/image_slide_tile.dart';
import '../../widgets/product_detail/image_slider/images_slider.dart';
import '../../widgets/rating.dart';

class ProductDetailPage extends StatefulWidget {
  final ProductDetailModel productDetailModel;
  const ProductDetailPage({super.key, required this.productDetailModel});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    int price = widget.productDetailModel.listPriced!;
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppPallete.whiteColor,
        extendBodyBehindAppBar: true,
        appBar: const BackButtonAndCartButton(),
        body: _buildBody(),
        bottomNavigationBar: _buildBottomNavBar(price), //BottomNavBarProductDetailWidget(price: price),
      ),
    );
  }

  _buildBody() {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildProductReview(),
          // _buildMemoryListView(),
          _buildTitleProduct(),
          _buildRatingAndReview(),
          // _buildWarehourseAddress(),
          _buildDescription(),
        ],
      ),
    );
  }

  _buildProductReview() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.41,
      decoration: const BoxDecoration(
        color: AppPallete.background,
        border: Border(bottom: BorderSide(color: AppPallete.background))
      ),
      child: Stack(
        alignment: Alignment.centerRight,
        children: [
          _buildImagesSlider(),
          // _buildColorsListView(),
        ],
      ),
    );
  }

  _buildImagesSlider() {
    List<String> imagesUrl = [];
    List<Images>? images = widget.productDetailModel.images;
    for (Images url in images!) {
      imagesUrl.add(url.imageUrl!);
    }
    return ImagesSlider(
      imagesSlide: _createImageSliders(imagesUrl),
    );
  }

  // _buildColorsListView() {
  //   // List<Color> colors = _getColors(widget.smartPhone);
  //   return Padding(
  //     padding: const EdgeInsets.only(right: elementSpacing * 2),
  //     child: SizedBox(
  //       width: 20,
  //       child: ListView.builder(
  //         physics: const NeverScrollableScrollPhysics(),
  //         shrinkWrap: true,
  //         itemCount: colors.length,
  //         itemBuilder: (context, index) {
  //           return Padding(
  //             padding: const EdgeInsets.only(bottom: elementSpacing),
  //             child: ColorWidget(
  //               color: colors[index],
  //               index: index,
  //             ),
  //           );
  //         },
  //       ),
  //     ),
  //   );
  // }

  // _buildMemoryListView() {
  //   return Column(
  //     children: [
  //       const Padding(
  //         padding: EdgeInsets.all(elementSpacing),
  //         child: Row(
  //           children: [
  //             DefaultTextWidget(text: 'Bộ nhớ'),
  //           ],
  //         ),
  //       ),
  //     ],
  //   );
  // }

  _buildTitleProduct() {
    return Padding(
      padding: const EdgeInsets.only(
        top: elementSpacing,
        left: elementSpacing,
        bottom: elementSpacing,
      ),
      child: Row(
        children: [HeaderTextWidget(text: widget.productDetailModel.name!)],
      ),
    );
  }

  _buildRatingAndReview() {
    return Padding(
      padding: const EdgeInsets.only(
        left: elementSpacing,
        bottom: elementSpacing,
      ),
      child: Row(
        children: [
          Container(
            decoration: const BoxDecoration(
              border: Border(
                right: BorderSide(
                  color: AppPallete.blackColor,
                  width: 2,
                ),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(right: elementSpacing),
              child: RatingWidget(rating: widget.productDetailModel.rateCount!.toDouble()),
            ),
          ),

          const SizedBox(width: elementSpacing),

          // reviews
          const DefaultTextWidget(text: '0 lượt đánh giá'),
        ],
      ),
    );
  }

  // _buildWarehourseAddress() {
  //   Color color;
  //   List<String> warehouses = widget.smartPhone.warehouses;
  //   return Column(
  //     children: [
  //       Padding(
  //         padding: const EdgeInsets.only(
  //           left: elementSpacing,
  //           bottom: elementSpacing,
  //         ),
  //         child: Row(
  //           children: [
  //             DefaultTextWidget(
  //               text: '${widget.smartPhone.warehouses.length} kho còn sản phẩm',
  //             ),
  //           ],
  //         ),
  //       ),
  //       Padding(
  //         padding: const EdgeInsets.only(
  //           left: elementSpacing,
  //           bottom: elementSpacing,
  //           right: elementSpacing,
  //         ),
  //         child: Container(
  //           decoration: BoxDecoration(
  //             border: Border.all(color: AppPallete.background),
  //             borderRadius: BorderRadius.circular(radius),
  //           ),
  //           child: SizedBox(
  //             height: 100,
  //             child: ListView.builder(
  //               shrinkWrap: true,
  //               itemCount: warehouses.length,
  //               itemBuilder: (context, index) {
  //                 color = index % 2 == 0
  //                     ? AppPallete.whiteColor
  //                     : AppPallete.background;
  //                 return WarehouseTile(
  //                     address: warehouses[index], color: color);
  //               },
  //             ),
  //           ),
  //         ),
  //       )
  //     ],
  //   );
  // }

  _buildDescription() {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(
            left: elementSpacing,
            bottom: elementSpacing,
          ),
          child: Row(
            children: [DefaultTextWidget(text: 'Mô tả sản phẩm')],
          ),
        ),
        Container(
          width:
              MediaQuery.of(context).size.width - elementSpacing * 2,
          decoration: BoxDecoration(
            border: Border.all(color: AppPallete.background),
            borderRadius: BorderRadius.circular(radius),
          ),
          child: Padding(
            padding: const EdgeInsets.all(elementSpacing),
            child: Text(
              widget.productDetailModel.attributes.toString(),
              style: const TextStyle(fontSize: defaultFontSize),
            ),
          ),
        )
      ],
    );
  }

  _buildBottomNavBar(int price) {
    return Container(
      height: 80,
      decoration: const BoxDecoration(
        color: AppPallete.whiteColor,
        border: Border(top: BorderSide(color: AppPallete.background)),
      ),
      child: Row(
        children: [
          _buildFavoriteBtn(),
          _buildAddToCartBtn(),
          _buildTotalPrice(price),
        ],
      ),
    );
  }

  _buildFavoriteBtn() {
    return Expanded(
      child: Container(
        decoration: const BoxDecoration(
          border: Border(right: BorderSide(width: 1)),
        ),
        child: IconButton(
            onPressed: onFavoritePressed,
            icon: const Icon(
              BootstrapIcons.heart,
              color: AppPallete.blackColor,
            ),
            iconSize: iconSize),
      ),
    );
  }

  _buildAddToCartBtn() {
    return Expanded(
      child: IconButton(
          onPressed: onAddToCartPressed,
          icon: const Icon(
            BootstrapIcons.bag_plus,
            color: AppPallete.blackColor,
          ),
          iconSize: iconSize),
    );
  }

  _buildTotalPrice(int price) {
    return Expanded(
      flex: 2,
      child: Container(
        color: AppPallete.btnColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'mua với giá'.toUpperCase(),
              style: const TextStyle(
                fontSize: headerFontSize,
                fontWeight: FontWeight.bold,
                color: AppPallete.whiteColor,
              ),
            ),
            FormatPrice(
              price: price,
              fontSize: headerFontSize,
              color: AppPallete.whiteColor,
            ),
          ],
        ),
      ),
    );
  }

  void onFavoritePressed() {}
  void onAddToCartPressed() {}

  @override
  void initState() {
    super.initState();
    NotificationCenter().subscribe('updatePrice', (int newIndex) {
      setState(() {
        currentIndex = newIndex;
      });
    });
  }

  @override
  void dispose() {
    NotificationCenter().unsubscribe('updatePrice');
    super.dispose();
  }

  // // lấy tất cả image path của sản phẩm
  // List<String> _getImagePaths(SmartPhone smartphone) {
  //   List<String> paths = [];

  //   // Lặp qua từng màu sắc của smartphone và thêm đường dẫn hình ảnh vào danh sách
  //   for (var color in smartphone.modelColors) {
  //     paths.add(color.imagePATH);
  //   }

  //   return paths;
  // }

  // // lấy tất cả màu của sản phẩm
  // List<Color> _getColors(SmartPhone smartphone) {
  //   List<Color> colors = [];
  //   for (var color in smartphone.modelColors) {
  //     colors.add(color.color);
  //   }
  //   return colors;
  // }

  // // lấy tất cả thông tin bộ nhớ (memory) của sản phẩm
  // List<String> _getAllMemories(SmartPhone smartphone) {
  //   List<String> memories = [];
  //   for (ModelMemory modelMemory in smartphone.modelMemories) {
  //     if (modelMemory.memory == 1) {
  //       memories.add('1TB');
  //     } else {
  //       memories.add('${modelMemory.memory}GB');
  //     }
  //   }
  //   return memories;
  // }

  List<ImageSlide> _createImageSliders(List<String> imagePaths) {
    return imagePaths.map((path) => ImageSlide(imagePath: path)).toList();
  }
}
