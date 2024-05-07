import 'package:flutter/material.dart';
import 'package:phone_store_clean_architectutre/core/constants/constants.dart';
import 'package:phone_store_clean_architectutre/features/phone_store/services/api_services.dart';
import 'package:phone_store_clean_architectutre/features/phone_store/views/screens/auth/signin_or_signup.dart';

class UserFeatureWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  const UserFeatureWidget({super.key, required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    ApiServices api = ApiServices();
    return GestureDetector(
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
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: elementSpacing),
        child: Row(
          children: [
            // icon
            Icon(icon, size: iconSize),

            SizedBox(width: elementSpacing),
            // title
            Text(
              title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w300,
              ),
            )
          ],
        ),
      ),
    );
  }
}
