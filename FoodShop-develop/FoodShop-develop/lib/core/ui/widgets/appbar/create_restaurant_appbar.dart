import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateRestaurantAppbar extends StatelessWidget implements PreferredSizeWidget {
  const CreateRestaurantAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            onTap: () => Get.back(), child: const Icon(Icons.arrow_back)),
        title: const Text("Create Restaurant"),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            color: Colors.grey,
            height: 0.5,
          ),
        ),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => AppBar().preferredSize;
}
