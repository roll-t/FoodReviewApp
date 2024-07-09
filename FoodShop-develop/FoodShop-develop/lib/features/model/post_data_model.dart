import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:find_food/core/configs/enum.dart';

class PostDataModel {
  String? id;
  String? userId;
  String? title;
  String? subtitle;
  List<String>? imageList;
  String? restaurantId;
  String? createAt;
  double? latitude;
  double? longitude;
  Map<String,dynamic>? placeMap;
  StatusPosts? status;


  

  PostDataModel({
    this.id,
    this.userId,
    this.title,
    this.subtitle,
    this.imageList,
    this.restaurantId,
    this.createAt,
    this.latitude,
    this.longitude,
    this.placeMap,
    this.status
  });

  // Define the copyWith method
  PostDataModel copyWith({
    String? id,
    String? userId,
    String? title,
    String? subtitle,
    List<String>? imageList,
    String? restaurantId,
    String? createAt,
    double? latitude,
    double? longitude,
    Map<String,dynamic>?placeMap,
    StatusPosts ? status
    
  }) {
    return PostDataModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      imageList: imageList ?? this.imageList,
      restaurantId: restaurantId ?? this.restaurantId,
      createAt: createAt ?? this.createAt,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      placeMap: placeMap,
      status: status ?? this.status
    );
  }

  factory PostDataModel.fromJson(Map<String, dynamic> json) => PostDataModel(
        id: json["id"],
        userId: json["userId"],
        title: json["title"],
        subtitle: json["subtitle"],
        imageList: json["imageList"] == null
            ? []
            : List<String>.from(json["imageList"].map((x) => x)),
        restaurantId: json["restaurantId"],
        createAt: json["createAt"],
        latitude: json["latitude"]?.toDouble(),
        longitude: json["longitude"]?.toDouble(),
        placeMap: (json["placeMap"] ?? {}),
        status: json["status"] != null ? StatusPosts.values.byName(json["status"]) : null,
      );
// Chuyển đổi từ DocumentSnapshot sang PostModel
  factory PostDataModel.fromDocumentSnapshot(DocumentSnapshot doc) {
    Map<String, dynamic> json = doc.data()! as Map<String, dynamic>;
    return PostDataModel(
      id: json["id"],
      userId: json["userId"],
      title: json["title"],
      subtitle: json["subtitle"],
      imageList: json["imageList"] == null
          ? []
          : List<String>.from(json["imageList"]!.map((x) => x)),
      restaurantId: json["restaurantId"],
      createAt: json["createAt"],
      latitude: json["latitude"]?.toDouble(),
      longitude: json["longitude"]?.toDouble(),
      placeMap: (json["placeMap"] ?? {}),
      status: json["status"] != null ? StatusPosts.values.byName(json["status"]) : null,
    );
  }
  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "title": title,
        "subtitle": subtitle,
        "imageList": imageList == null
            ? []
            : List<dynamic>.from(imageList!.map((x) => x)),
        "restaurantId": restaurantId,
        "createAt": createAt,
        "latitude": latitude,
        "longitude": longitude,
        "placeMap":placeMap,
        "status": status?.name,
      };
}
