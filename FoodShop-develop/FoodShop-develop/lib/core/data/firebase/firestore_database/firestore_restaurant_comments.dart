import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:find_food/core/data/firebase/model/result.dart';
import 'package:find_food/features/model/comments_restaurant_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreRestaurantComments {
  static final _fireStorRestaurantCollection =
      FirebaseFirestore.instance.collection('commentsRestaurant');

  static Future<Result<bool>> createComment(
      CommentsRestaurantModel commentsRestaurant) async {
    try {
      String idCommentRestaurant =
          FirebaseFirestore.instance.collection('commentsRestaurant').doc().id;
      commentsRestaurant!.idCommentRestaurant = idCommentRestaurant;
      await _fireStorRestaurantCollection
          .doc(commentsRestaurant.idCommentRestaurant)
          .set(commentsRestaurant.toJson());
      return Result.success(true);
    } on FirebaseAuthException catch (e) {
      return Result.error(e);
    }
  }

  static Future<Result<List<CommentsRestaurantModel>>> getListComments(
      String postId) async {
    try {
      QuerySnapshot querySnapshot = await _fireStorRestaurantCollection
          .where('idPost', isEqualTo: postId)
          .get();

      List<CommentsRestaurantModel> activityList =
          querySnapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return CommentsRestaurantModel.fromJson(data);
      }).toList();

      return Result.success(activityList);
    } on FirebaseException catch (e) {
      return Result.error(e);
    }
  }

  // xóa comments
  static Future<Result<bool>> deleteComment(String idCommentRestaurant) async {
    try {
      await _fireStorRestaurantCollection.doc(idCommentRestaurant).delete();
      return Result.success(true);
    } on FirebaseAuthException catch (e) {
      return Result.error(e);
    }
  }
}
