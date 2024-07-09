import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:find_food/core/configs/enum.dart';
import 'package:find_food/core/data/firebase/model/result.dart';
import 'package:find_food/features/model/post_data_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirestorePostData {
  static final _fireStorePostCollection =
      FirebaseFirestore.instance.collection('posts');
  static final _storage = FirebaseStorage.instance;
  static final _fireStoreCommentsCollection =
      FirebaseFirestore.instance.collection('comments');
  static final _fireStoreBookmarksCollection =
      FirebaseFirestore.instance.collection('bookmarks');
  static final _fireStoreFavoritesCollection =
      FirebaseFirestore.instance.collection('favorites');

  static Future<Result<PostDataModel>> savedPost(
      {required PostDataModel postDataModel, required String userId}) async {
    try {
      String activityId = _fireStorePostCollection.doc().id;
      postDataModel.id = activityId;
      postDataModel.userId = userId;
      await _fireStorePostCollection
          .doc(activityId)
          .set(postDataModel.toJson());
      return Result.success(postDataModel);
    } on FirebaseException catch (e) {
      return Result.error(e);
    }
  }

  static Future<Result<List<PostDataModel>>> getListPostOfUser(
      String userId) async {
    try {
      QuerySnapshot querySnapshot = await _fireStorePostCollection
          .where('userId', isEqualTo: userId)
          .get();

      List<PostDataModel> activityList = querySnapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return PostDataModel.fromJson(data);
      }).toList();

      return Result.success(activityList);
    } on FirebaseException catch (e) {
      return Result.error(e);
    }
  }

  static Future<Result<List<PostDataModel>>> getListPostOfUserPublic(
      String userId) async {
    try {
      QuerySnapshot querySnapshot = await _fireStorePostCollection
          .where('userId', isEqualTo: userId)
          .where('status', isEqualTo: StatusPosts.active.name)
          .get();

      List<PostDataModel> activityList = querySnapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return PostDataModel.fromJson(data);
      }).toList();

      return Result.success(activityList);
    } on FirebaseException catch (e) {
      return Result.error(e);
    }
  }

  static Future<Result<List<PostDataModel>>> getListPostOfUserPrivite(
      String userId) async {
    try {
      QuerySnapshot querySnapshot = await _fireStorePostCollection
          .where('userId', isEqualTo: userId)
          .where('status', isEqualTo: StatusPosts.private.name)
          .get();

      List<PostDataModel> activityList = querySnapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return PostDataModel.fromJson(data);
      }).toList();

      return Result.success(activityList);
    } on FirebaseException catch (e) {
      return Result.error(e);
    }
  }

  static Future<Result<List<PostDataModel>>> getListBookmarkedPosts(
      String userId) async {
    try {
      QuerySnapshot querySnapshot = await _fireStorePostCollection
          .where('isBookmarked', arrayContains: userId)
          .get();

      List<PostDataModel> activityList = querySnapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return PostDataModel.fromJson(data);
      }).toList();

      return Result.success(activityList);
    } on FirebaseException catch (e) {
      return Result.error(e);
    }
  }

  static Future<Result<List<PostDataModel>>> getListFavoritePosts(
      String userId) async {
    try {
      QuerySnapshot querySnapshot = await _fireStorePostCollection
          .where('isFavorited', arrayContains: userId)
          .get();

      List<PostDataModel> activityList = querySnapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return PostDataModel.fromJson(data);
      }).toList();

      return Result.success(activityList);
    } on FirebaseException catch (e) {
      return Result.error(e);
    }
  }

  static Future<Result<List<PostDataModel>>> getListPost() async {
    try {
      QuerySnapshot querySnapshot = await _fireStorePostCollection.get();

      List<PostDataModel> activityList = querySnapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return PostDataModel.fromJson(data);
      }).toList();

      return Result.success(activityList);
    } on FirebaseException catch (e) {
      return Result.error(e);
    }
  }

  static Future<Result<List<PostDataModel>>> getListPostRelate(
      {int limit = 10}) async {
    try {
      QuerySnapshot querySnapshot = await _fireStorePostCollection
          .limit(limit)
          .where("status",isEqualTo: StatusPosts.active.name) // Apply the limit here
          .get();

      List<PostDataModel> activityList = querySnapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return PostDataModel.fromJson(data);
      }).toList();

      return Result.success(activityList);
    } on FirebaseException catch (e) {
      return Result.error(e);
    }
  }

  static Future<Result<List<PostDataModel>>> getListPostArea(
      {int limit = 10}) async {
    try {
      QuerySnapshot querySnapshot = await _fireStorePostCollection
          .limit(limit) // Apply the limit here
          .get();

      List<PostDataModel> activityList = querySnapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return PostDataModel.fromJson(data);
      }).toList();

      return Result.success(activityList);
    } on FirebaseException catch (e) {
      return Result.error(e);
    }
  }

  static Future<Result<List<PostDataModel>>> getListPostFavorite(
      {int limit = 10}) async {
    try {
      QuerySnapshot querySnapshot = await _fireStorePostCollection
          .limit(limit) // Apply the limit here
          .get();

      List<PostDataModel> activityList = querySnapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return PostDataModel.fromJson(data);
      }).toList();

      return Result.success(activityList);
    } on FirebaseException catch (e) {
      return Result.error(e);
    }
  }

  static Future<Result<bool>> deletePost(String postId) async {
    try {
      // Retrieve the post to get its image list
      DocumentSnapshot documentSnapshot =
          await _fireStorePostCollection.doc(postId).get();

      if (!documentSnapshot.exists) {
        return Result.error(FirebaseAuthException(
            code: 'post-not-found',
            message: 'No post found with the provided ID.'));
      }

      Map<String, dynamic> postData =
          documentSnapshot.data() as Map<String, dynamic>;
      PostDataModel postDataModel = PostDataModel.fromJson(postData);

      // Delete each image from Firebase Storage
      if (postDataModel.imageList != null) {
        for (String imageUrl in postDataModel.imageList!) {
          await _deleteImageFromStorage(imageUrl);
        }
      }

      // Delete the post from Firestore
      await _fireStorePostCollection.doc(postId).delete();
      return Result.success(true);
    } on FirebaseException catch (e) {
      return Result.error(e);
    }
  }

  static Future<Result<void>> deletePostAndRelatedData(String postId) async {
    try {
      WriteBatch batch = FirebaseFirestore.instance.batch();
     // Truy vấn bài viết để lấy danh sách hình ảnh
      DocumentSnapshot postSnapshot = await _fireStorePostCollection.doc(postId).get();
      if (postSnapshot.exists) {
        PostDataModel post = PostDataModel.fromDocumentSnapshot(postSnapshot);

        // Xóa hình ảnh từ Firebase Storage
        if (post.imageList != null) {
          for (String imageUrl in post.imageList!) {
            await _deleteImageFromStorage(imageUrl);
          }
        }

        // Xóa bài viết
        batch.delete(postSnapshot.reference);
      }

      // Xóa các bookmarks liên quan đến bài viết
      QuerySnapshot bookmarkSnapshot = await _fireStoreBookmarksCollection
          .where('postId', isEqualTo: postId)
          .get();
      for (DocumentSnapshot doc in bookmarkSnapshot.docs) {
        batch.delete(doc.reference);
      }

      // Xóa các favorites liên quan đến bài viết
      QuerySnapshot favoriteSnapshot = await _fireStoreFavoritesCollection
          .where('posts.id', isEqualTo: postId)
          .get();
      for (DocumentSnapshot doc in favoriteSnapshot.docs) {
        batch.delete(doc.reference);
      }

      // Commit the batch
      await batch.commit();

      return Result.success(null);
    } on FirebaseException catch (e) {
      return Result.error(e);
    }
  }

  static Future<void> _deleteImageFromStorage(String imageUrl) async {
    try {
      Reference storageReference = _storage.refFromURL(imageUrl);
      await storageReference.delete();
    } on FirebaseException catch (e) {
      print('Error deleting image from Firebase Storage: $e');
    }
  }

  static Future<Result<PostDataModel>> getPost(String postId) async {
    try {
      DocumentSnapshot documentSnapshot =
          await _fireStorePostCollection.doc(postId).get();
      if (documentSnapshot.exists) {
        Map<String, dynamic> postData =
            documentSnapshot.data() as Map<String, dynamic>;
        return Result.success(PostDataModel.fromJson(postData));
      } else {
        return Result.error(FirebaseAuthException(
            code: 'post-not-found',
            message: 'No post found with the provided ID.'));
      }
    } on FirebaseAuthException catch (e) {
      return Result.error(e);
    } catch (e) {
      return Result.error(
          FirebaseAuthException(code: 'unknown-error', message: e.toString()));
    }
  }

  static Future<Result<List<PostDataModel>>> searchPosts(String query) async {
    try {
      QuerySnapshot querySnapshot = await _fireStorePostCollection
          .where('title', isGreaterThanOrEqualTo: query)
          .where('title', isLessThanOrEqualTo: query + '\uf8ff')
          .get();

      List<PostDataModel> activityList = querySnapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return PostDataModel.fromJson(data);
      }).toList();

      return Result.success(activityList);
    } on FirebaseException catch (e) {
      return Result.error(e);
    }
  }

  static Future<Result<bool>> updateField(
      String postId, Map<String, dynamic> data) async {
    try {
      await _fireStorePostCollection.doc(postId).update(data);
      return Result.success(true);
    } on FirebaseAuthException catch (e) {
      return Result.error(e);
    }
  }

  static Future<Result<bool>> updateStatus(
      String postId, StatusPosts status) async {
    try {
      await _fireStorePostCollection
          .doc(postId)
          .update({"status": status.name});
      return Result.success(true);
    } on FirebaseAuthException catch (e) {
      return Result.error(e);
    }
  }

  static Future<Result<bool>> incrementFavoriteCount(String postId) async {
    try {
      await _fireStorePostCollection.doc(postId).update({
        'favoriteCount': FieldValue.increment(1),
      });
      return Result.success(true);
    } on FirebaseAuthException catch (e) {
      return Result.error(e);
    }
  }

  static Future<Result<bool>> decrementFavoriteCount(String postId) async {
    try {
      await _fireStorePostCollection.doc(postId).update({
        'favoriteCount': FieldValue.increment(-1),
      });
      return Result.success(true);
    } on FirebaseAuthException catch (e) {
      return Result.error(e);
    }
  }

  static Future<Result<bool>> updatePost(PostDataModel postDataModel) async {
    try {
      await _fireStorePostCollection
          .doc(postDataModel.id)
          .update(postDataModel.toJson());
      return Result.success(true);
    } on FirebaseAuthException catch (e) {
      return Result.error(e);
    }
  }
}
