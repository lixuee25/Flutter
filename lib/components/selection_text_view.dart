import 'package:final_app_flutter/resources/app_color.dart';
import 'package:flutter/material.dart';

class SelectionTextView extends StatelessWidget {
  final String title;
  final String actionTitle;
  final VoidCallback onSeeAllTap;
  const SelectionTextView(
      {super.key, required this.title, required this.onSeeAllTap, this.actionTitle = "See all"});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            maxLines: 1,
            textAlign: TextAlign.left,
            style: TextStyle(
                color: AppColor.black, fontSize: 16, fontWeight: FontWeight.w700),
          ),
          SizedBox(
            height: 35,
            child: TextButton(
              onPressed: onSeeAllTap,
              child: Text(
                actionTitle,
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: AppColor.blue,
                    fontSize: 16,
                    fontWeight: FontWeight.w700),
              ),
            ),
          )
        ],
      ),
    );
  }
}
