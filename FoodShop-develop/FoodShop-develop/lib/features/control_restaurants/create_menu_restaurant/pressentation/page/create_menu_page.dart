import 'package:find_food/features/control_restaurants/create_menu_restaurant/pressentation/controller/create_menu_controller.dart';
import 'package:find_food/features/control_restaurants/create_menu_restaurant/pressentation/widgets/upload_single_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateMenuPage extends GetView<CreateMenuController> {
  const CreateMenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Create Menu'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                const UploadSingleImage(),
                TextField(
                  controller: controller.nameFood,
                  decoration: const InputDecoration(labelText: 'Name'),
                ),
                TextField(
                  controller: controller.price,
                  decoration: const InputDecoration(labelText: 'Price'),
                ),
                ElevatedButton(
                  onPressed: () {
                    controller.createMenu();
                  },
                  child: const Text('Create'),
                ),
              ],
            ),
          ),
        ));
  }
}
