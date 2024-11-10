import 'package:flutter/material.dart';

import '../model/shoes_model.dart';
import '../resources/app_color.dart';

class CheckoutItem extends StatelessWidget {
  const CheckoutItem(
    this.shoe, {
    super.key,
  });

  final ShoesModel shoe;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      decoration: BoxDecoration(
        color: AppColor.white,
        border: Border.all(color: AppColor.blue, width: 1.2),
        borderRadius: const BorderRadius.all(Radius.circular(20.0)),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            offset: Offset(0.0, 3.0),
            blurRadius: 6.0,
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(20.0)),
            child: Image.asset(
              shoe.imageStr ?? '',
              width: 120.0,
              height: 120.0,
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  shoe.name ?? '-:-',
                  style: const TextStyle(
                      color: AppColor.black,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                ),
                const SizedBox(height: 4.0),
                Row(
                  children: [
                    const Text(
                      "Size :",
                      style: TextStyle(
                          color: AppColor.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(
                      width: 7,
                    ),
                    Text(
                      '${shoe.size ?? 0}',
                      style: const TextStyle(
                        color: AppColor.black,
                        fontSize: 16.0,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Text(
                      '\$',
                      style: TextStyle(
                          color: AppColor.grey,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w500),
                    ),
                    Text(
                      shoe.price?.toStringAsFixed(1) ?? '-:-',
                      style:
                          const TextStyle(color: AppColor.grey, fontSize: 16.0),
                    ),
                    const SizedBox(width: 120),
                    const Text(
                      'x',
                      style: TextStyle(color: AppColor.grey, fontSize: 16.0),
                    ),
                    Text(
                      '${shoe.quantity ?? 0}',
                      style:
                          const TextStyle(color: AppColor.grey, fontSize: 16.0),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
