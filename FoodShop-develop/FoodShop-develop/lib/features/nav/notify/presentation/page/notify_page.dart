import 'package:find_food/core/configs/app_colors.dart';
import 'package:find_food/core/ui/widgets/appbar/notify_appbar.dart';
import 'package:find_food/core/ui/widgets/button/button_widget.dart';
import 'package:find_food/features/nav/notify/presentation/page/news_notify_page.dart';
import 'package:find_food/features/nav/notify/presentation/page/social_notify_page.dart';
import 'package:find_food/features/nav/notify/presentation/controller/notify_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotifyPage extends GetView<NotifyController> {
  const NotifyPage({super.key});

  @override
  Widget build(BuildContext context) {
    final NotifyController controller = Get.put(NotifyController());

    return Scaffold(
      appBar: const NotifyAppbar(),
      body: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                child: Obx(
                  () => ButtonWidget(
                      width: MediaQuery.of(context).size.width / 2 - 8,
                      borderColor: AppColors.black,
                      borderRadius: 5.0,
                      ontap: () => controller.selectTab('social'),
                      backgroundColor: controller.selectedTab.value == 'social'
                          ? AppColors.primary
                          : AppColors.white,
                      textColor: controller.selectedTab.value == 'social'
                          ? AppColors.white
                          : AppColors.black,
                      text: "Social"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                child: Obx(
                  () => ButtonWidget(
                      width: MediaQuery.of(context).size.width / 2 - 8,
                      borderColor: AppColors.black,
                      borderRadius: 5.0,
                      ontap: () => controller.selectTab('news'),
                      backgroundColor: controller.selectedTab.value == 'news'
                          ? AppColors.primary
                          : AppColors.white,
                      textColor: controller.selectedTab.value == 'news'
                          ? AppColors.white
                          : AppColors.black,
                      text: "News"),
                ),
              ),
            ],
          ),
          Expanded(
            child: Obx(
              () {
                if (controller.selectedTab.value == 'news') {
                  return NewsNotifyPage();
                } else {
                  return SocialNotifyPage();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}


