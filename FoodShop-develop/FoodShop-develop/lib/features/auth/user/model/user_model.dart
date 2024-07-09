class UserModel {
  final String uid;
  String? password;
  String email;
  String? phoneNumber;
  String? displayName;
  String? avatarUrl;
  String? backgroundUrl;
  String? createdAt;
  bool? isComplete;
  UserModel({
    required this.uid,
    this.password,
    required this.email,
    this.phoneNumber,
    this.displayName,
    this.avatarUrl,
    this.backgroundUrl,
    this.createdAt,
    this.isComplete,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'],
      password: json['password'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      displayName: json['displayName'],
      avatarUrl: json['avatarUrl'],
      backgroundUrl: json['backgroundUrl'],
      createdAt: json['createdAt'],
      isComplete: json['isComplete'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'password': password,
      'email': email,
      'phoneNumber': phoneNumber,
      'isComplete': isComplete,
      'displayName': displayName,
      'avatarUrl': avatarUrl,
      'backgroundUrl': backgroundUrl,
      'createdAt': createdAt,
    };
  }
}
