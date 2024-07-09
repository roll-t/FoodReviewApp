import 'package:find_food/core/extensions/required.dart';
import 'package:find_food/core/ui/widgets/loading/LoadingFull.dart';
import 'package:find_food/core/ui/widgets/nav/BottomNavigationBarWidget.dart';
import 'package:find_food/features/main/presentation/controller/main_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainPage extends GetView<MainController> {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Navigator(
            key: Get.nestedKey(10),
            initialRoute: "/home",
            onGenerateRoute: controller.onGenerateRoute,
          ),

          Obx(() {
            return !controller.isLocationServiceEnabled.value &&
                    controller.showRequiredLocationBox.value
                ? RequiredLocation(controller: controller)
                : const SizedBox();
          }),
          
          Obx(() {
            return controller.isLoading.value
                ? const LoadingFull()
                : const SizedBox();
          }),
        ],

      ),
      bottomNavigationBar:
          Obx(() => _bottomNavigationBar(controller.isLoading.value)),
    );
  }

  Widget _bottomNavigationBar(bool hidden) {
    return Obx(() {
      return BottomNavigationBarWidget(
        currentIndex: controller.currentIndex.value,
        onPageChanged: (index) {
          if (!hidden) controller.onChangeItemBottomBar(index);
        },
        allowSelect: !hidden,
      );
    });
  }
}
