import 'package:find_food/features/auth/user/model/user_model.dart';

class CommentModel {
  UserModel author;
  String? idComment;
  String? comment;
  int? favorite;
  bool? isFavoriteComments;
  String? idPost;
  String? createdAt;
  List<String>? imageList;

  CommentModel({
    required this.author,
    this.idComment,
    this.comment,
    this.favorite,
    required this.isFavoriteComments,
    this.idPost,
    this.createdAt,
    this.imageList,
  });

  Map<String, dynamic> toJson() {
    return {
      'author': author.toJson(),
      'idComment': idComment,
      'comment': comment,
      'favorite': favorite,
      'isFavoriteComments': isFavoriteComments,
      'idPost': idPost,
      'createdAt': createdAt,
      "imageList":
          imageList == null ? [] : List<dynamic>.from(imageList!.map((x) => x)),
    };
  }

  static CommentModel fromJson(Map<String, dynamic> json) {
    return CommentModel(
      author: UserModel.fromJson(json['author']),
      idComment: json['idComment'],
      comment: json['comment'],
      favorite: json['favorite'],
      isFavoriteComments: json['isFavoriteComments'],
      idPost: json['idPost'],
      createdAt: json['createdAt'],
      imageList: json["imageList"] == null
          ? []
          : List<String>.from(json["imageList"]!.map((x) => x)),
    );
  }
}
