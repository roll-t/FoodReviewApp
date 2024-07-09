import 'package:find_food/features/nav/notify/presentation/page/news_notify_page.dart';
import 'package:find_food/features/nav/notify/presentation/page/social_notify_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotifyController extends GetxController {
  var selectedTab = 'social'.obs;

  void selectTab(String tab) {
    selectedTab.value = tab;
  }

List<Widget> getPages() {
    return [
      SocialNotifyPage(),
      NewsNotifyPage(),
    ];
}

  var switchValue1 = false.obs;
  var switchValue2 = false.obs; 
}
