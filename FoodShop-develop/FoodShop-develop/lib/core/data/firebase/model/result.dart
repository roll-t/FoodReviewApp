import 'package:find_food/core/configs/enum.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Result<T> {
  final Status status;
  final T? data;
  final FirebaseException? exp;

  Result(this.status, this.data, this.exp);

  factory Result.success(T? data) {
    return Result(Status.success, data, null);
  }

  factory Result.error(
    FirebaseException? exp, {
    T? data,
  }) {
    return Result(Status.error, data, exp);
  }
}
