import 'package:find_food/app.dart';
import 'package:find_food/core/configs/app_colors.dart';
import 'package:find_food/core/configs/app_dimens.dart';
import 'package:find_food/core/ui/widgets/text/text_widget.dart';
import 'package:find_food/features/control_restaurants/restaurant_setting/pressentation/controller/restaurant_setting_controller.dart';
import 'package:find_food/features/control_restaurants/restaurant_setting/widgets/appbar_restaurant_setting.dart';
import 'package:find_food/features/control_restaurants/restaurant_setting/widgets/body_restaurant_setting.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

class RestaurantSettingPage extends GetView<RestaurantSettingController> {
  const RestaurantSettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarRestaurantSetting(),
      body: BuildBodyRestaurantSetting(),
    );
  }
}
