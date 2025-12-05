import 'package:flutter/material.dart';

import 'app_text_styles.dart';

class TextBorder extends StatelessWidget {
  final String text;

  const TextBorder({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Text(text,
            style: AppTextStyle.h1.copyWith(
              fontSize: 18,
              foreground: Paint()
                ..style = PaintingStyle.stroke
                ..strokeWidth = 8
                ..color = const Color(0xff494FC7),
            )),
        // Fill
        Text(text,
            style: AppTextStyle.h1.copyWith(
              fontSize: 18,
              color: Colors.white,
            )),
      ],
    );
  }
}
