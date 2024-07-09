class MenuModel {
  String? idMenu;
  String? name;
  double? price;
  String? image;
  String? idRestaurant;
  String? userId;
  MenuModel(
      {this.idMenu,
      this.name,
      this.price,
      this.image,
      this.idRestaurant,
      this.userId});
  factory MenuModel.fromJson(Map<String, dynamic> json) => MenuModel(
        idMenu: json['idMenu'],
        name: json['name'],
        price: json['price'],
        image: json['image'],
        idRestaurant: json['idRestaurant'],
        userId: json['userId'],
      );

  Map<String, dynamic> toJson() {
    return {
      'idMenu': idMenu,
      'name': name,
      'price': price,
      'image': image,
      'idRestaurant': idRestaurant,
      'userId': userId,
    };
  }

  @override
  String toString() {
    return {
      'idMenu': idMenu,
      'name': name,
      'price': price,
      'image': image,
      'idRestaurant': idRestaurant,
      'userId': userId,
    }.toString();
  }
}
