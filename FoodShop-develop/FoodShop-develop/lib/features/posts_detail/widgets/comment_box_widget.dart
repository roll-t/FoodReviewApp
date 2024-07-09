import 'package:find_food/core/configs/app_colors.dart';
import 'package:find_food/core/configs/app_dimens.dart';
import 'package:find_food/core/extensions/helper.dart';
import 'package:find_food/core/ui/widgets/card/comments_card.dart';
import 'package:find_food/features/model/comment_model.dart';
import 'package:find_food/features/posts_detail/presentation/controller/posts_detail_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommentBoxWidget extends GetWidget<PostsDetailController> {
  const CommentBoxWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Đóng bàn phím khi nhấn vào bất kỳ nơi nào khác trên màn hình
        FocusScope.of(context).unfocus();
      },
      child: SingleChildScrollView(
        // padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(AppDimens.radius1),
            boxShadow: CustomShadow.cardShadow,
          ),
          child: MainContentCommentBox(controller: controller),
        ),
      ),
    );
  }
}

class MainContentCommentBox extends StatelessWidget {
  const MainContentCommentBox({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final PostsDetailController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GetBuilder<PostsDetailController>(
          id: "fetchComment",
          builder: (_) => Container(
            constraints: BoxConstraints(
              maxHeight: Get.height * 0.5,
            ),
            child: controller.listComments.isNotEmpty
                ? ListView.builder(
                    padding: const EdgeInsets.only(bottom: 10),
                    itemCount: controller.listComments.length,
                    itemBuilder: (context, index) {
                      CommentModel dataComments =
                          controller.listComments[index];
                      return GestureDetector(
                        //kiem tra id cua user dang dang nhap va id cua user dang comment
                        onLongPress: () {
                          if (controller.userComment!.uid ==
                              dataComments.author.uid) {
                            controller.showDialogDeleteComment(
                                dataComments.idComment ?? "");
                          }
                        },
                        child: SingleChildScrollView(
                          child: CommentsCard(
                            comment:
                                dataComments.comment ?? "Comment is empty !!!",
                            toggleActive: () {
                              controller.toggleFavoriteComments(dataComments);
                            },
                            active: dataComments.isFavoriteComments ?? false,
                            commentModel: dataComments,
                          ),
                        ),
                      );
                    },
                  )
                : SizedBox(
                    height: Get.height * 0.1,
                    child: const Center(
                      child: Text('No comments available'),
                    ),
                  ),
          ),
        ),
        // comment input
        CommentBar(controller: controller),
      ],
    );
  }
}

class CommentBar extends StatelessWidget {
  const CommentBar({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final PostsDetailController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: const BoxDecoration(
        color: AppColors.gray2,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                // Đóng bàn phím khi nhấn vào bất kỳ nơi nào khác trên màn hình
                FocusScope.of(context).unfocus();
              },
              child: Container(
                padding: const EdgeInsets.only(left: 10),
                margin: const EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(AppDimens.radius1),
                  border: Border.all(
                    color: AppColors.gray.withOpacity(.6),
                  ),
                ),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxHeight: 100.0, // Set a max height
                  ),
                  child: Scrollbar(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      reverse: true, // Start scrolled to bottom
                      child: TextField(
                        controller: controller.commentController,
                        maxLines: null,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "Enter your comment",
                          hintStyle: TextStyle(color: AppColors.grey),
                        ),
                        // Đóng bàn phím khi nhấn phím Enter
                        onSubmitted: (_) {
                          FocusScope.of(context).unfocus();
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          // Center the send button vertically
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  controller.uploadComment();
                },
                child: Container(
                  margin: const EdgeInsets.only(top: 5),
                  child: Image.asset('assets/images/send.png'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
