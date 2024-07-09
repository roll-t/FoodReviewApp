import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:find_food/core/data/firebase/model/result.dart';
import 'package:find_food/features/model/comment_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreComment {
  static final _fireStoreUserCollection =
      FirebaseFirestore.instance.collection('comments');

  static Future<Result<bool>> createComment(CommentModel comment) async {
    try {
      String idComment =
          FirebaseFirestore.instance.collection('comments').doc().id;
      comment!.idComment = idComment;
      await _fireStoreUserCollection
          .doc(comment.idComment)
          .set(comment.toJson());
      return Result.success(true);
    } on FirebaseAuthException catch (e) {
      return Result.error(e);
    }
  }

  static Future<Result<List<CommentModel>>> getListComments(
      String postId) async {
    try {
      QuerySnapshot querySnapshot = await _fireStoreUserCollection
          .where('idPost', isEqualTo: postId)
          .get();

      List<CommentModel> activityList = querySnapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return CommentModel.fromJson(data);
      }).toList();

      return Result.success(activityList);
    } on FirebaseException catch (e) {
      return Result.error(e);
    }
  }

  // xóa comments
  static Future<Result<bool>> deleteComment(String idComment) async {
    try {
      await _fireStoreUserCollection.doc(idComment).delete();
      return Result.success(true);
    } on FirebaseAuthException catch (e) {
      return Result.error(e);
    }
  }
}
