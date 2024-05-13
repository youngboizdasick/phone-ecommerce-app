import 'package:flutter/material.dart';

class ImageSlide extends StatelessWidget {
  final String imagePath;

  const ImageSlide({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    double heightSize = MediaQuery.sizeOf(context).height;
    double heightImageBanner = heightSize * 0.3;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // image banner
        Image.network(
          imagePath,
          scale: 0.8,
          height: heightImageBanner,
          width: MediaQuery.sizeOf(context).width,
        ),
      ],
    );
  }
}
