import 'package:find_food/features/auth/user/model/user_model.dart';
import 'package:find_food/features/model/post_data_model.dart';

class FavoriteModel {
  String? id;
  
  UserModel? author;
  PostDataModel posts;

  String? createdAt;

  FavoriteModel({
    this.id,
    required this.author,
    required this.posts,
    required this.createdAt, 
  });

  Map<String, dynamic> toJson() {
    return {
      'id':id,
      'author': author?.toJson(),
      'posts': posts.toJson(),
      'createdAt': createdAt,
    };
  }

  static FavoriteModel fromJson(Map<String, dynamic> json) {
    return FavoriteModel(
      id:json['id'] as String,
       author: UserModel.fromJson(json['author']),
      posts: PostDataModel.fromJson(json['posts']),
      createdAt: json['createdAt'],
    );
  }
}
