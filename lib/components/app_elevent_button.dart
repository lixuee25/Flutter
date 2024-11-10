import 'package:final_app_flutter/resources/app_color.dart';
import 'package:flutter/material.dart';

class AppEleventButton extends StatelessWidget {
  const AppEleventButton({
    super.key,
    this.onPressed,
    this.height = 48.0,
    required this.text,
    this.colorbg = AppColor.blue,
    this.colorBorder = AppColor.shadow,
    this.textColor = AppColor.white,
    this.width,
  });
  final Function()? onPressed;
  final double height;
  final String text;
  final Color textColor;
  final Color colorbg;
  final Color colorBorder;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: colorbg,
          border: Border.all(width: 0.9, color: colorBorder),
          borderRadius: BorderRadius.all(Radius.circular(40.0)),
          boxShadow: [
            BoxShadow(
                color: Colors.black87, offset: Offset(0, 3.0), blurRadius: 6.0)
          ],
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
