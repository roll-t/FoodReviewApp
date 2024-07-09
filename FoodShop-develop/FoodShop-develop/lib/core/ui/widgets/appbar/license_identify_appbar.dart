import 'package:find_food/core/configs/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LicenseIdentifyAppbar extends StatelessWidget implements PreferredSizeWidget {
  const LicenseIdentifyAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            onTap: () => Get.back(), child: const Icon(Icons.arrow_back)),
        title: const Text("License Identify"),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            color: AppColors.primary,
            height: 2.0,
          ),
        ),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => AppBar().preferredSize;
}
