import 'package:final_app_flutter/resources/app_color.dart';
import 'package:flutter/material.dart';


class CategoryCell extends StatelessWidget {
  final Map cObj;
  const CategoryCell({super.key, required this.cObj});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: InkWell(
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                cObj["image"].toString(),
                width: 60,
                height: 60,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              height: 6,
            ),
            Text(
              cObj["name"],
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: AppColor.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ),
    );
  }
}