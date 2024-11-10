import 'package:final_app_flutter/resources/app_color.dart';
import 'package:flutter/material.dart';

class TdSearchBox extends StatelessWidget {
  const TdSearchBox({super.key, this.controller, this.onSubmitted});

  final TextEditingController? controller;
  final Function(String)? onSubmitted;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 8.0, right: 16.0),
      decoration: BoxDecoration(
        color: AppColor.white,
        border: Border.all(color: AppColor.grey),
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: const [
          BoxShadow(
            color: AppColor.shadow,
            offset: Offset(0.0, 3.0),
            blurRadius: 6.0,
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        onSubmitted: onSubmitted,
        decoration: const InputDecoration(
          border: InputBorder.none,
          prefixIcon: Icon(Icons.search, color: AppColor.red),
          prefixIconConstraints: BoxConstraints(minWidth: 28.0),
          hintText: 'Search',
          hintStyle: TextStyle(color: AppColor.grey),
        ),
      ),
    );
  }
}
