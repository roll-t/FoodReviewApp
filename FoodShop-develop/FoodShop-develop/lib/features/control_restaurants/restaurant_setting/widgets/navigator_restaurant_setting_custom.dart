import 'package:flutter/material.dart';

class NavigatorRestaurantSetting extends StatelessWidget {
  final IconData iconData;
  final String textTitle;
  final String subTitle;
  final VoidCallback ontap;

  const NavigatorRestaurantSetting({
    super.key,
    required this.iconData,
    required this.textTitle,
    required this.subTitle,
    required this.ontap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: ontap,
          child: Row(
            children: [
              Icon(iconData),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(textTitle),
                    Text(subTitle),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios),
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
