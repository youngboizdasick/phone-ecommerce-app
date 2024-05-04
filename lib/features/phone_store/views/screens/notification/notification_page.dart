import 'package:flutter/material.dart';
import '../../../../../../config/themes/app_pallete.dart';
import '../../../../../core/constants/constants.dart';
import '../../widgets/header_text.dart';
import '../../widgets/notification_tile.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(),
    );
  }

  _buildAppBar(BuildContext context) {
    return AppBar(
      title: const HeaderTextWidget(text: 'Thông Báo'),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Container(
          height: 1,
          width: MediaQuery.of(context).size.width,
          color: AppPallete.background,
        ),
      ),
    );
  }

  _buildBody() {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildListViewVertical(),
        ],
      ),
    );
  }

  _buildListViewVertical() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: 10,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(
            top: elementSpacing,
            left: elementSpacing,
            right: elementSpacing,
          ),
          child: Container(
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: AppPallete.background),
              ),
            ),
            child: const Column(
              children: [
                NotificationWidget(),
                SizedBox(height: elementSpacing)
              ],
            ),
          ),
        );
      },
    );
  }
}
