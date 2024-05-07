import 'package:flutter/material.dart';
import '../../../../../core/constants/constants.dart';
import 'filter_option.dart';

class ProductFilterListViewWidget extends StatelessWidget {
  final List<String> optionList;
  const ProductFilterListViewWidget({super.key, required this.optionList});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      child: _buildListView(),
    );
  }

  _buildListView() {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: optionList.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(right: elementSpacing),
          child: FilterOptionWidget(label: optionList[index]),
        );
      },
    );
  }
}
