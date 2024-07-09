import 'package:find_food/core/configs/enum.dart';
import 'package:find_food/core/data/firebase/firestore_database/firestore_favorite.dart';
import 'package:find_food/core/data/firebase/firestore_database/firestore_post_data.dart';
import 'package:find_food/core/data/firebase/firestore_database/firestore_bookmark.dart';
import 'package:find_food/core/services/location_service.dart';
import 'package:find_food/core/ui/dialogs/dialogs.dart';
import 'package:find_food/core/utils/calculator_utils.dart';
import 'package:find_food/features/model/favorite_model.dart';
import 'package:find_food/features/model/bookmark_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:find_food/core/data/firebase/firestore_database/firestore_comment.dart';
import 'package:find_food/core/ui/snackbar/snackbar.dart';
import 'package:find_food/features/auth/user/domain/use_case/get_user_use_case.dart';
import 'package:find_food/features/auth/user/model/user_model.dart';
import 'package:find_food/features/model/comment_model.dart';
import 'package:find_food/features/model/post_data_model.dart';
import 'package:find_food/core/data/firebase/firestore_database/firestore_user.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:intl/intl.dart'; // Thêm import cho việc phân tích ngày tháng

class PostsDetailController extends GetxController {
  final GetuserUseCase _getuserUseCase;

  PostsDetailController(this._getuserUseCase);

  UserModel? userComment;

  List<CommentModel> listComments = [];

  PostDataModel? postDataModel;

  final dataAgument = Get.arguments as Map<String, dynamic>;

  final commentController = TextEditingController();

  List<PostDataModel> postsDetail = [];

  List<dynamic> listImagesPostDetail = [];

  String timePosts = "";

  UserModel? authorPosts;

  bool isRestaurant = false;

  int currentIndex = 0;

  final PageController mainPageController = PageController();

  var isFavorite = false.obs;

  var distance = 0.0;

  var isBookmark = false.obs;

  var isFavoriteComments = false.obs;

  var isLoading = false.obs;

  var activeState = false;

  get commentFocusNode => null;

  bool isProcessing = false;

  final LocationService locationService = Get.find<LocationService>();

  @override
  void onInit() async {
    super.onInit();
    isLoading.value = true;
    await _initialize();
    userComment = await _getuserUseCase.getUser();
    if (dataAgument != null) {
      postDataModel = dataAgument["postsData"];
      listImagesPostDetail = postDataModel?.imageList ?? [];
      await getComments();
      timePosts = CaculateTime(postDataModel?.createAt);
      update(['fetchDataTopPostDetail', 'checkAuthorPosts']);
    }

    isLoading.value = false;
  }

  Future<void> deletePosts() async {
    isLoading.value = true;
    await FirestorePostData.deletePostAndRelatedData(postDataModel?.id ?? "");
    isLoading.value = false;
    Get.back(result: {"deleteSuccess": true});
  }

  Future<void> _initialize() async {
    userComment = await _getuserUseCase.getUser();
    if (dataAgument != null) {
      postDataModel = dataAgument['postsData'];
      distance =
          await distanceCalculate(postsData: postDataModel ?? PostDataModel());

      listImagesPostDetail = postDataModel?.imageList ?? [];
      isFavorite.value =
          await FirestoreFavorite.checkFavoriteExistsByUserAndPostId(
              userId: userComment!.uid, postId: postDataModel!.id ?? "");
      isBookmark.value =
          await FirestoreBookmark.checkBookmarkExistsByUserAndPostId(
              userId: userComment!.uid, postId: postDataModel!.id ?? "");
      await getAuthorPost();
      update(['fetchDataTopPostDetail', 'checkAuthorPosts']);
    }
    timePosts = CaculateTime(postDataModel?.createAt);
  }

  Future<void> toggleFavoriteState(
      {required PostDataModel posts, required bool stateIcon}) async {
    isProcessing = true;
    activeState = true;
    if (stateIcon) {
      await FirestoreFavorite.createFavorite(FavoriteModel(
          author: userComment,
          posts: posts,
          createdAt: DateTime.now().toString()));
    } else {
      await FirestoreFavorite.deleteFavoriteByUserAndPostId(
          userId: userComment!.uid, postId: posts.id ?? "");
    }
    isFavorite.value = !isFavorite.value;
    isProcessing = false;
    update([posts.id ?? ""]);
  }

  Future<void> privatePosts() async {
    try {
      isLoading.value = true;
      await FirestorePostData.updateStatus(
          postDataModel?.id ?? "", StatusPosts.private);
      isLoading.value = false;
      Fluttertoast.showToast(msg: "Posts is Privaiting Status");
      postDataModel!.status = StatusPosts.private;
      update(['fetchDataPostsDetailPage']);
    } catch (e) {
      Fluttertoast.showToast(msg: "Change status posts fauil");
    }
  }

  Future<void> publicPosts() async {
    try {
      isLoading.value = true;
      await FirestorePostData.updateStatus(
          postDataModel?.id ?? "", StatusPosts.active);
      isLoading.value = false;
      Fluttertoast.showToast(msg: "Posts is Privaiting Status");
      postDataModel!.status = StatusPosts.active;
      update(['fetchDataPostsDetailPage']);
    } catch (e) {
      Fluttertoast.showToast(msg: "Change status posts fauil");
    }
  }

  Future<void> toggleBookmarkState({required bool stateIcon}) async {
    isProcessing = true;
    if (!stateIcon) {
      await FirestoreBookmark.createBookmark(BookmarkModel(
          author: userComment,
          posts: postDataModel ?? PostDataModel(),
          createdAt: DateTime.now().toString()));
    } else {
      await FirestoreBookmark.deleteBookmarkByUserAndPostId(
          userId: userComment!.uid, postId: postDataModel?.id ?? "");
    }
    isBookmark.value = !isBookmark.value;
    isProcessing = false;
  }

  refreshPostsDetail() async {
    isLoading.value = true;
    userComment = await _getuserUseCase.getUser();
    if (dataAgument is PostDataModel) {
      postDataModel = dataAgument["postsData"];
      listImagesPostDetail = postDataModel?.imageList ?? [];
      await getComments();
      timePosts = CaculateTime(postDataModel?.createAt);
      await getAuthorPost();
      update(['fetchDataTopPostDetail', 'checkAuthorPosts']);
    }

    isLoading.value = false;
  }

  getAuthorPost() async {
    final result = await FirestoreUser.getUser(postDataModel!.userId!);
    if (result.status == Status.success) {
      authorPosts = result.data;
    }
  }

  Future<int> getCountFavorite(String postId) async {
    return await FirestoreFavorite.countFavoritesByPostId(postId);
  }

  Future<double> distanceCalculate({required PostDataModel postsData}) async {
    var placeMap = await locationService.getLocation();
    if (placeMap != null) {
      double placeLat = placeMap.lat ?? 0.0;
      double placeLon = placeMap.lon ?? 0.0;
      double postLat = postsData.latitude ?? 0.0;
      double postLon = postsData.longitude ?? 0.0;
      double distance = CalculatorUtils.calculateDistance(
        placeLat,
        placeLon,
        postLat,
        postLon,
      );
      distance = double.parse(distance.toStringAsFixed(2));
      return double.parse(distance.toStringAsFixed(2));
    }
    return 0.0;
  }

  // ignore: non_constant_identifier_names
  String CaculateTime(String? createAt) {
    if (createAt == null) {
      return "";
    }
    DateTime postCreationTime =
        DateFormat("yyyy-MM-ddTHH:mm:ss").parse(createAt);
    DateTime currentTime = DateTime.now();
    Duration difference = currentTime.difference(postCreationTime);
    String timeAgo = _formatDuration(difference);
    return timeAgo;
  }

  String _formatDuration(Duration duration) {
    if (duration.inDays > 0) {
      return '${duration.inDays}d ago';
    } else if (duration.inHours > 0) {
      return '${duration.inHours}h ago';
    } else if (duration.inMinutes > 0) {
      return '${duration.inMinutes}m ago';
    } else {
      return '${duration.inSeconds}s ago';
    }
  }

  var isExpanded = false.obs;

  void toggleExpanded() {
    isExpanded.value = !isExpanded.value;
  }

  getComments() async {
    final result = await FirestoreComment.getListComments(postDataModel!.id!);
    if (result.status == Status.success) {
      listComments = result.data!;
      listComments.sort((a, b) {
        DateTime dateA = DateFormat("yyyy-MM-dd HH:mm:ss").parse(a.createdAt!);
        DateTime dateB = DateFormat("yyyy-MM-dd HH:mm:ss").parse(b.createdAt!);
        return dateB.compareTo(dateA);
      });
      update(["fetchComment"]);
    } else {
      SnackbarUtil.show(result.exp!.message ?? "something_went_wrong");
    }
  }

  void uploadComment() async {
    // kiểm tra comments có rỗng
    if (commentController.text.trim().isEmpty) {
      Fluttertoast.showToast(msg: "Comment cannot be empty".tr);
      return;
    }
    // kiểm tra độ dài của comment
    const int maxCommentLength = 200; // Set the maximum comment length
    if (commentController.text.length > maxCommentLength) {
      Fluttertoast.showToast(
          msg: "Comment cannot exceed $maxCommentLength characters".tr);
      return;
    }
    final comment = CommentModel(
      author: userComment!,
      comment: commentController.text,
      favorite: 0,
      idPost: postDataModel!.id!,
      createdAt: DateTime.now().toString(),
      isFavoriteComments: false,
    );
    final result = await FirestoreComment.createComment(comment);
    if (result.status == Status.success) {
      listComments.insert(0, comment);
      update(["fetchComment"]);
      Fluttertoast.showToast(msg: "Add comments success".tr);
    } else {
      Fluttertoast.showToast(msg: "Add comments error".tr);
      Fluttertoast.showToast(msg: "Add comments error".tr);
    }
    commentController.clear();
    update();
  }

  // phương thức xóa bình luận
  void deleteComment(String idComment) async {
    print(idComment);
    final result = await FirestoreComment.deleteComment(idComment);
    if (result.status == Status.success) {
      listComments.removeWhere((element) => element.idComment == idComment);
      update(["fetchComment"]);
      Fluttertoast.showToast(msg: "Delete comments success".tr);
    } else {
      Fluttertoast.showToast(msg: "Delete comments error".tr);
    }
  }

  void previousImage() {
    if (currentIndex > 0) {
      currentIndex--;
      mainPageController.previousPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.ease,
      );
    }
  }

  void nextImage() {
    if (currentIndex < listImagesPostDetail.length - 1) {
      currentIndex++;
      mainPageController.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.ease,
      );
    }
  }

  void toggleFavoriteComments(CommentModel comment) {
    comment.isFavoriteComments = !comment.isFavoriteComments!;
    update(["fetchComment"]);
  }

  void showDialogDeleteComment(String id) {
    DialogsUtils.showAlertDialog(
      title: "Delete comment",
      message: "Are you sure you want to delete this comment?",
      typeDialog: TypeDialog.warning,
      onPresss: () => (deleteComment(id)),
    );
  }

  void showMoreImages() {
    Get.dialog(
      AlertDialog(
        title: const Text('All images'),
        content: SizedBox(
          width: double.maxFinite,
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 10.0,
            ),
            itemCount: listImagesPostDetail.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {},
                child: Image.network(
                  listImagesPostDetail[index],
                  fit: BoxFit.cover,
                ),
              );
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text('close'),
          ),
        ],
      ),
    );
  }

  @override
  void onClose() {
    mainPageController.dispose();
    super.onClose();
  }

  Route? onGenerateRoute(Route setting) {
    return null;
  }

  bool hiddenStar(double star) => star == 0.0;

  List<String> listPathUrl = [];
  var selectedImages = <File>[].obs;

  UserModel? user;

  Future<void> pickImages() async {
    final picker = ImagePicker();
    final pickedImages = await picker.pickMultiImage();
    selectedImages
        .addAll(pickedImages.map((image) => File(image.path)).toList());
  }

  void removeImage(File image) {
    selectedImages.remove(image);
  }

  void hideKeyboard() {
    FocusScope.of(Get.context!).requestFocus(FocusNode());
  }
}