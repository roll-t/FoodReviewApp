import 'package:find_food/core/configs/app_text_string.dart';
import 'package:find_food/core/ui/widgets/button/button_widget.dart';
import 'package:find_food/core/ui/widgets/text/text_widget.dart';
import 'package:find_food/features/account_setting/nav/create_restaurant/presentation/controller/create_restaurant_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FinishCreateRestaurantPage extends GetView<CreateRestaurantController> {
  const FinishCreateRestaurantPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(
            Icons.check_circle,
            color: Colors.green,
            size: 60,
          ),
          const SizedBox(height: 10.0),
          titleField(title: AppTextString.fCreateRestaurantTitle),
          const SizedBox(height: 10.0),
          subtitleField(title: AppTextString.fCreateRestaurantSubtitle),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 50.0, vertical: 20.0),
            child: ButtonWidget(
              ontap: () async {
                Get.close(5);
              },
              text: AppTextString.fComplete,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

TextWidget titleField({required String title}) {
  return TextWidget(
    text: title,
    size: 24.0,
    fontWeight: FontWeight.bold,
    textAlign: TextAlign.center,
  );
}

TextWidget subtitleField({required String title}) {
  return TextWidget(
    text: title,
    size: 13.0,
    textAlign: TextAlign.center,
  );
}
