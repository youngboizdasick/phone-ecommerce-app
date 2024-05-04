import 'package:flutter/material.dart';

import '../../../../../config/themes/app_pallete.dart';
import '../../../../core/constants/constants.dart';

class FilterOptionWidget extends StatefulWidget {
  final String label;
  const FilterOptionWidget({super.key, required this.label});

  @override
  State<FilterOptionWidget> createState() => _FilterOptionWidgetState();
}

class _FilterOptionWidgetState extends State<FilterOptionWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleBorderColor,
      child: _buildFilterOption(),
    );
  }

  _buildFilterOption() {
    return Container(
      width: MediaQuery.of(context).size.width / 4,
      alignment: Alignment.center,
      padding: const EdgeInsets.all(elementSpacing),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: AppPallete.whiteColor,
        border: Border.all(color: borderColor, width: 2),
      ),
      child: Text(widget.label),
    );
  }

  Color borderColor = AppPallete.background;

  void _toggleBorderColor() {
    setState(() {
      borderColor = borderColor == AppPallete.btnColor
          ? AppPallete.background
          : AppPallete.btnColor;
    });
  }
}
