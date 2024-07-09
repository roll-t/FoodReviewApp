import 'package:flutter/material.dart';

class SetRestaurantAppbar extends StatelessWidget implements PreferredSizeWidget {
  const SetRestaurantAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image.asset("assets/images/logo_restaurant.png"),
      ),
      title: const Text(
        'Set Restaurant',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black,
          fontSize: 26,
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {
            Navigator.pop(context); // Xử lý nút close
          },
          icon: const Icon(Icons.close),
        ),
      ],
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 7);
}
