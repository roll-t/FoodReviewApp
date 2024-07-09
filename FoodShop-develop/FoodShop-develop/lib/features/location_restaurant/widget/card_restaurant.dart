import 'package:find_food/features/location_restaurant/presentation/controller/location_restaurant_controller.dart';
import 'package:find_food/features/control_restaurants/restaurant/pressentation/model/restaurant_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CardRestaurant extends GetView<LocationRestaurantController> {
  final SetRestaurant setrestaurant;

  const CardRestaurant({
    super.key,
    required this.setrestaurant,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: SizedBox(
                  width: 150,
                  height: 100,
                  child:
                      Image.asset(setrestaurant.imagePath, fit: BoxFit.cover),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      setrestaurant.name,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      setrestaurant.address,
                      style: const TextStyle(
                          fontSize: 12, fontWeight: FontWeight.normal),
                      maxLines: 1,
                      // overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              GestureDetector(
                onTap: () {
                  // Xử lý sự kiện khi icon được nhấn
                  print("Icon được nhấn");
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: const EdgeInsets.all(5),
                  child: Transform.rotate(
                    angle: 70,
                    child: const Icon(
                      Icons.attach_file,
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10), // Thêm padding ở cuối
            ],
          ),
        ),
      ],
    );
  }
}
