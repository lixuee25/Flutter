import 'dart:io';
import 'dart:math' as math;
import 'package:final_app_flutter/resources/app_color.dart';
import 'package:flutter/material.dart';

class TdAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TdAppBar({
    super.key,
    this.leftPressed,
    this.color = AppColor.bgColor,
    this.title,
    this.icon,
    this.showAvatar,
    this.onAvatar,
    this.imageFile,
  });

  final Function()? leftPressed;
  final Function()? onAvatar;
  final Color color;
  final String? title;
  final File? imageFile;
  final IconData? icon;
  final bool? showAvatar;

  @override
  Size get preferredSize => const Size.fromHeight(90.0);

  @override
  Widget build(BuildContext context) {
    double size = 26.0;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10)
          .copyWith(top: MediaQuery.of(context).padding.top + 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (leftPressed != null)
            GestureDetector(
              onTap: leftPressed,
              child: Transform.rotate(
                angle: 45 * math.pi / 180,
                child: Container(
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: icon == null ? AppColor.white : AppColor.tran,
                    borderRadius: BorderRadius.circular(20.0),
                    boxShadow: icon != null
                        ? null
                        : [
                            BoxShadow(
                                color: AppColor.grey,
                                offset: Offset(3, 0),
                                blurRadius: 6.0),
                          ],
                  ),
                  child: Transform.rotate(
                    angle: -math.pi / 4,
                    child: Icon(icon ?? Icons.arrow_back_ios_new,
                        color: AppColor.brown, size: size),
                  ),
                ),
              ),
            )
          else
            SizedBox(
                width: 70), // Placeholder width to align the title properly

          Text(
            title ?? '',
            style: TextStyle(
              color: AppColor.black,
              fontSize: size,
              fontWeight: FontWeight.w700,
            ),
          ),
          Visibility(
            visible: showAvatar ?? true,
            child: GestureDetector(
              onTap: onAvatar,
              child: ClipOval(
                child: Container(
                  width: size * 2,
                  height: size * 2,
                  child: imageFile != null
                      ? Image.file(
                          imageFile!,
                          fit: BoxFit.cover,
                        )
                      : Image.asset(
                          'assets/images/avt.jpg',
                          fit: BoxFit.cover,
                        ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
