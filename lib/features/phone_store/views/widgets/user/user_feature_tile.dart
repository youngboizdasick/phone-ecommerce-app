import 'package:flutter/material.dart';
import 'package:phone_store_clean_architectutre/core/constants/constants.dart';

class UserFeatureWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  final void Function()? onTap;
  const UserFeatureWidget({super.key, required this.icon, required this.title, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
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
