import 'package:find_food/core/configs/app_colors.dart';
import 'package:find_food/core/ui/widgets/appbar/profile_appbar.dart';
import 'package:find_food/core/ui/widgets/avatar/avatar.dart';
import 'package:find_food/core/ui/widgets/background/background.dart';
import 'package:find_food/core/ui/widgets/loading/loading_data_page.dart';
import 'package:find_food/core/ui/widgets/text/text_widget.dart';
import 'package:find_food/features/nav/profile/presentation/controller/profile_controller.dart';
import 'package:find_food/features/nav/profile/presentation/widgets/nav_controll_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfilePage extends GetView<ProfileController> {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ProfileAppbar(controller: controller),
      body: RefreshIndicator(
        onRefresh: controller.refreshProfilePage,
        child: GetBuilder<ProfileController>(
          id: "fetchDataProfilePage",
          builder: (_) {
            return controller.isLoading.value
                ? const LoadingDataPage()
                : buildProfileBodyPage();
          },
        ),
      ),
    );
  }

  Widget buildProfileBodyPage() {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          _buildUserInfo(),
          const SizedBox(height: 10.0),
          Obx(() => NavControllList(
                currentIndex: controller.currentIndex.value,
                onPageChanged: controller.onChangeNavList,
              )),
          GetBuilder<ProfileController>(
              id: "fetchBodyList",
              builder: (_) {
                return SizedBox(
                  height: Get.height * 0.6,
                  width: double.infinity,
                  child: Obx(() {
                    return controller.isLoadPosts.value
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : PageView(
                            controller: controller.pageController,
                            onPageChanged: (index) {
                              controller.onChangePage(index);
                            },
                            children: controller.getPages(),
                          );
                  }),
                );
              })
        ],
      ),
    );
  }

  Widget _buildUserInfo() {
    return SizedBox(
      height: Get.height * 0.36,
      child: Stack(
        children: [
          _buildBackground(),
          _buildAvatarAndName(),
        ],
      ),
    );
  }

  Widget _buildBackground() {
    return GestureDetector(
      onTap: controller.selectImageBackground,
      child: GetBuilder<ProfileController>(
        id: "updateBackground",
        builder: (_) {
          return Background(
            authorImg: controller.user?.backgroundUrl ?? '',
            heightBg: Get.height * 0.24,
          );
        },
      ),
    );
  }

  Widget _buildAvatarAndName() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          GestureDetector(
            onTap: controller.selectImageAvatar,
            child: GetBuilder<ProfileController>(
              id: "updateAvatar",
              builder: (_) {
                return PhysicalModel(
                  color: AppColors.transparent,
                  shape: BoxShape.circle,
                  elevation: 10.0,
                  shadowColor: AppColors.black,
                  child: Avatar(
                      authorImg: controller.user?.avatarUrl ?? '', radius: 100),
                );
              },
            ),
          ),
          const SizedBox(height: 10.0),
          TextWidget(
            text: controller.user?.displayName ?? controller.user?.email ?? '',
            size: 20.0,
            fontWeight: FontWeight.w500,
          ),
        ],
      ),
    );
  }
}
