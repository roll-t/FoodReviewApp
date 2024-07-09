import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:find_food/core/configs/enum.dart';
import 'package:find_food/features/auth/user/domain/use_case/get_user_use_case.dart';
import 'package:find_food/features/auth/user/model/user_model.dart';
import 'package:find_food/features/model/post_data_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final GetuserUseCase _getuserUseCase;
  HomeController(this._getuserUseCase);

  List<PostDataModel> listPost = [];
  UserModel? user;
  ScrollController scrollController = ScrollController();
  final StreamController<List<DocumentSnapshot>> _postController =
      StreamController<List<DocumentSnapshot>>.broadcast();

  final List<DocumentSnapshot> _allPagedResults = [];
  int pageLimit = 20;
  DocumentSnapshot? _lastDocument;
  bool _hasMoreData = true;
  bool isLoading = false;

  @override
  void onInit() async {
    super.onInit();
    user = await _getuserUseCase.getUser();
    scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (scrollController.position.atEdge &&
        scrollController.position.pixels != 0) {
      _getPosts();
    }
  }

  Stream<List<DocumentSnapshot>> listenToPostsRealTime() {
    _getPosts();
    return _postController.stream;
  }

  Future<void> _getPosts() async {
    if (!_hasMoreData || isLoading) return;

    isLoading = true;

    final CollectionReference postCollectionReference =
        FirebaseFirestore.instance.collection('posts');
    var pagechatQuery = postCollectionReference
        .orderBy('createAt', descending: true)
        .limit(pageLimit);

    if (_lastDocument != null) {
      pagechatQuery = pagechatQuery.startAfterDocument(_lastDocument!);
    }

    try {
      var snapshot = await pagechatQuery.get();
      if (snapshot.docs.isNotEmpty) {
        var newPosts = snapshot.docs
            .map((doc) =>
                PostDataModel.fromJson(doc.data() as Map<String, dynamic>))
            .where((post) => post.status == StatusPosts.active)
            .toList();

        _allPagedResults.addAll(snapshot.docs
            .where((doc) => newPosts.any((post) => post.id == doc.id)));

        _postController.add(_allPagedResults);

        _lastDocument = snapshot.docs.last;

        _hasMoreData = newPosts.length == pageLimit;
        
      } else {
        _hasMoreData = false;
      }
    } catch (e) {
      print(e);
    } finally {
      isLoading = false;
    }
  }

  Future<void> refreshPosts() async {
    _hasMoreData = true;
    _allPagedResults.clear();
    _lastDocument = null;
    await _getPosts();
    update(['fetchListPost']);
  }

  @override
  void onClose() {
    scrollController.dispose();
    _postController.close();
    super.onClose();
  }
}
