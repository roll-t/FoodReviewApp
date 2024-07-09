import 'package:find_food/features/control_restaurants/restaurant/pressentation/model/restaurant_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LocationRestaurantController extends GetxController {
  Route? onGenerateRoute(Route setting) {
    return null;
  }

  var allItems = SetRestaurant.allItems.obs;
  final RxList<SetRestaurant> filteredItems = <SetRestaurant>[].obs;
  final RxBool isSearching = false.obs;
  final FocusNode searchFocusNode = FocusNode();
  final TextEditingController searchController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    filteredItems.assignAll(allItems);
    searchFocusNode.addListener(() {
      isSearching(searchFocusNode.hasFocus);
    });
  }

  List<SetRestaurant> filterItemsCard(String query) {
    return query.isEmpty
        ? allItems
        : allItems
            .where((restaurant) =>
                restaurant.name.toLowerCase().contains(query.toLowerCase()))
            .toList();
  }

  void filterItems(String query) {
    filteredItems.value = query.isEmpty
        ? allItems
        : allItems
            .where((restaurant) =>
                restaurant.name.toLowerCase().contains(query.toLowerCase()))
            .toList();
  }

  void hideKeyboard() {
    FocusScope.of(Get.context!).requestFocus(FocusNode());
  }
}
