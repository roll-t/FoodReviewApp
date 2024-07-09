import 'package:find_food/features/auth/user/model/user_model.dart';

class PostDetailModel {
  UserModel author;
  String? idPostDetail;
  String? title;
  String? createdAt;
  String? description;
  List<String> imageList;
  int? rating;
  int? numberOfRating;
  int? numberOfComment;
  int? numberOfFavorite;
  double? location;
  String? status;

  PostDetailModel({
    required this.author,
    this.idPostDetail,
    this.title,
    this.createdAt,
    this.description,
    required this.imageList,
    this.rating,
    this.numberOfRating,
    this.numberOfComment,
    this.numberOfFavorite,
    this.location,
    this.status,
  });

  Map<String, dynamic> toJson() {
    return {
      'author': author.toJson(),
      'idPost': idPostDetail,
      'title': title,
      'createdAt': createdAt,
      'description': description,
      "imageList": List<String>.from(imageList.map((x) => x)),
      'rating': rating,
      'numberOfRating': numberOfRating,
      'numberOfComment': numberOfComment,
      'numberOfFavorite': numberOfFavorite,
      'location': location,
      'status': status,
    };
  }

  static PostDetailModel fromJson(Map<String, dynamic> json) {
    return PostDetailModel(
      author: UserModel.fromJson(json['author']),
      idPostDetail: json['idPost'],
      title: json['title'],
      createdAt: json['createdAt'],
      description: json['description'],
      imageList: List<String>.from(json["imageList"].map((x) => x)),
      rating: json['rating'],
      numberOfRating: json['numberOfRating'],
      numberOfComment: json['numberOfComment'],
      numberOfFavorite: json['numberOfFavorite'],
      location: json['location'],
      status: json['status'],
    );
  }
}
