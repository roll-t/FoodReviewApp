class UserModel {
  final String? id;
  final String name;
  final String email;
  final String password;
  //final Image? avatar;
  final String createAt;

  UserModel(
      {this.id,
      required this.name,
      required this.email,
      required this.password,
      //this.avatar,
      required this.createAt});

  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    String? password,
    //Image? avatar,
    String? createAt,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      //avatar: avatar ?? this.avatar,
      createAt: createAt ?? this.createAt,      
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      //'avatar': avatar,
      'createAt': createAt,
    };
  }

  static UserModel fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      password: json['password'],
      //avatar: json['avatar'],
      createAt: json['createAt'],
    );
  }
}
