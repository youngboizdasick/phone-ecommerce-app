import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:phone_store_clean_architectutre/config/themes/app_pallete.dart';
import 'package:phone_store_clean_architectutre/core/constants/constants.dart';
import 'package:phone_store_clean_architectutre/features/phone_store/views/widgets/user/user_feature_tile.dart';

class UserPage extends StatelessWidget {
  const UserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        backgroundColor: AppPallete.whiteColor,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: elementSpacing),
          child: Column(
            children: [
              UserFeatureWidget(
                icon: BootstrapIcons.bag_check,
                title: 'Lịch sử mua hàng',
              ),
              UserFeatureWidget(
                icon: BootstrapIcons.person,
                title: 'Thông tin cá nhân',
              ),
              UserFeatureWidget(
                icon: BootstrapIcons.question_circle,
                title: 'Hỗ trợ khách hàng',
              ),
              UserFeatureWidget(
                icon: BootstrapIcons.info_circle,
                title: 'Phiên bản ứng dụng',
              ),
              UserFeatureWidget(
                icon: BootstrapIcons.box_arrow_right,
                title: 'Đăng xuất',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
