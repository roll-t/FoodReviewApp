import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:find_food/core/configs/enum.dart';
import 'package:find_food/core/data/firebase/model/result.dart';
import 'package:find_food/features/auth/user/model/user_model.dart';
import 'package:find_food/features/model/favorite_model.dart';
import 'package:find_food/features/model/post_data_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreFavorite {
  static final _fireStoreFavoriteCollection =
      FirebaseFirestore.instance.collection('favorites');

  static final CollectionReference _fireStorePostsCollection = FirebaseFirestore.instance.collection('posts');

  static Future<Result<bool>> createFavorite(FavoriteModel favorite) async {
    try {
      String idfavorite =
          FirebaseFirestore.instance.collection('favorites').doc().id;
      favorite!.id = idfavorite;
      await _fireStoreFavoriteCollection.doc(favorite.id).set(favorite.toJson());
      return Result.success(true);
    } on FirebaseAuthException catch (e) {
      return Result.error(e);
    }
  }

  static Future<bool> checkFavoriteExistsById(String favoriteId) async {
    try {
      DocumentSnapshot docSnapshot =
          await _fireStoreFavoriteCollection.doc(favoriteId).get();
      return docSnapshot.exists;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> checkFavoriteExistsByUserAndPostId({required String userId,required String postId}) async {
    try {
      final snapshot = await _fireStoreFavoriteCollection
          .where('author.uid', isEqualTo: userId)
          .where('posts.id', isEqualTo: postId)
          .get();
      return snapshot.size > 0;
    } catch (e) {
      return false;
    }
  }

  static Future<int> countFavoritesByPostId(String postId) async {
    try {
      QuerySnapshot snapshot = await _fireStoreFavoriteCollection
          .where('posts.id', isEqualTo: postId)
          .get();
      return snapshot.docs.length;
    } catch (e) {
      return 0;
    }
  }

  static Future<Result<List<UserModel>>> getUsersWhoFavoritedPost(
      String postId) async {
    try {
      QuerySnapshot snapshot = await _fireStoreFavoriteCollection
          .where('posts.id', isEqualTo: postId)
          .get();
      List<UserModel> users = snapshot.docs
          .map((doc) =>
              UserModel.fromJson(doc['author'] as Map<String, dynamic>))
          .toList();
      return Result.success(users);
    } on FirebaseException catch (e) {
      return Result.error(e);
    }
  }

   static Future<Result<List<PostDataModel>>> getFavoritedPostOfUser(String uid) async {
    try {
      // Truy vấn các tài liệu trong collection 'favorites' có 'author.uid' bằng uid của người dùng
      QuerySnapshot favoriteSnapshot = await _fireStoreFavoriteCollection
          .where('author.uid', isEqualTo: uid)
          .get();
          
      // Lấy danh sách idPost từ các tài liệu yêu thích
      List<String> postIds = favoriteSnapshot.docs.map((doc) {
        FavoriteModel favorite = FavoriteModel.fromJson(doc.data() as Map<String, dynamic>);
        return favorite.posts.id!;
      }).toList();

      if (postIds.isEmpty) {
        return Result.success([]); // Trả về danh sách rỗng nếu không có idPost nào
      }
      
      // Truy vấn danh sách các bài viết dựa trên idPost
      QuerySnapshot postSnapshot = await _fireStorePostsCollection
          .where(FieldPath.documentId, whereIn: postIds)
          .where('status', isEqualTo: StatusPosts.active.name)
          .get();
          
      // Chuyển đổi các tài liệu thành danh sách các đối tượng PostDataModel
      List<PostDataModel> posts = postSnapshot.docs.map((doc) {
        return PostDataModel.fromDocumentSnapshot(doc);
      }).toList();
      
      // Trả về kết quả thành công với danh sách các bài đăng
      return Result.success(posts);
    } on FirebaseException catch (e) {
      // Ghi log lỗi
      print('Error fetching favorite posts: ${e.message}');
      
      // Trả về kết quả lỗi nếu có lỗi xảy ra
      return Result.error(e);
    }
  }

  static Future<Result<List<String>>> getPostsFavoritedByUser(
      String userId) async {
    try {
      QuerySnapshot snapshot = await _fireStoreFavoriteCollection
          .where('author.uid', isEqualTo: userId)
          .get();
      List<String> postIds =
          snapshot.docs.map((doc) => (doc['posts']['id'] as String)).toList();
      return Result.success(postIds);
    } on FirebaseException catch (e) {
      return Result.error(e);
    }
  }

  static Future<Result<void>> deleteFavoriteByUserAndPostId(
      {required String userId, required String postId}) async {
    try {
      QuerySnapshot snapshot = await _fireStoreFavoriteCollection
          .where('author.uid', isEqualTo: userId)
          .where('posts.id', isEqualTo: postId)
          .limit(1)
          .get();

      if (snapshot.docs.isNotEmpty) {
        await _fireStoreFavoriteCollection.doc(snapshot.docs.first.id).delete();
        return Result.success(null);
      } else {
        return Result.error(FirebaseAuthException(
          code: 'favorite-not-found',
          message: 'Favorite not found for the specified user and post.',
        ));
      }
    } on FirebaseException catch (e) {
      return Result.error(e);
    }
  }


}
