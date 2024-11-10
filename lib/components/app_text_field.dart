import 'package:final_app_flutter/resources/app_color.dart';
import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    this.hintText,
    this.controller,
    this.isPassword = false,
    this.iconData,
    this.iconPass,
    this.onPass,
    this.readOnly = false,
    this.errorText,
    this.onChanged,
    this.textInputAction,
    this.validator,
  });

  final String? hintText;
  final TextEditingController? controller;
  final bool isPassword;
  final IconData? iconData;
  final IconData? iconPass;
  final VoidCallback? onPass;
  final bool readOnly;
  final String? errorText;
  final ValueChanged<String>? onChanged;
  final TextInputAction? textInputAction;
  final FormFieldValidator<String>? validator;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20.0),
      decoration: BoxDecoration(
        color: AppColor.white,
        border: Border.all(color: AppColor.white),
        borderRadius: BorderRadius.circular(19.0),
        boxShadow: const [
          BoxShadow(
            offset: Offset(0, 3),
            color: AppColor.white,
            blurRadius: 6,
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              readOnly: readOnly,
              obscureText: isPassword,
              controller: controller,
              onChanged: onChanged,
              validator: validator,
              decoration: InputDecoration(
                prefixIcon: Icon(iconData, color: AppColor.black),
                border: InputBorder.none,
                hintText: hintText,
                prefixIconConstraints: const BoxConstraints(minWidth: 40),
                errorText: errorText,
              ),
              textInputAction: textInputAction,
            ),
          ),
          if (iconPass != null && onPass != null)
            GestureDetector(
              onTap: onPass,
              child: Icon(
                iconPass,
                color: AppColor.black,
              ),
            ),
          const SizedBox(width: 10),
        ],
      ),
    );
  }
}
