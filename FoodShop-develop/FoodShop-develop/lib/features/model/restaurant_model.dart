import 'package:find_food/core/configs/enum.dart';

class RestaurantModel {
  String? idRestaurant;
  String? userId;
  String? nameRestaurant;
  String? emailRestaurant;
  String? phoneRestaurant;
  String? addressRestaurant;
  List<String>? licenseRestaurant;
  List<String>? onwnerLicenseImages;
  String? avatarUrl;
  String? backgroundUrl;
  StatusPosts? status;

  RestaurantModel({
    this.idRestaurant,
    this.userId,
    this.nameRestaurant,
    this.emailRestaurant,
    this.phoneRestaurant,
    this.addressRestaurant,
    this.licenseRestaurant,
    this.onwnerLicenseImages,
    this.avatarUrl,
    this.backgroundUrl,
    this.status,
  });

  Map<String, dynamic> toJson() {
    return {
      'idRestaurant': idRestaurant,
      'userId': userId,
      'nameRestaurant': nameRestaurant,
      'emailRestaurant': emailRestaurant,
      'phoneRestaurant': phoneRestaurant,
      'addressRestaurant': addressRestaurant,
      'licenseRestaurant': licenseRestaurant ?? '',
      'onwnerLicenseImages': onwnerLicenseImages ?? '',
      'avatarUrl': avatarUrl ?? '',
      'backgroundUrl': backgroundUrl ?? '',
      'status': status?.name ?? '',
    };
  }

  static RestaurantModel fromJson(Map<String, dynamic> json) {
    return RestaurantModel(
      idRestaurant: json['idRestaurant'],
      userId: json['userId'],
      nameRestaurant: json['nameRestaurant'],
      emailRestaurant: json['emailRestaurant'],
      phoneRestaurant: json['phoneRestaurant'],
      addressRestaurant: json['addressRestaurant'],
      licenseRestaurant: json["licenseRestaurant"] == null
          ? []
          : List<String>.from(json["licenseRestaurant"].map((x) => x)),
      onwnerLicenseImages: json["onwnerLicenseImages"] == null
          ? []
          : List<String>.from(json["onwnerLicenseImages"].map((x) => x)),
      avatarUrl: json['avatarUrl'],
      backgroundUrl: json['backgroundUrl'],
      status: json['status'] != null
          ? StatusPosts.values.byName(json['status'])
          : null,
    );
  }
}
