import 'package:flutter/material.dart';
import 'package:notification_center/notification_center.dart';

class ColorWidget extends StatelessWidget {
  final int index;
  final Color color;
  const ColorWidget({
    super.key,
    required this.color,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTap,
      child: _buildCircle(),
    );
  }

  _buildCircle() {
    return Container(
      height: 20,
      width: 20,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
    );
  }

  void _onTap() {
    NotificationCenter().notify<int>('animateToPage', data: index);
    NotificationCenter().notify<int>('updatePrice', data: index);
  }
}
