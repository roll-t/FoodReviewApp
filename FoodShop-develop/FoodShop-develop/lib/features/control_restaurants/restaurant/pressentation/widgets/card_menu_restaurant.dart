import 'package:find_food/core/configs/app_colors.dart';
import 'package:find_food/core/configs/app_dimens.dart';
import 'package:find_food/features/control_restaurants/restaurant/pressentation/controller/restaurant_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class CardMenuRestaurant extends GetView<RestaurantController> {
  final String img;
  final String foodname;
  final String pricefood;
  const CardMenuRestaurant(
      {super.key,
      required this.img,
      required this.foodname,
      required this.pricefood});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Flexible(
            child: Image(
              image: AssetImage(img),
              height: 160,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            decoration: const BoxDecoration(
                border: Border(
              top: BorderSide(color: AppColors.primary, width: 5.0),
            )),
            padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  // controller:,
                  // overflow: TextOverflow.ellipsis,
                  softWrap: false,
                  foodname,
                  style: TextStyle(
                    fontSize: AppDimens.textSize18,
                    color: Colors.grey[800],
                  ),
                ),
                Container(height: 10),
                Text(
                  "Price: \$${pricefood}",
                  style: TextStyle(
                    fontSize: AppDimens.textSize14,
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 5),
        ],
      ),
    );
  }
}
