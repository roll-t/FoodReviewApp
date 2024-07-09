import 'package:find_food/core/configs/app_colors.dart';
import 'package:find_food/core/configs/app_images_string.dart';
import 'package:find_food/core/configs/app_text_string.dart';
import 'package:find_food/core/routes/routes.dart';
import 'package:find_food/core/ui/widgets/avatar/avatar.dart';
import 'package:find_food/core/ui/widgets/card/profile_card.dart';
import 'package:find_food/core/ui/widgets/loading/loading_data_page.dart';
import 'package:find_food/core/ui/widgets/text/text_widget.dart';
import 'package:find_food/features/model/post_data_model.dart';
import 'package:find_food/features/profile_client/presentation/controller/profile_client_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileClientPage extends GetView<ProfileClientController> {
  const ProfileClientPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: const Icon(Icons.arrow_back_ios)),
        title: Obx(() {
          if (controller.isLoading.value) {
            return const Text(AppTextString.fUserDefault);
          } else {
            return TextWidget(
              text: controller.user?.displayName ??
                  controller.user?.email ??
                  "Unknown User",
            );
          }
        }),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize:
              const Size.fromHeight(2), // Chiều cao của đường kẻ dưới
          child: Container(
            color: AppColors.primary, // Màu sắc của đường kẻ dưới
            height: 2, // Chiều cao của đường kẻ dưới
          ),
        ),
      ),
      body: RefreshIndicator(
          onRefresh: () async {
            await controller.getAuthorPost(); // Refresh data
          },
          child: GetBuilder<ProfileClientController>(
            id: "fetchListClientProfile",
            builder: (_) {
              return Obx(() => controller.isLoading.value
                  ? const LoadingDataPage()
                  : _BuildProfileClientBody());
            },
          )),
    );
  }

  // ignore: non_constant_identifier_names
  Widget _BuildProfileClientBody() {
    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            getWallpapper(bannerSize: 180),
            Positioned(
              bottom: -60, // Adjust this value as needed
              left: 0,
              right: 0,
              child: Center(
                child: Avatar(
                  radius: 140,
                  authorImg: controller.user?.avatarUrl,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 80,
        ),
        Container(
          width: Get.width * .95,
          height: 1,
          color: AppColors.black.withOpacity(.2),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [_BuildListPosts()],
            ),
          ),
        ),
      ],
    );
  }
  // ignore: non_constant_identifier_names
  Widget _BuildListPosts() {
    return controller.listPosts != null && controller.listPosts!.isNotEmpty
        ? GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: controller.listPosts!.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.7,
            ),
            itemBuilder: (_, index) {
              PostDataModel postDataModel = controller.listPosts![index];
              return InkWell(
                onTap: () => Get.toNamed(Routes.postsDetail),
                child: ProfileCard(
                  postDataModel: postDataModel,
                  controller: controller,
                ),
              );
            })
        : const Center(
            child: Text('No posts found'),
          );
  }

  Widget getWallpapper({required double bannerSize}) {
    return Container(
      height: bannerSize,
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: (controller.user?.backgroundUrl?.isNotEmpty ?? false)
              ? NetworkImage(controller.user!.backgroundUrl!)
              : const AssetImage(AppImagesString.iBackgroundUserDefault)
                  as ImageProvider,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
