import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';

import '../../../../../../config/themes/app_pallete.dart';
import '../../../../../core/constants/constants.dart';

class BottomNavBar extends StatelessWidget {
  final void Function(int)? onTap;
  final int currentIndex;

  const BottomNavBar({
    super.key,
    required this.onTap,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
        ),
        child: _buildBottomNavBar());
  }

  _buildBottomNavBar() {
    return BottomNavigationBar(
      onTap: (value) => onTap!(value),
      currentIndex: currentIndex,
      // Cài đặt màu khi nhấn và không nhấn
      unselectedItemColor: AppPallete.blackColor,
      selectedItemColor: AppPallete.blackColor,
      // Không hiển thị tiêu đề từng nút
      showSelectedLabels: false,
      showUnselectedLabels: false,
      type: BottomNavigationBarType.fixed,
      backgroundColor: AppPallete.whiteColor,
      items: _buildBottomNavBarItems(),
    );
  }

  _buildBottomNavBarItems() {
    return const [
      // home page
      BottomNavigationBarItem(
          icon: Icon(BootstrapIcons.house_door, size: iconSize),
          activeIcon: Icon(BootstrapIcons.house_door_fill, size: iconSize),
          label: 'Trang chủ'),

      // favorite page
      BottomNavigationBarItem(
          icon: Icon(BootstrapIcons.heart, size: iconSize),
          activeIcon: Icon(BootstrapIcons.heart_fill, size: iconSize),
          label: 'Yêu thích'),

      // notifications page
      BottomNavigationBarItem(
          icon: Icon(BootstrapIcons.bell, size: iconSize),
          activeIcon: Icon(BootstrapIcons.bell_fill, size: iconSize),
          label: 'Thông báo'),

      // user page
      BottomNavigationBarItem(
          icon: Icon(BootstrapIcons.person, size: iconSize),
          activeIcon: Icon(BootstrapIcons.person_fill, size: iconSize),
          label: 'Bản thân'),
    ];
  }
}
