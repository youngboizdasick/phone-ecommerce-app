import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';

import '../../../../../config/themes/app_pallete.dart';
import '../../../../core/constants/constants.dart';

class SearchBarWidget extends StatelessWidget {
  final TextEditingController searchController = TextEditingController();
  SearchBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: searchController,
      decoration: const InputDecoration(
        hintText: 'Tìm kiếm',
        prefixIcon: Icon(
          BootstrapIcons.search,
          color: AppPallete.blackColor,
        ),
      ),
      style: const TextStyle(fontSize: defaultFontSize),
    );
  }
}
