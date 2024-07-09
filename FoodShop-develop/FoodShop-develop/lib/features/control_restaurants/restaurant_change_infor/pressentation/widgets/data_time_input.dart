import 'package:find_food/core/configs/app_colors.dart';
import 'package:find_food/core/ui/widgets/text/text_widget.dart';
import 'package:find_food/features/control_restaurants/restaurant_change_infor/pressentation/controller/restaurant_change_info_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DateTimeInput extends GetView<RestaurantChangeInfoController> {
  // final Rx<TimeOfDay> _selectedTime = TimeOfDay.now().obs;

  @override
  Widget build(BuildContext context) {
    return ListTile(
        tileColor: Colors.white10,
        leading: const Icon(Icons.timer),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
          side: const BorderSide(color: Colors.grey),
        ),
        title: const TextWidget(
          text: 'Chọn giờ mở cửa',
          color: AppColors.primary,
        ),
        subtitle: Obx(() {
          return Text(
              'Chọn giờ: ${controller.selectedTimeOnl.value.format(context)}');
        }),
        onTap: () {
          controller.selectTimeOnline(context);
        });
  }
}
