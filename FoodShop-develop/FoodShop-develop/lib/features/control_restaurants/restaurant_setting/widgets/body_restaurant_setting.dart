// import 'package:flutter/material.dart';

// class buildBody_Restaurant_Setting extends StatelessWidget {
//   const buildBody_Restaurant_Setting({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         navigator_restaurant_setting(
//           iconData: Icons.people,
//           textTitle: "Restaurant information",
//           subTitle: "Change your restaurant information",
//           ontap: () {},
//         ),
//         navigator_restaurant_setting(
//           iconData: Icons.location_on,
//           textTitle: "Locations",
//           subTitle: "Add or change restaurant location",
//           ontap: () {},
//         ),
//         navigator_restaurant_setting(
//           iconData: Icons.facebook,
//           textTitle: "Add Social Network Account",
//           subTitle: "Facebook, Instagram, etc",
//           ontap: () {},
//         ),
//         navigator_restaurant_setting(
//           iconData: Icons.people,
//           textTitle: "Restaurant information",
//           subTitle: "Change your restaurant information",
//           ontap: () {},
//         ),
//         navigator_restaurant_setting(
//           iconData: Icons.people,
//           textTitle: "Restaurant information",
//           subTitle: "Change your restaurant information",
//           ontap: () {},
//         ),
//       ],
//     );
//   }
// }

// class navigator_restaurant_setting extends StatelessWidget {
//   final IconData iconData;
//   final String textTitle;
//   final String subTitle;
//   final VoidCallback ontap;

//   const navigator_restaurant_setting({
//     super.key,
//     required this.iconData,
//     required this.textTitle,
//     required this.subTitle,
//     required this.ontap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         GestureDetector(
//           onTap: ontap,
//           child: Row(
//             // crossAxisAlignment: CrossAxisAlignment.start,
//             // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               Flexible(flex: 1, child: Icon(iconData)),
//               const SizedBox(
//                 width: 10,
//               ),
//               Flexible(
//                   flex: 8,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [Text(textTitle), Text(subTitle)],
//                   )),
//               const Spacer(
//                 flex: 1,
//               ),
//               const Flexible(flex: 1, child: Icon(Icons.arrow_forward_ios)),
//             ],
//           ),
//         ),
//         const SizedBox(
//           height: 20,
//         )
//       ],
//     );
//   }
// }
import 'package:find_food/features/control_restaurants/restaurant_setting/widgets/navigator_restaurant_setting_custom.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BuildBodyRestaurantSetting extends StatelessWidget {
  const BuildBodyRestaurantSetting({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: [
          NavigatorRestaurantSetting(
            iconData: Icons.people,
            textTitle: "Restaurant information",
            subTitle: "Change your restaurant information",
            ontap: () {
              Get.toNamed('changeinfor');
            },
          ),
          NavigatorRestaurantSetting(
            iconData: Icons.location_on,
            textTitle: "Locations",
            subTitle: "Add or change restaurant location",
            ontap: () {},
          ),
          NavigatorRestaurantSetting(
            iconData: Icons.facebook,
            textTitle: "Add Social Network Account",
            subTitle: "Facebook, Instagram, etc",
            ontap: () {
              Get.toNamed('addlink');
            },
          ),
          NavigatorRestaurantSetting(
            iconData: Icons.lock_clock,
            textTitle: "Update times",
            subTitle: "Set time active uptime",
            ontap: () {
              print("OKE");
            },
          ),
          // NavigatorRestaurantSetting(
          //   iconData: Icons.people,
          //   textTitle: "Restaurant information",
          //   subTitle: "Change your restaurant information",
          //   ontap: () {

          //   },
          // ),
        ],
      ),
    );
  }
}
