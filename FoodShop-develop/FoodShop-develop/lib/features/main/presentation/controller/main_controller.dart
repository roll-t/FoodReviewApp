import 'package:find_food/core/configs/enum.dart';
import 'package:find_food/core/services/location_service.dart';
import 'package:find_food/core/ui/dialogs/dialogs.dart';
import 'package:find_food/features/auth/user/domain/use_case/get_user_use_case.dart';
import 'package:find_food/features/nav/explore/search/di/search_binding.dart';
import 'package:find_food/features/nav/explore/search/presentation/page/search_page.dart';
import 'package:find_food/features/nav/home/home/di/home_binding.dart';
import 'package:find_food/features/nav/home/home/presentation/page/home_page.dart';
import 'package:find_food/features/nav/notify/presentation/page/notify_page.dart';
import 'package:find_food/features/nav/post/upload/di/upload_binding.dart';
import 'package:find_food/features/nav/post/upload/presentation/page/upload_page.dart';
import 'package:find_food/features/nav/profile/di/profile_binding.dart';
import 'package:find_food/features/nav/profile/presentation/page/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class MainController extends GetxController {
  RxInt currentIndex = 0.obs;

  final GetuserUseCase _getuserUseCase;

  MainController(this._getuserUseCase, this.locationService);

  final LocationService locationService;

  bool user = false;

  var isLocationServiceEnabled = false.obs;

  var showRequiredLocationBox = true.obs;
  
  
  @override
  void onInit() {
    super.onInit();
    _getuserUseCase.getUser().then((value) {
      if (value != null) {
        user = true;
      }
    });
    checkLocationService();
  }

  Future<void> initializeLocation() async {
    isLoading.value = true;
    await locationService.initializeLocation();
    isLoading.value = false;
  }

  Future<void> checkLocationService() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      isLocationServiceEnabled.value = false;
      return;
    }
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        isLocationServiceEnabled.value = false;
        return;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      isLocationServiceEnabled.value = false;
      return;
    }

    isLocationServiceEnabled.value = true;
    initializeLocation();
  }

  // ignore: non_constant_identifier_names
  Future<void> CloseRequiredLocationBox() async {
    showRequiredLocationBox.value=false;
  }

  final pages = <String>[
    '/home',
    '/explore',
    '/upload_post',
    '/notify',
    '/profile'
  ];

  var isLoading = false.obs;

  Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    if (settings.name == '/home') {
      return GetPageRoute(
        settings: settings,
        page: () => const HomePage(),
        binding: HomeBinding(),
        transition: Transition.fadeIn,
      );
    }

    if (settings.name == '/explore') {
      return GetPageRoute(
        settings: settings,
        page: () => const SearchPage(),
        binding: SearchBinding(),
        transition: Transition.fadeIn,
      );
    }

    if (settings.name == '/upload_post') {
      return GetPageRoute(
        settings: settings,
        page: () => const UploadPage(),
        binding: UploadBinding(),
        transition: Transition.fadeIn,
      );
    }

    if (settings.name == '/notify') {
      return GetPageRoute(
        settings: settings,
        page: () => const NotifyPage(),
        // binding: ProfileBindding(),
        transition: Transition.fadeIn,
      );
    }

    if (settings.name == '/profile') {
      return GetPageRoute(
        settings: settings,
        page: () => const ProfilePage(),
        binding: ProfileBindding(),
        transition: Transition.fadeIn,
      );
    }

    return null;
  }

  void onChangeItemBottomBar(int index) {
    if (currentIndex.value == index) return;

    if (index == 2 && !user) {
      DialogsUtils.showAlertDialog(
          title: "Don't have account",
          message: "you want login account",
          typeDialog: TypeDialog.warning);
    }

    currentIndex.value = index;

    Get.offAndToNamed(pages[index], id: 10);
  }
}
