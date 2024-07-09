import 'dart:ffi';
import 'dart:ui';

import 'package:find_food/core/ui/widgets/appbar/set_restaurant_appbar.dart';
import 'package:find_food/features/location_restaurant/presentation/controller/location_restaurant_controller.dart';
import 'package:find_food/features/location_restaurant/widget/card_restaurant.dart';
import 'package:find_food/features/location_restaurant/widget/seach_restaurant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class LocationRestaurantPage extends GetView<LocationRestaurantController> {
  const LocationRestaurantPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const SetRestaurantAppbar(),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                SeachRestaurant(controller: controller),
                const SizedBox(height: 10),
                Obx(() {
                  if (controller.isSearching.value) {
                    final cardfilter = controller
                        .filterItemsCard(controller.searchController.text);
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: controller.filteredItems.length,
                      itemBuilder: (context, index) {
                        // print("CASE1");

                        if (controller.searchController.text ==
                            controller.filteredItems[index].name) {
                          final restaurant = controller.filteredItems[index];
                          return CardRestaurant(setrestaurant: restaurant);
                        }
                      },
                    );
                  }
                   else {
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: controller.allItems.length,
                      itemBuilder: (context, index) {
                        // print("CASE2");
                        final cardfilter = controller
                            .filterItemsCard(controller.searchController.text);
                        final restaurant = controller.allItems[index];
                        // return CardRestaurant(setrestaurant: restaurant);
                      },
                    );
                  }
                }),
              ],
            ),
          ),
        ));
  }
}
