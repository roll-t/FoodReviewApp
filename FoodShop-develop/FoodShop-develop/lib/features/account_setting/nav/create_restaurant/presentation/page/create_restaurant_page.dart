import 'package:find_food/core/ui/widgets/appbar/create_restaurant_appbar.dart';
import 'package:find_food/core/ui/widgets/button/button_widget.dart';
import 'package:find_food/core/ui/widgets/loading/loading_data_page.dart';
import 'package:find_food/features/account_setting/nav/create_restaurant/presentation/controller/create_restaurant_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateRestaurantPage extends GetView<CreateRestaurantController> {
  const CreateRestaurantPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CreateRestaurantAppbar(),
      body: Obx(() => controller.isLoading.value
          ? const LoadingDataPage()
          : buildCreateRestaurantBody()),
    );
  }

  SingleChildScrollView buildCreateRestaurantBody() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SizedBox(
          height: Get.height - Get.height * 0.16,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GetBuilder<CreateRestaurantController>(
                id: "updateInfo",
                builder: (_) {
                return textFormFieldList();
              }),
              ButtonWidget(
                ontap: () {
                  controller.controlCreateRestaurant();
                },
                text: "CONTINUE",
                fontWeight: FontWeight.bold,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Column textFormFieldList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTitleText(titleText: "RESTAURANT NAME"),
        _buildRestaurantNameField(),
        const SizedBox(height: 10.0),
        _buildTitleText(titleText: "EMAIL ADDRESS"),
        _buildEmailField(),
        const SizedBox(height: 10.0),
        _buildTitleText(titleText: "PHONE NUMBER"),
        _buildPhoneNumberField(),
        const SizedBox(height: 30.0),
      ],
    );
  }

  Text _buildTitleText({required String titleText}) {
    return Text(
      titleText,
      style: const TextStyle(
        fontSize: 15.0,
      ),
    );
  }

  Widget _buildRestaurantNameField() {
    return TextFormField(
      controller: controller.nameRestaurant,
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
          return "Please enter your restaurant name";
        }
        if (value.length < 3) {
          return "Restaurant name must be at least 3 characters long";
        }
        return null;
      },
      onSaved: (value) {},
    );
  }

  Widget _buildEmailField() {
    return TextFormField(
      controller: controller.emailRestaurant,
      decoration: const InputDecoration(
        hintText: "Enter Your Email Address",
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
      keyboardType: TextInputType.emailAddress,
      style: const TextStyle(
        color: Colors.black,
        fontSize: 15,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Your email is required";
        }
        if (!value.contains('@')) {
          return "Please enter a correct email!";
        }
        return null;
      },
      onSaved: (value) {},
    );
  }

  Widget _buildPhoneNumberField() {
    return TextFormField(
      controller: controller.phoneRestaurant,
      decoration: const InputDecoration(
        border: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black,
            width: 2.0,
          ),
        ),
        hintText: "Enter Your Phone Number",
        hintStyle: TextStyle(
          color: Colors.grey,
          fontSize: 10,
        ),
      ),
      keyboardType: TextInputType.phone,
      style: const TextStyle(
        color: Colors.black,
        fontSize: 15,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Please enter your phone number";
        }
        return null;
      },
      onSaved: (value) {},
    );
  }
}
