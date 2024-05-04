import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:notification_center/notification_center.dart';
import '../../../../../../config/themes/app_pallete.dart';
import '../../../../../core/constants/constants.dart';
import '../../../models/smartphone.dart';
import '../../widgets/app_bar_icon.dart';
import '../../widgets/default_text.dart';
import '../../widgets/header_text.dart';
import '../../widgets/product_detail/bottom_nav_bar.dart';
import '../../widgets/product_detail/color_tile.dart';
import '../../widgets/product_detail/image_slider/image_slide_tile.dart';
import '../../widgets/product_detail/image_slider/images_slider.dart';
import '../../widgets/product_detail/warehouse_tile.dart';
import '../../widgets/product_filter_list_view.dart';
import '../../widgets/rating.dart';

class ProductDetailPage extends StatefulWidget {
  final SmartPhone smartPhone;
  const ProductDetailPage({super.key, required this.smartPhone});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    int additionalPriceColorModel =
        widget.smartPhone.modelColors[currentIndex].additionalPrice;
    int additionalPriceMemoryModel =
        widget.smartPhone.modelMemories[0].additionalPrice;
    int price = additionalPriceColorModel +
        additionalPriceMemoryModel +
        widget.smartPhone.price;
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppPallete.whiteColor,
        extendBodyBehindAppBar: true,
        appBar: _buildAppBar(),
        body: _buildBody(),
        bottomNavigationBar: BottomNavBarProductDetailWidget(price: price),
      ),
    );
  }

  _buildAppBar() {
    return AppBar(
      forceMaterialTransparency: true,
      leading: IconButtonWidget(
        icon: BootstrapIcons.chevron_left,
        onPressed: () => Navigator.pop(context),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: elementSpacing),
          child: IconButtonWidget(
            icon: BootstrapIcons.bag,
            onPressed: () => Navigator.pushNamed(context, '/cartPage'),
          ),
        ),
      ],
    );
  }

  _buildBody() {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildProductReview(),
          _buildMemoryListView(),
          _buildTitleProduct(),
          _buildRatingAndReview(),
          _buildWarehourseAddress(),
          _buildDescription(),
        ],
      ),
    );
  }

  _buildProductReview() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.4,
      decoration: const BoxDecoration(
        color: AppPallete.background,
      ),
      child: Stack(
        alignment: Alignment.centerRight,
        children: [
          _buildImagesSlider(),
          _buildColorsListView(),
        ],
      ),
    );
  }

  _buildImagesSlider() {
    return ImagesSlider(
      imagesSlide: _createImageSliders(_getImagePaths(widget.smartPhone)),
    );
  }

  _buildColorsListView() {
    List<Color> colors = _getColors(widget.smartPhone);
    return Padding(
      padding: const EdgeInsets.only(right: elementSpacing * 2),
      child: SizedBox(
        width: 20,
        child: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: colors.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: elementSpacing),
              child: ColorWidget(
                color: colors[index],
                index: index,
              ),
            );
          },
        ),
      ),
    );
  }

  _buildMemoryListView() {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(elementSpacing),
          child: Row(
            children: [
              DefaultTextWidget(text: 'Bộ nhớ'),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: elementSpacing,
            bottom: elementSpacing,
          ),
          child: ProductFilterListViewWidget(
            optionList: _getAllMemories(widget.smartPhone),
          ),
        )
      ],
    );
  }

  _buildTitleProduct() {
    return Padding(
      padding: const EdgeInsets.only(
        left: elementSpacing,
        bottom: elementSpacing,
      ),
      child: Row(
        children: [HeaderTextWidget(text: widget.smartPhone.name)],
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
              child: RatingWidget(rating: widget.smartPhone.rating),
            ),
          ),

          const SizedBox(width: elementSpacing),

          // reviews
          const DefaultTextWidget(text: '0 lượt đánh giá'),
        ],
      ),
    );
  }

  _buildWarehourseAddress() {
    Color color;
    List<String> warehouses = widget.smartPhone.warehouses;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: elementSpacing,
            bottom: elementSpacing,
          ),
          child: Row(
            children: [
              DefaultTextWidget(
                text: '${widget.smartPhone.warehouses.length} kho còn sản phẩm',
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: elementSpacing,
            bottom: elementSpacing,
            right: elementSpacing,
          ),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: AppPallete.background),
              borderRadius: BorderRadius.circular(radius),
            ),
            child: SizedBox(
              height: 100,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: warehouses.length,
                itemBuilder: (context, index) {
                  color = index % 2 == 0
                      ? AppPallete.whiteColor
                      : AppPallete.background;
                  return WarehouseTile(
                      address: warehouses[index], color: color);
                },
              ),
            ),
          ),
        )
      ],
    );
  }

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
              widget.smartPhone.description + widget.smartPhone.description,
              style: const TextStyle(fontSize: defaultFontSize),
            ),
          ),
        )
      ],
    );
  }

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

  // lấy tất cả image path của sản phẩm
  List<String> _getImagePaths(SmartPhone smartphone) {
    List<String> paths = [];

    // Lặp qua từng màu sắc của smartphone và thêm đường dẫn hình ảnh vào danh sách
    for (var color in smartphone.modelColors) {
      paths.add(color.imagePATH);
    }

    return paths;
  }

  // lấy tất cả màu của sản phẩm
  List<Color> _getColors(SmartPhone smartphone) {
    List<Color> colors = [];
    for (var color in smartphone.modelColors) {
      colors.add(color.color);
    }
    return colors;
  }

  // lấy tất cả thông tin bộ nhớ (memory) của sản phẩm
  List<String> _getAllMemories(SmartPhone smartphone) {
    List<String> memories = [];
    for (ModelMemory modelMemory in smartphone.modelMemories) {
      if (modelMemory.memory == 1) {
        memories.add('1TB');
      } else {
        memories.add('${modelMemory.memory}GB');
      }
    }
    return memories;
  }

  List<ImageSlide> _createImageSliders(List<String> imagePaths) {
    return imagePaths.map((path) => ImageSlide(imagePath: path)).toList();
  }
}
