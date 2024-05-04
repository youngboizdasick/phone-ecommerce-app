import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/constants.dart';

class RatingWidget extends StatelessWidget {
  final double rating;
  const RatingWidget({super.key, required this.rating});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('$rating'),
        const SizedBox(width: elementSpacing / 2),
        const Icon(
          BootstrapIcons.star_fill,
          color: Color(0xFFFCDC2A),
          size: 16,
        )
      ],
    );
  }
}
