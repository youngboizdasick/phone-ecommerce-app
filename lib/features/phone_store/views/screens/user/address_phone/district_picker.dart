import 'package:flutter/cupertino.dart';
import 'package:notification_center/notification_center.dart';

import '../../../../../../config/themes/app_pallete.dart';
import '../../../../../../core/constants/constants.dart';
import '../../../../models/address.dart';
import '../../../../services/api_services.dart';
import '../../../widgets/text_format/text_widget.dart';

class DistrictPickerView extends StatefulWidget {
  const DistrictPickerView({super.key});

  @override
  State<DistrictPickerView> createState() => _DistrictPickerViewState();
}

class _DistrictPickerViewState extends State<DistrictPickerView> {
  int selectedIndex = 0;
  int provinceCodeSelected = 1;
  @override
  Widget build(BuildContext context) {
    ApiServices apiServices = ApiServices();
    final districts = apiServices.getListDistrict(provinceCode: provinceCodeSelected);
    return FutureBuilder<List<AddressModel>?>(
      future: districts,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: Text(
              'Đang tải',
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
          );
        }
        final districts = snapshot.data!;
        return CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () => _showDialog(
            CupertinoPicker(
              useMagnifier: true,
              magnification: 1.2,
              itemExtent: 32,
              onSelectedItemChanged: (index) {
                setState(() {
                  selectedIndex = index;
                });
                NotificationCenter().notify<List<int>>('districtSelected', data: [districts[selectedIndex].code!, provinceCodeSelected]);
              },
              children:
                  districts.map((district) => Text(district.name!)).toList(),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(right: elementSpacing),
            child: TextWidget(
              text: districts[selectedIndex].name!,
              color: AppPallete.btnColor,
              fontSize: 18,
            ),
          ),
        );
      },
    );
  }

  void _showDialog(Widget child) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => Container(
        height: 216,
        padding: const EdgeInsets.only(top: 6.0),
        // The Bottom margin is provided to align the popup above the system navigation bar.
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        // Provide a background color for the popup.
        color: CupertinoColors.systemBackground.resolveFrom(context),
        // Use a SafeArea widget to avoid system overlaps.
        child: SafeArea(
          top: false,
          child: child,
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    NotificationCenter().subscribe('provinceSelected', (int provinceCode) {
      setState(() {
        provinceCodeSelected = provinceCode;
      });
    });
  }

  @override
  void dispose() {
    NotificationCenter().unsubscribe('provinceSelected');
    NotificationCenter().unsubscribe('districtSelected');
    super.dispose();
  }
}
