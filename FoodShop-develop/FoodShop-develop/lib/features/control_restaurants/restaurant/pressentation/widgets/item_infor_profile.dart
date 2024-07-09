import 'package:find_food/core/configs/app_dimens.dart';
import 'package:flutter/material.dart';

class ItemInforProfile extends StatelessWidget {
  final int quantity;
  final String title;
  const ItemInforProfile({
    super.key,
    required this.quantity,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          quantity.toString(),
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: AppDimens.textSize14,
          ),
          textAlign: TextAlign.center,
          maxLines: 1,
          // overflow: TextOverflow.ellipsis,
        ),
        Text(
          title,
          style: const TextStyle(
            fontSize: AppDimens.textSize18,
          ),
          textAlign: TextAlign.center,
          maxLines: 2,
          // overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
