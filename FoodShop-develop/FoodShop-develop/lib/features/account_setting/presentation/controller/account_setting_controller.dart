import 'package:find_food/core/configs/enum.dart';
import 'package:find_food/core/data/firebase/firestore_database/firestore_restaurant.dart';
import 'package:find_food/core/data/prefs/prefs.dart';
import 'package:find_food/features/maps/domain/get_location_case.dart';
import 'package:find_food/features/maps/domain/save_location_case.dart';
import 'package:find_food/features/maps/location/models/place_map.dart';
import 'package:find_food/features/model/VietnamProvinces%20.dart';
import 'package:get/get.dart';
import 'dart:math' as math;

class AccountSettingController extends GetxController {
  final SaveLoactionCase _saveLoactionCase;
  final GetLocationCase _getLocationCase;
  AccountSettingController(this._saveLoactionCase, this._getLocationCase);

  var isWaitingCreateRestaurant = false.obs;

  PlaceMap? place;

  var dataArgument = Get.arguments;

  String locationName = "";

  var isRetaurant = false.obs;

  @override
  void onInit() async {
    super.onInit();
    await _loadLocation();
    if (dataArgument != null) {
      if (dataArgument['restaurant'] != null) {
        isRetaurant.value = true;
      }
      if (dataArgument['uid'] != null) {
        var uid = dataArgument['uid'];
        print(uid);
        if (uid != "") {
          await getRestaurantWaiting(uid: uid);
        }
      }
    }
    update(['fetchRestaurant']);
  }

  _loadLocation() async {
    place = await _getLocationCase.getLocation();
    locationName = place?.displayName ?? "Add or change your location";
    // Check if the current location falls within any province
    String? provinceName =
        checkProvinceLocation(place!.lat ?? 0.0, place!.lon ?? 0.0);
    if (provinceName != null) {
      locationName = '${place!.displayName} ($provinceName)';
    }
    update(['fetchLocaiton']);
  }

  // Log out user and clear preferences
  static Future<void> logoutUser() async {
    final Prefs prefs = Prefs.preferences;
    await prefs.clear();
    Get.offAllNamed('/login');
  }

  getRestaurantWaiting({required String uid}) async {
    var result = await FirestoreRestaurant.getRestaurantWaiting(uid);
    if (result.status == Status.success) {
      isWaitingCreateRestaurant.value = true;
      print(isWaitingCreateRestaurant);
    }
  }

  // Save the current location using SaveLoactionCase
  void saveLocation(PlaceMap place) async {
    _saveLoactionCase.saveLocation(place);
    await _loadLocation();
    update(['fetchLocaiton']);
  }

  // Function to check which province the location falls within
  String? checkProvinceLocation(double latitude, double longitude) {
    for (var province in VietnamProvinces.provinces) {
      double distance = calculateDistance(
          latitude, longitude, province.latitude, province.longitude);
      if (distance <= province.radius) {
        return province.name;
      }
    }
    return null;
  }

  // Function to calculate the distance between two coordinates using Haversine formula
  double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
    const double radiusEarth = 6371; // Earth's radius in kilometers
    double dLat = (lat2 - lat1).toRadians();
    double dLon = (lon2 - lon1).toRadians();
    double a = math.sin(dLat / 2) * math.sin(dLat / 2) +
        math.cos(lat1.toRadians()) *
            math.cos(lat2.toRadians()) *
            math.sin(dLon / 2) *
            math.sin(dLon / 2);
    double c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));
    return radiusEarth * c;
  }
}

// Extension method to convert degrees to radians
extension on double {
  double toRadians() {
    return this * math.pi / 180;
  }
}
