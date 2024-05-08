import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:phone_store_clean_architectutre/features/phone_store/views/screens/user/user_infor_page.dart';
import '../../../../../config/themes/app_pallete.dart';
import '../../../../../core/constants/constants.dart';
import '../../../services/api_services.dart';
import '../../widgets/user/user_feature_tile.dart';
import '../auth/signin_or_signup.dart';

class UserPage extends StatelessWidget {
  const UserPage({super.key});

  @override
  Widget build(BuildContext context) {
    ApiServices api = ApiServices();
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppPallete.whiteColor,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: elementSpacing),
          child: Column(
            children: [
              UserFeatureWidget(
                icon: BootstrapIcons.bag_check,
                title: 'Lịch sử mua hàng',
                onTap: _onTapHistoryPayment,
              ),
              UserFeatureWidget(
                icon: BootstrapIcons.person,
                title: 'Thông tin cá nhân',
                onTap: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const UserInfoPage(),
                    ),
                  )
                },
              ),
              UserFeatureWidget(
                icon: BootstrapIcons.question_circle,
                title: 'Hỗ trợ khách hàng',
                onTap: _onTapSuport,
              ),
              UserFeatureWidget(
                icon: BootstrapIcons.info_circle,
                title: 'Phiên bản ứng dụng',
                onTap: _onTapAppVersion,
              ),
              UserFeatureWidget(
                icon: BootstrapIcons.box_arrow_right,
                title: 'Đăng xuất',
                onTap: () => {
                  api.logout(),
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SignInOrSignUp(),
                    ),
                    (route) => false,
                  )
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  _onTapHistoryPayment() {}

  _onTapInformation() {}

  _onTapSuport() {}

  _onTapAppVersion() {}
}
