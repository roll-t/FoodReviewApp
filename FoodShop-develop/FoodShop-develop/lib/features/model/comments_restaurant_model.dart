import 'package:find_food/features/auth/user/model/user_model.dart';

class CommentsRestaurantModel {
  UserModel author;
  String? idCommentRestaurant;
  String? commentRestaurant;
  int? favoriteRestaurant;
  bool? isFavoriteComments;
  String? idPost;
  String? createdAt;

  CommentsRestaurantModel({
    required this.author,
    this.idCommentRestaurant,
    this.commentRestaurant,
    this.favoriteRestaurant,
    required this.isFavoriteComments,
    this.idPost,
    this.createdAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'author': author.toJson(),
      'idComment': idCommentRestaurant,
      'comment': commentRestaurant,
      'favorite': favoriteRestaurant,
      'isFavoriteComments': isFavoriteComments,
      'idPost': idPost,
      'createdAt': createdAt,
    };
  }

  static CommentsRestaurantModel fromJson(Map<String, dynamic> json) {
    return CommentsRestaurantModel(
      author: UserModel.fromJson(json['author']),
      idCommentRestaurant: json['idCommentRestaurant'],
      commentRestaurant: json['commentRestaurant'],
      favoriteRestaurant: json['favoriteRestaurant'],
      isFavoriteComments: json['isFavoriteComments'],
      idPost: json['idPost'],
      createdAt: json['createdAt'],
    );
  }
}
