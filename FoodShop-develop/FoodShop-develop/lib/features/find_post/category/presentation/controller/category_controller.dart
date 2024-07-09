import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:find_food/core/configs/enum.dart';
import 'package:find_food/features/find_post/category/presentation/page/area_category_page.dart';
import 'package:find_food/features/find_post/category/presentation/page/favorite_category_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController {
  RxInt currentIndex = 0.obs;

  PageController pageController = PageController(initialPage: 0);

  RxList<DocumentSnapshot> areaPosts = <DocumentSnapshot>[].obs;

  DocumentSnapshot? _lastAreaDocument;
  int pageLimit = 10;
  bool _hasMoreAreaData = true;

  @override
  void onInit() async {
    super.onInit();
    await _getPosts();
  }

  void onChangeNavList(int index) {
    if (currentIndex.value == index) return;
    currentIndex.value = index;
    pageController.jumpToPage(index);
  }

  void onChangePage(int index) {
    currentIndex.value = index;
  }

  List<Widget> getPages() {
    return [const AreaCategoryPage(), const FavoriteCategoryPage()];
  }

  Future<void> _getPosts() async {
    _getAreaPosts();
  }

  void _getAreaPosts() async {
    final CollectionReference postCollectionReference =
        FirebaseFirestore.instance.collection('posts');

    var pageQuery = postCollectionReference
        .limit(pageLimit)
        .where("status", isEqualTo: StatusPosts.active.name);

    if (_lastAreaDocument != null) {
      pageQuery = pageQuery.startAfterDocument(_lastAreaDocument!);
    }

    if (!_hasMoreAreaData) return;

    pageQuery.snapshots().listen(
      (snapshot) {
        if (snapshot.docs.isNotEmpty) {
          var posts = snapshot.docs.toList();

          if (_lastAreaDocument == null) {
            areaPosts.assignAll(posts);
          } else {
            areaPosts.addAll(posts);
          }

          _lastAreaDocument = snapshot.docs.last;
          _hasMoreAreaData = posts.length == pageLimit;
        }
      },
    );
  }
}
