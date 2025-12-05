import 'package:flutter/material.dart';

import 'app_text_styles.dart';

class ToggleButton extends StatelessWidget {
  final String text;
  final String imageName;
  final VoidCallback onTap;
  final bool isSwitched;

  const ToggleButton({
    super.key,
    required this.text,
    required this.imageName,
    required this.isSwitched,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Image.asset(
              'assets/icons/$imageName',
              width: 34,
              height: 50,
            ),
            const SizedBox(width: 10,),
            Text(
              text,
              style: AppTextStyle.h1.copyWith(fontSize: 18, color: Colors.black),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 2),
          decoration:const BoxDecoration(
              color:  Color(0xff0D64C5),
              borderRadius:  BorderRadius.all(Radius.circular(60))),
          child: Switch(
            value: isSwitched,
            activeColor: Colors.white,
            onChanged: (value) => onTap(),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
        ),
      ],
    );
  }
}
