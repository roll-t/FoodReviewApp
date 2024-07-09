import 'package:find_food/core/configs/app_dimens.dart';
import 'package:flutter/material.dart';

class ResultSearchAppbar extends StatelessWidget {
  const ResultSearchAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: const Icon(Icons.search),
      title: const Text(
        "Search",
        style: TextStyle(
            fontWeight: FontWeight.w500, fontSize: AppDimens.textSize26),
      ),
    );
  }
}
