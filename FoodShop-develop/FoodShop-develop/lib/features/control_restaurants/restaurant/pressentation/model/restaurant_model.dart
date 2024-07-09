class SetRestaurant {
  final String name;
  final String address;
  final String imagePath;

  SetRestaurant({
    required this.name,
    required this.address,
    required this.imagePath,
  });
  factory SetRestaurant.fromJson(Map<String, dynamic> json) =>
      SetRestaurant(name: 'name', address: 'address', imagePath: 'imagePath');
  Map<String, dynamic> toJson() {
    return {'name': name, 'address': address, 'imagePath': imagePath};
  }

  static List<SetRestaurant> allItems = [
    SetRestaurant(
        name: 'Restaurant 1',
        address: 'Address 1 - AA - BB - CC',
        imagePath: 'assets/images/food1.png'),
    SetRestaurant(
        name: 'Restaurant 2',
        address: 'Address 2 - AA - BB - CC',
        imagePath: 'assets/images/food2.png'),
    SetRestaurant(
        name: 'Restaurant 3',
        address: 'Address 3 - AA - BB - CC',
        imagePath: 'assets/images/food3.png'),
    SetRestaurant(
        name: 'Restaurant 4',
        address: 'Address 4 - AA - BB - CC',
        imagePath: 'assets/images/food4.png'),
    SetRestaurant(
        name: 'Restaurant 5',
        address: 'Address 5 - AA - BB - CC',
        imagePath: 'assets/images/food5.png'),
    SetRestaurant(
        name: 'Restaurant 6',
        address: 'Address 6 - AA - BB - CC',
        imagePath: 'assets/images/food6.png'),
  ];
}
