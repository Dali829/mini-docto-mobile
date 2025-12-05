import 'package:flutter/material.dart';

import 'app_text_styles.dart';

class GradientButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final Gradient gradient;
  final double width;
  final double height;
  final double textSize;

  const GradientButton(
      {super.key,
      required this.text,
      required this.onTap,
      this.gradient = const LinearGradient(
        colors: [
          Color(0xffFECC5C),

          Color(0xffF19920),
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      this.width = 321,
      this.height = 56,
      this.textSize = 16});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(60)),
          gradient: gradient,
        ),
        child: Center(
          child: Text(
            text,
            style: AppTextStyle.buttonLarge.copyWith(fontSize: textSize),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
