import 'package:find_food/features/model/post_data_model.dart';

class NotifyModel {
  String? idNotify;
  String? title;
  String? description;
  String? createAt;
  String? imgPost;
  PostDataModel? posts;

  NotifyModel({
    this.idNotify,
    this.title,
    this.description,
    this.createAt,
    this.imgPost,
    this.posts,
  });

  Map<String, dynamic> toJson() => {
    "idNotify": idNotify,
    "title": title,
    "description": description,
    "createAt": createAt,
    "imgPost": imgPost,
    "posts": posts?.toJson(),
  };

  factory NotifyModel.fromJson(Map<String, dynamic> json) => NotifyModel(
    idNotify: json["idNotify"],
    title: json["title"],
    description: json["description"],
    createAt: json["createAt"],
    imgPost: json["imgPost"],
    posts: PostDataModel.fromJson(json["posts"]),
  );

}
