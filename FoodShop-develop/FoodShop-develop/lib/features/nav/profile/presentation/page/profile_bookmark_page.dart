import 'package:find_food/core/routes/routes.dart';
import 'package:find_food/core/ui/widgets/card/profile_card.dart';
import 'package:find_food/features/model/post_data_model.dart';
import 'package:find_food/features/nav/profile/presentation/controller/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileBookmarkPage extends GetView<ProfileController> {
  const ProfileBookmarkPage({super.key});
  @override
  Widget build(BuildContext context) {
    return controller.listBookmarkedPosts.isNotEmpty
        ? GetBuilder<ProfileController>(
            id: "listPostsBookmark",
            builder: (_) {
              return GridView.builder(
                  shrinkWrap: true,
                  itemCount: controller.listBookmarkedPosts.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, childAspectRatio: 0.7),
                  itemBuilder: (_, index) {
                    PostDataModel postDataModel =
                        controller.listBookmarkedPosts[index];
                    return InkWell(
                      onTap: () async {
                        var result = await Get.toNamed(Routes.postsDetail,
                            arguments: {
                              'postsData': postDataModel,
                              "isBookmark": false
                            });
                        if (result != null) {
                          if (result['isBookmark'] != null) {
                            if (result['isBookmark'] == false) {
                              await controller.getBookmarkedPosts();
                              controller.update(["listPostsBookmark"]);
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
            child: Text("No bookmarked posts found"),
          );
  }
}
