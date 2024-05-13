import 'package:flutter/cupertino.dart';
import 'package:notification_center/notification_center.dart';

import '../../../../../../config/themes/app_pallete.dart';
import '../../../../../../core/constants/constants.dart';
import '../../../../models/address.dart';
import '../../../../services/api_services.dart';
import '../../../widgets/text_format/text_widget.dart';

class WardPickerView extends StatefulWidget {
  const WardPickerView({super.key});

  @override
  State<WardPickerView> createState() => _WardPickerViewState();
}

class _WardPickerViewState extends State<WardPickerView> {
  int selectedIndex = 0;
  int provinceCode = 1;
  int districtCode = 1;
  @override
  Widget build(BuildContext context) {
    ApiServices apiServices = ApiServices();
    final wards = apiServices.getListWard(
        provinceCode: provinceCode, districtCode: districtCode);
    return FutureBuilder<List<AddressModel>?>(
      future: wards,
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
        final wards = snapshot.data!;
        return CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () => _showDialog(
            CupertinoPicker(
              useMagnifier: true,
              magnification: 1.2,
              itemExtent: 32,
              onSelectedItemChanged: (index) {
                NotificationCenter().notify<List<int>>('selectedAddressCode',
                    data: [
                      wards[index].code!,
                      districtCode,
                      provinceCode
                    ]);
                setState(() {
                  selectedIndex = index;
                });
              },
              children: wards.map((ward) => Text(ward.name!)).toList(),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(right: elementSpacing),
            child: TextWidget(
              text: wards[selectedIndex].name!,
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
    NotificationCenter().subscribe('districtSelected', (List<int> code) {
      setState(() {
        provinceCode = code[1];
        districtCode = code[0];
      });
    });
  }

  @override
  void dispose() {
    NotificationCenter().unsubscribe('districtSelected');
    super.dispose();
  }
}
