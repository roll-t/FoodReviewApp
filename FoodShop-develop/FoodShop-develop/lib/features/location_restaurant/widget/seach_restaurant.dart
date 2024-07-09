import 'package:find_food/features/location_restaurant/presentation/controller/location_restaurant_controller.dart';
import 'package:find_food/features/location_restaurant/widget/card_restaurant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SeachRestaurant extends GetView<LocationRestaurantController> {
  const SeachRestaurant({
    super.key,
    required this.controller,
  });

  final LocationRestaurantController controller;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(

        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: controller.searchController,
              focusNode: controller.searchFocusNode,
              decoration: const InputDecoration(
                labelText: 'Search restaurant here',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                ),
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: controller.filterItems,
            ),
            const SizedBox(height: 10),
            Obx(() {
              // Use Obx for reactive updates
              if (controller.isSearching.value) {
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: Colors.grey.shade200,
                  ),
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: controller.filteredItems.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(controller.filteredItems[index].name),
                        onTap: () {
                          controller.searchController.text = controller.filteredItems[index].name;
                          controller.filterItems(controller.filteredItems[index].name);
                          controller.hideKeyboard();
                        },
                      );
                    },
                  ),
                );
              } else {
                return SingleChildScrollView(
                  // height: controller.filteredItems.length * 100.0, 
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: controller.filteredItems.length,
                    itemBuilder: (context, index) {
                      return CardRestaurant(setrestaurant: controller.filteredItems[index]);
                    },
                  ),
                );
              }
            }),
          ],
        ),
      ),
    );
  }
}
