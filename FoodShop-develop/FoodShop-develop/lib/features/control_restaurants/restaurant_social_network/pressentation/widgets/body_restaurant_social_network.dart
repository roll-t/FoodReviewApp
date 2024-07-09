import 'package:find_food/core/ui/widgets/button/button_widget.dart';
import 'package:find_food/features/control_restaurants/restaurant_change_infor/pressentation/widgets/textform_input.dart';
import 'package:flutter/material.dart';

class BuildBodyRestaurantSocialNetWork extends StatelessWidget {
  const BuildBodyRestaurantSocialNetWork({
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
                label: 'TikTok',
              ),
              const SizedBox(
                height: 20,
              ),
              const textFormInput(
                label: 'Twitter',
              ),
              const SizedBox(
                height: 20,
              ),
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
