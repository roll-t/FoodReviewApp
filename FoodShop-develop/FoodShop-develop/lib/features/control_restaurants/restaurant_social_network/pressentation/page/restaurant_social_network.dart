import 'package:find_food/app.dart';
import 'package:find_food/core/configs/app_colors.dart';
import 'package:find_food/core/ui/widgets/button/button_widget.dart';
import 'package:find_food/core/ui/widgets/text/text_widget.dart';
import 'package:find_food/features/control_restaurants/restaurant_change_infor/pressentation/widgets/data_time_input.dart';
import 'package:find_food/features/control_restaurants/restaurant_change_infor/pressentation/widgets/textform_input.dart';
import 'package:find_food/features/control_restaurants/restaurant_social_network/pressentation/controller/restaurant_social_network_controller.dart';
import 'package:find_food/features/control_restaurants/restaurant_social_network/pressentation/widgets/appbar_restaurant_social_network.dart';
import 'package:find_food/features/control_restaurants/restaurant_social_network/pressentation/widgets/body_restaurant_social_network.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RestaurantSocialNetwork
    extends GetView<RestaurantSocialNetworkController> {
  const RestaurantSocialNetwork({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppbarRestaurantSocialNetwork(),
      body: BuildBodyRestaurantSocialNetWork(),
    );
  }
}
