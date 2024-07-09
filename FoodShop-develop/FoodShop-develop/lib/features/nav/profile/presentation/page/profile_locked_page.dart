import 'package:find_food/core/configs/enum.dart';
import 'package:find_food/core/routes/routes.dart';
import 'package:find_food/core/ui/widgets/card/profile_card.dart';
import 'package:find_food/features/model/post_data_model.dart';
import 'package:find_food/features/nav/profile/presentation/controller/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:get/get.dart';

class ProfileLockedPage extends GetView<ProfileController> {
  const ProfileLockedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return controller.listPostsOfUserLocked.isNotEmpty
        ? GetBuilder<ProfileController>(
            id: "listPostsLocker",
            builder: (_) {
              return GridView.builder(
                  shrinkWrap: true,
                  itemCount: controller.listPostsOfUserLocked.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, childAspectRatio: 0.7),
                  itemBuilder: (_, index) {
                    PostDataModel postDataModel =
                        controller.listPostsOfUserLocked[index];
                    return InkWell(
                      onTap: () async {
                        var result =
                            await Get.toNamed(Routes.postsDetail, arguments: {
                          'postsData': postDataModel,
                        });
                        if (result != null) {
                          if (result['status'] != null) {
                            if (result['status'] == StatusPosts.active) {
                              await controller.getPostsOfUserPrivate();
                              controller.checkLoadList['listPosts']=false;
                              controller.update(["listPostsLocker"]);
                            }
                          }
                        }
                      },
                      child: ProfileCard(
                        postDataModel: postDataModel,
                        controller: controller,
                      ),
                    );
                  });
            })
        : const Center(
            child: Text("No locked posts found"),
          );
  }
}
