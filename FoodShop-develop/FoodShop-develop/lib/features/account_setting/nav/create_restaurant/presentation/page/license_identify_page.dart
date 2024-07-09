import 'package:find_food/core/ui/widgets/appbar/license_identify_appbar.dart';
import 'package:find_food/core/ui/widgets/button/button_widget.dart';
import 'package:find_food/features/account_setting/nav/create_restaurant/presentation/controller/create_restaurant_controller.dart';
import 'package:find_food/features/account_setting/nav/create_restaurant/presentation/widgets/upload_images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LicenseIdentifyPage extends GetView<CreateRestaurantController> {
  const LicenseIdentifyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const LicenseIdentifyAppbar(),
      body: buildLicenseIdentifyBody(),
    );
  }

  Widget buildLicenseIdentifyBody() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: GetBuilder<CreateRestaurantController>(
          id: "clearData",
          builder: (logic) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 5.0,
                    ),
                    titleField(title: "LICENSE RESTAURANT"),
                    UploadImage(
                      images: controller.licenseRestaurant,
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    titleField(title: "LICENSE OWNER"),
                    UploadImage(
                      images: controller.ownerLicenseImages,
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    titleField(title: "RESTAURANT ADDRESS"),
                    _buildRestaurantAddressField(),
                  ],
                ),
                const SizedBox(
                  height: 30.0,
                ),
                ButtonWidget(
                  ontap: () {
                    controller.controlLicenseIdentify();
                    // Get.to(() => ImagesIdentifyPage());
                  },
                  text: "CONTINUE",
                  fontWeight: FontWeight.bold,
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget titleField({required String title}) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 15.0,
        fontWeight: FontWeight.w300,
      ),
    );
  }

  Widget _buildRestaurantAddressField() {
    return TextFormField(
      controller: controller.addressRestaurant,
      decoration: const InputDecoration(
        hintText: "Enter your restaurant name",
        hintStyle: TextStyle(
          color: Colors.grey,
          fontSize: 10,
        ),
        border: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.red,
            width: 2.0,
          ),
        ),
      ),
      keyboardType: TextInputType.name,
      style: const TextStyle(
        color: Colors.black,
        fontSize: 15,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Please enter your restaurant address";
        }
        return null;
      },
      onSaved: (value) {},
    );
  }
}
