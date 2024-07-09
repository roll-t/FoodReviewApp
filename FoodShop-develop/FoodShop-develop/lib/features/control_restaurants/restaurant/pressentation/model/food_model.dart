class MenuModel {
  String? idFood;
  String? idRestaurant;
  String? imageFood;
  String? foodName;
  String? priceFood;

  MenuModel(
      {this.idFood,
      this.idRestaurant,
      this.imageFood,
      this.foodName,
      this.priceFood});

  Map<String, dynamic> toJson() {
    return {
      'idFood': idFood,
      'idRestaurant': idRestaurant,
      'imageFood': imageFood,
      'foodName': foodName,
      'priceFood': priceFood,
    };
  }

  static MenuModel fromJson(Map<String, dynamic> json) {
    return MenuModel(
      idFood: json['idFood'],
      idRestaurant: json['idRestaurant'],
      imageFood: json['imageFood'],
      foodName: json['foodName'],
      priceFood: json['priceFood'],
    );
  }
}
