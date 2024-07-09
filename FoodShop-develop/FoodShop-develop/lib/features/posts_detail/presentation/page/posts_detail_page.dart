import 'package:find_food/core/configs/app_dimens.dart';
import 'package:find_food/core/configs/enum.dart';
import 'package:find_food/core/routes/routes.dart';
import 'package:find_food/core/ui/widgets/loading/loading_data_page.dart';
import 'package:find_food/core/ui/widgets/text/text_widget.dart';
import 'package:find_food/features/posts_detail/presentation/controller/posts_detail_controller.dart';
import 'package:find_food/features/posts_detail/widgets/comment_box_widget.dart';
import 'package:find_food/features/posts_detail/widgets/top_posts_detail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class PostsDetailPage extends GetView<PostsDetailController> {
  const PostsDetailPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PostDetailAppBar(context),
      body: RefreshIndicator(
        onRefresh: () async {
          await controller.refreshPostsDetail();
        }, // Thêm sự kiện làm mới
        child: Obx(
          () {
            return controller.isLoading.value
                ? const LoadingDataPage()
                : SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: GetBuilder<PostsDetailController>(
                      id: "fetchDataPostsDetailPage",
                      builder: (_) {
                        return const Wrap(
                          runSpacing: AppDimens.columnSpacing,
                          children: [TopPostsDetail(), CommentBoxWidget()],
                        );
                      },
                    ),
                  );
          },
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  AppBar PostDetailAppBar(BuildContext context) {
    return AppBar(
      leading: InkWell(
          onTap: () {
            // controller.activeState?
            Get.back(result: {
              "postsId": controller.postDataModel!.id,
              "isFavorite": controller.isFavorite.value,
              "isBookmark": controller.isBookmark.value,
              "status": controller.postDataModel!.status
            });
          },
          child: const Icon(Icons.arrow_back_ios)),
      title: const TextWidget(text: "DETAIL"),
      centerTitle: true,
      actions: [
        Container(
            margin: const EdgeInsets.only(right: 10),
            child: GetBuilder<PostsDetailController>(
              id: "checkAuthorPosts",
              builder: (_) {
                return controller.userComment?.uid ==
                            controller.authorPosts?.uid &&
                        !controller.isLoading.value
                    ? settingOption(context)
                    : const SizedBox();
              },
            ))
      ],
    );
  }

  IconButton settingOption(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.settings),
      onPressed: () {
        final RenderBox overlay =
            Overlay.of(context).context.findRenderObject() as RenderBox;
        final Size overlaySize = overlay.size;
        final RelativeRect position = RelativeRect.fromLTRB(
          overlaySize.width, // Right padding
          Get.height * 0.09, // Top padding
          10, // Left padding (from right edge)
          overlaySize.height - kToolbarHeight, // Bottom padding
        );

        showMenu<String>(
          context: context,
          position: position,
          items: [
            const PopupMenuItem<String>(
              value: "_changeValue",
              child: Row(
                children: [
                  Icon(Icons.edit_document),
                  SizedBox(
                    width: 5,
                  ),
                  TextWidget(text: "Edit posts")
                ],
              ),
            ),
            PopupMenuItem<String>(
              value: "_changeStatus",
              child: Row(
                children: [
                  controller.postDataModel?.status == StatusPosts.active
                      ? const Icon(Icons.lock)
                      : const Icon(Icons.public),
                  const SizedBox(
                    width: 5,
                  ),
                  TextWidget(
                      text:
                          controller.postDataModel?.status == StatusPosts.active
                              ? "Private"
                              : "Public")
                ],
              ),
            ),
            const PopupMenuItem<String>(
              value: "_deleteValue",
              child: Row(
                children: [
                  Icon(Icons.delete),
                  SizedBox(
                    width: 5,
                  ),
                  TextWidget(text: "Delete")
                ],
              ),
            ),
          ],
          color: Colors.white.withOpacity(0.8),
        ).then((value) async {
          if (value != null) {
            if (value == "_changeValue") {
              Get.toNamed(Routes.editPosts,
                  arguments: controller.postDataModel);
            } else if (value == "_deleteValue") {
              _showDeleteConfirmationDialog(context);
            } else if (value == "_changeStatus") {
              controller.postDataModel?.status == StatusPosts.active
                  ? await controller.privatePosts()
                  : await controller.publicPosts();
            }
          }
        });
      },
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm'),
          content: const Text('Are you sure you want to delete this posts?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Đóng dialog
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop(); // Đóng dialog
                await controller.deletePosts();
                // ignore: use_build_context_synchronously
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Deleted posts')),
                );
              },
              child: const Text('Oke'),
            ),
          ],
        );
      },
    );
  }
}