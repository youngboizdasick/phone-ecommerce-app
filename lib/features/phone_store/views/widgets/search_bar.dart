import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';

import '../../../../../config/themes/app_pallete.dart';
import '../../../../core/constants/constants.dart';

class SearchBarWidget extends StatelessWidget {
  final TextEditingController? controller;
  const SearchBarWidget({super.key, this.controller});

  @override
  Widget build(BuildContext context) {
    FocusNode focusNode = FocusNode();
    return TextField(
      controller: controller,
      onTap: () => controller?.selection = TextSelection(
        baseOffset: 0,
        extentOffset: controller!.value.text.length,
      ),
      onTapOutside: (event) => focusNode.unfocus(),
      decoration: const InputDecoration(
        hintText: 'Tìm kiếm',
        prefixIcon: Icon(
          BootstrapIcons.search,
          color: AppPallete.blackColor,
        )
      ),
      style: const TextStyle(fontSize: defaultFontSize),
    );
  }
}
