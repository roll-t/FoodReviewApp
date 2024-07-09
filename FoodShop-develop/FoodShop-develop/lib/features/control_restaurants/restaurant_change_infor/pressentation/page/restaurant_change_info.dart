import 'package:find_food/core/configs/app_colors.dart';
import 'package:find_food/core/ui/widgets/button/button_widget.dart';
import 'package:find_food/core/ui/widgets/textfield/custom_textfield_widget.dart';
import 'package:find_food/features/control_restaurants/restaurant_change_infor/pressentation/controller/restaurant_change_info_controller.dart';
import 'package:find_food/features/control_restaurants/restaurant_change_infor/pressentation/widgets/appbar_restaurant_changeinfor.dart';
import 'package:find_food/features/control_restaurants/restaurant_change_infor/pressentation/widgets/data_time_input.dart';
import 'package:find_food/features/control_restaurants/restaurant_change_infor/pressentation/widgets/textform_input.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RestaurantChangeInfo extends GetView<RestaurantChangeInfoController> {
  const RestaurantChangeInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BuildAppbarRestaurantChangeInfor(),
      body: BuildBodyRestaurantChangeInfor(),
    );
  }
}

class BuildBodyRestaurantChangeInfor extends StatelessWidget {
  const BuildBodyRestaurantChangeInfor({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          Form(
              child: Column(
            children: [
              const textFormInput(
                label: 'Facebook',
              ),
              SizedBox(
                height: 20,
              ),
              const textFormInput(
                label: 'Email Address',
              ),
              SizedBox(
                height: 20,
              ),
              const textFormInput(
                label: 'Phone Number',
              ),
              const SizedBox(
                height: 20,
              ),
              DateTimeInput(),
              const SizedBox(
                height: 20,
              ),
              ButtonWidget(
                ontap: () {},
                text: 'Change Settings',
              )
            ],
          ))
        ],
      ),
    );
  }
}
