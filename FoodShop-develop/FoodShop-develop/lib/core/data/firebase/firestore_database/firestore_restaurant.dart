import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:find_food/core/configs/enum.dart';
import 'package:find_food/core/data/firebase/model/result.dart';

import 'package:find_food/features/model/restaurant_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreRestaurant {
  static final _fireStoreUserCollection =
      FirebaseFirestore.instance.collection('restaurant');

  static Future<Result<RestaurantModel>> createRestaurant(
      {required RestaurantModel newRestaurant, required String userId}) async {
    try {
      String restaurantId =
          FirebaseFirestore.instance.collection('restaurant').doc().id;
      newRestaurant.idRestaurant = restaurantId;
      newRestaurant.userId = userId;

      await _fireStoreUserCollection
          .doc(newRestaurant.idRestaurant)
          .set(newRestaurant.toJson());
      return Result.success(newRestaurant);
    } on FirebaseAuthException catch (e) {
      return Result.error(e);
    }
  }

  static Future<Result<bool>> updateRestaurant(
      RestaurantModel restaurant) async {
    try {
      await _fireStoreUserCollection
          .doc(restaurant.idRestaurant)
          .update(restaurant.toJson());
      return Result.success(true);
    } on FirebaseAuthException catch (e) {
      return Result.error(e);
    }
  }

  static Future<Result<bool>> deleteRestaurant(String restaurantId) async {
    try {
      await _fireStoreUserCollection.doc(restaurantId).delete();
      return Result.success(true);
    } on FirebaseAuthException catch (e) {
      return Result.error(e);
    }
  }

  static Future<Result<List<RestaurantModel>>> getRestaurantList() async {
    try {
      final snapshot = await _fireStoreUserCollection.get();
      final restaurantList = snapshot.docs
          .map((doc) => RestaurantModel.fromJson(doc.data()))
          .toList();
      return Result.success(restaurantList);
    } on FirebaseAuthException catch (e) {
      return Result.error(e);
    }
  }

  static Future<Result<RestaurantModel>> getRestaurant(String userId) async {
    try {
      final snapshot = await _fireStoreUserCollection
          .where('userId', isEqualTo: userId)
          .where('status', isEqualTo: StatusPosts.active.name)
          .get();
      if (snapshot.docs.isEmpty) {
        return Result.error(FirebaseAuthException(code: 'not found'),data: null);
      }
      final restaurant = RestaurantModel.fromJson(snapshot.docs.first.data());
      return Result.success(restaurant);
    } on FirebaseAuthException catch (e) {
      return Result.error(e);
    }
  }
  static Future<Result<RestaurantModel>> getRestaurantWaiting(String userId) async {
    try {
      final snapshot = await _fireStoreUserCollection
          .where('userId', isEqualTo: userId)
          .get();
      if (snapshot.docs.isEmpty) {
        return Result.error(FirebaseAuthException(code: 'not found'),data: null);
      }
      final restaurant = RestaurantModel.fromJson(snapshot.docs.first.data());
      return Result.success(restaurant);
    } on FirebaseAuthException catch (e) {
      return Result.error(e);
    }
  }
   static Future<Result<bool>> updateRestaurantStatus(
      {required String restaurantId, required StatusPosts newStatus}) async {
    try {
      await _fireStoreUserCollection
          .doc(restaurantId)
          .update({'status': newStatus.name});
      return Result.success(true);
    } on FirebaseAuthException catch (e) {
      return Result.error(e);
    }
  }

}
