import 'package:find_food/core/routes/routes.dart';
import 'package:find_food/core/ui/widgets/card/profile_card.dart';
import 'package:find_food/features/model/post_data_model.dart';
import 'package:find_food/features/nav/profile/presentation/controller/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:get/get.dart';

class ProfileFavoritePage extends GetView<ProfileController> {
  const ProfileFavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return controller.listFavoritePosts.isNotEmpty
        ? GetBuilder<ProfileController>(
            id: "fetchlistFavorite",
            builder: (_) {
              return GridView.builder(
                  shrinkWrap: true,
                  itemCount: controller.listFavoritePosts.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, childAspectRatio: 0.7),
                  itemBuilder: (_, index) {
                    PostDataModel postDataModel =
                        controller.listFavoritePosts[index];
                    return 
                    InkWell(
                      onTap: () async {
                        var result = await Get.toNamed(Routes.postsDetail,
                            arguments: {
                              'postsData': postDataModel,
                              "isFavorite": false
                            });
                        if (result != null) {
                          if (result['isFavorite'] != null) {
                            if (result['isFavorite'] == false) {
                              await controller.getFavoritePosts();
                              controller.update(["fetchlistFavorite"]);
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
            child: Text("No favorite posts found"),
          );
  }
}
