import 'package:final_app_flutter/model/shoes_model.dart';
import 'package:flutter/material.dart';

import '../resources/app_color.dart';

class ShoesItem extends StatelessWidget {
  const ShoesItem(
    this.shoe, {
    super.key,
    this.onAdd,
    this.onRemove,
    this.onDelete,
  });

  final Function()? onAdd;
  final Function()? onRemove;
  final Function()? onDelete;
  final ShoesModel shoe;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6.0).copyWith(right: 6.0),
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
                // Text(
                //   shoe.description ?? '-:-',
                //   style: const TextStyle(color: Colors.grey),
                //   // maxLines: 2,
                //   overflow: TextOverflow.ellipsis,
                //   textAlign: TextAlign.left,
                // ),
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
                          color: AppColor.black,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w500),
                    ),
                    Text(
                      shoe.price?.toStringAsFixed(1) ?? '-:-',
                      style: const TextStyle(fontSize: 16.0),
                    ),
                    const Spacer(),
                    SizedBox(
                      width: 42.0,
                      child: TextButton(
                        onPressed: onAdd,
                        child: const Text(
                          '+',
                          style:
                              TextStyle(color: AppColor.blue, fontSize: 20.0),
                        ),
                      ),
                    ),
                    Text(
                      '${shoe.quantity ?? 0}',
                      style: const TextStyle(
                          color: AppColor.black, fontSize: 16.0),
                    ),
                    SizedBox(
                      width: 42.0,
                      child: TextButton(
                        onPressed: onRemove,
                        child: const Text(
                          '-',
                          style:
                              TextStyle(color: AppColor.blue, fontSize: 20.0),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Text(
                      'Subtotal: ',
                      style: TextStyle(
                          color: AppColor.grey,
                          fontSize: 14.6,
                          fontWeight: FontWeight.w500),
                    ),
                    Text(
                      shoe.total.toStringAsFixed(1),
                      style: const TextStyle(
                        color: AppColor.grey,
                        fontSize: 14.6,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const Text(
                      '\$',
                      style: TextStyle(
                          color: AppColor.grey,
                          fontSize: 14.6,
                          fontWeight: FontWeight.w500),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: onDelete,
                      behavior: HitTestBehavior.translucent,
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: CircleAvatar(
                          backgroundColor: Colors.grey.withOpacity(0.8),
                          radius: 12.6,
                          child: const Icon(Icons.delete,
                              size: 14.0, color: Colors.white),
                        ),
                      ),
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
