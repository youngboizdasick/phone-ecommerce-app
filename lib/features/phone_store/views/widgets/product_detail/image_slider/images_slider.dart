import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:notification_center/notification_center.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../../../../../config/themes/app_pallete.dart';
import '../../../../../../core/constants/constants.dart';
import 'image_slide_tile.dart';

class ImagesSlider extends StatefulWidget {
  final List<ImageSlide> imagesSlide;
  const ImagesSlider({super.key, required this.imagesSlide});

  @override
  State<ImagesSlider> createState() => _ImagesSliderState();
}

class _ImagesSliderState extends State<ImagesSlider> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        _buildCarouselSlider(context),
        _buildAnimatedSmoothIndicator(),
      ],
    );
  }

  int currentIndex = 0;
  CarouselController carouselController = CarouselController();

  _buildCarouselSlider(BuildContext context) {
    double heightSize = MediaQuery.sizeOf(context).height;
    double heightSlide = heightSize * 0.4;
    return Container(
      color: AppPallete.whiteColor,
      child: Column(
        children: [
          CarouselSlider(
            carouselController: carouselController,
            options: CarouselOptions(
              viewportFraction: 1.0,
              height: heightSlide,
              enlargeCenterPage: true,
              enlargeFactor: 0.3,
              aspectRatio: 2.0,
              onPageChanged: (index, reason) {
                setState(() {
                  currentIndex = index;
                });
              },
            ),
            items: widget.imagesSlide,
          )
        ],
      ),
    );
  }

  _buildAnimatedSmoothIndicator() {
    return Padding(
      padding: const EdgeInsets.only(bottom: elementSpacing),
      child: AnimatedSmoothIndicator(
        activeIndex: currentIndex,
        count: widget.imagesSlide.length,
        duration: Duration.zero,
        effect: const WormEffect(
          dotHeight: 8,
          dotWidth: 8,
          spacing: elementSpacing,
          dotColor: AppPallete.background,
          activeDotColor: AppPallete.blackColor,
          paintStyle: PaintingStyle.fill,
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    NotificationCenter().subscribe('animateToPage', (int index) {
      setState(() {
        currentIndex = index;
      });

      carouselController.jumpToPage(currentIndex);
    });
  }

  @override
  void dispose() {
    NotificationCenter().unsubscribe('animateToPage');
    super.dispose();
  }
}
