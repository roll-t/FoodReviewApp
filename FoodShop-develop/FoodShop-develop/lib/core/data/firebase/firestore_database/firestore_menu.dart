import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:find_food/core/data/firebase/model/result.dart';
import 'package:find_food/features/model/menu_food_restaurant_model.dart';

import 'package:firebase_auth/firebase_auth.dart';

class FirestoreMenu {
  static final _fireStoreUserCollection =
      FirebaseFirestore.instance.collection('menu');

  static Future<Result<MenuModel>> createMenu(
      {required MenuModel newMenu, required String userId}) async {
    try {
      String menuId = FirebaseFirestore.instance.collection('menu').doc().id;
      newMenu.idMenu = menuId;
      newMenu.userId = userId;

      await _fireStoreUserCollection.doc(newMenu.idMenu).set(newMenu.toJson());
      return Result.success(newMenu);
    } on FirebaseAuthException catch (e) {
      return Result.error(e);
    }
  }

  static Future<Result<MenuModel>> updateMenu(
      {required MenuModel newMenu, required String userId}) async {
    try {
      newMenu.userId = userId;
      await _fireStoreUserCollection
          .doc(newMenu.idMenu)
          .update(newMenu.toJson());
      return Result.success(newMenu);
    } on FirebaseAuthException catch (e) {
      return Result.error(e);
    }
  }

  static Future<Result<MenuModel>> deleteMenu(
      {required MenuModel newMenu, required String userId}) async {
    try {
      newMenu.userId = userId;
      await _fireStoreUserCollection.doc(newMenu.idMenu).delete();
      return Result.success(newMenu);
    } on FirebaseAuthException catch (e) {
      return Result.error(e);
    }
  }

  static Future<Result<List<MenuModel>>> getMenu(
      {required String restaurantID}) async {
    try {
      final result = await _fireStoreUserCollection
          .where('idRestaurant', isEqualTo: restaurantID)
          .get();
      final List<MenuModel> listMenu = result.docs
          .map((e) => MenuModel.fromJson(e.data() as Map<String, dynamic>))
          .toList();
      return Result.success(listMenu);
    } on FirebaseAuthException catch (e) {
      return Result.error(e);
    }
  }
}