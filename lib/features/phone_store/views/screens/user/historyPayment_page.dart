import 'package:flutter/material.dart';
import 'package:phone_store_clean_architectutre/config/themes/app_pallete.dart';
import 'package:phone_store_clean_architectutre/features/phone_store/views/widgets/app_bar/app_bar_custom.dart';
import 'package:phone_store_clean_architectutre/features/phone_store/views/widgets/text_format/text_widget.dart';
import 'package:phone_store_clean_architectutre/features/phone_store/views/widgets/user/historyPayment_tile.dart';

class HistoryPaymentPage extends StatefulWidget {
  const HistoryPaymentPage({super.key});

  @override
  State<HistoryPaymentPage> createState() => _HistoryPaymentPageState();
}

class _HistoryPaymentPageState extends State<HistoryPaymentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppPallete.whiteColor,
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            HistoryPaymentWidget(),
          ],
        ),
      ),
    );
  }

  _buildAppBar() {
    return BackButtonAndTitle(
      title: HeaderTextWidget(text: 'Lịch sử thanh toán'),
    );
  }
}
