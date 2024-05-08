import 'package:flutter/material.dart';

import 'text_format/text_widget.dart';

class NotificationWidget extends StatelessWidget {
  const NotificationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          './assets/images/iPhone/14_black.png',
          height: 70,
        ),
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DefaultTextWidget(text: 'Giao hàng thành công'),
            DefaultTextWidget(text: 'Mô tả thông báo'),
            DefaultTextWidget(text: '01/01/2000'),
          ],
        ),
      ],
    );
  }
}
