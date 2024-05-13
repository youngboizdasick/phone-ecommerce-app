import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:phone_store_clean_architectutre/features/phone_store/views/screens/user/changePassword_page.dart';
import 'package:phone_store_clean_architectutre/features/phone_store/views/screens/user/historyPayment_page.dart';
import 'package:phone_store_clean_architectutre/features/phone_store/views/screens/user/shippingInformation_page.dart';
import 'package:phone_store_clean_architectutre/features/phone_store/views/screens/user/userInfor_page.dart';
import '../../../../../config/themes/app_pallete.dart';
import '../../../../../core/constants/constants.dart';
import '../../../services/api_services.dart';
import '../../widgets/user/user_feature_tile.dart';
import '../auth/signin_or_signup.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
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
                onTap: () => _onTapHistoryPayment(context),
              ),
              UserFeatureWidget(
                icon: BootstrapIcons.person,
                title: 'Thông tin cá nhân',
                onTap: () => _onTapInformation(context),
              ),
              UserFeatureWidget(
                icon: BootstrapIcons.telephone,
                title: 'Thông tin giao hàng',
                onTap: () => _onTapShippingInformation(context),
              ),
              UserFeatureWidget(
                icon: BootstrapIcons.key,
                title: 'Đổi mật khẩu',
                onTap: () => _onTapChangePwd(context),
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

  _onTapHistoryPayment(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const HistoryPaymentPage(),
      ),
    );
  }

  _onTapInformation(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const UserInfoPage(),
      ),
    );
  }

  _onTapChangePwd(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ChangePassWordPage(),
      ),
    );
  }

  _onTapShippingInformation(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ShippingInformationPage(),
      ),
    );
  }
}
