import 'package:flutter/material.dart';

import '../styles/app_colors.dart';

class AppRoundedButton extends StatelessWidget {
  final String label;
  final Function() onPressed;
  final bool fitWidth;
  final Color? bagColor, txtColor;

  AppRoundedButton(
      {required this.label,
      required this.onPressed,
      this.fitWidth = false,
      this.txtColor,
      this.bagColor});

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onPressed,
        child: Container(
          width: fitWidth ? double.infinity : null,
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          decoration: BoxDecoration(
              color: bagColor ?? AppColors.primaryColor,
              borderRadius: BorderRadius.circular(10)),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(color: txtColor ?? Colors.white),
          ),
        ));
  }
}
