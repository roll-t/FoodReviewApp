import 'package:find_food/core/configs/app_dimens.dart';
import 'package:find_food/core/ui/widgets/appbar/setting_infomation_appbar.dart';
import 'package:find_food/core/ui/widgets/button/button_widget.dart';
import 'package:find_food/core/ui/widgets/text/text_widget.dart';
import 'package:find_food/features/account_setting/nav/setting_information/presentation/controller/setting_information_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingInformationPage extends GetView<SettingInformationController> {
  const SettingInformationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SettingInformationAppBar(),
      body: GetBuilder<SettingInformationController>(
        id: "setting_information_controller",
        builder: (_) {
          if (controller.user == null) {
            return const Center(child: CircularProgressIndicator());
          }
          return buildSettingInformationBody();
        },
      ),
    );
  }

  SingleChildScrollView buildSettingInformationBody() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SizedBox(
          height: Get.height - Get.height * 0.16,
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                textFormFieldList(),
                ButtonWidget(
                    ontap: () {
                      if (controller.formKey.currentState!.validate()) {
                        controller.formKey.currentState!.save();
                        controller.updateUser();
                      }
                    },
                    text: "Save Change"),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Column textFormFieldList() {
    return Column(
      children: <Widget>[
        _buildDisplayNameField(),
        const SizedBox(height: 10.0),
        // _buildEmailField(),
        // const SizedBox(height: 10.0),
        _buildPhoneNumberField(),
        const SizedBox(height: 10.0),
        _buildPasswordField(),
        const SizedBox(height: 30.0),
      ],
    );
  }

  Widget _buildDisplayNameField() {
    return GetBuilder<SettingInformationController>(
      id: "fetchUserInformation",
      builder: (_) {
        return TextFormField(
          initialValue: controller.user?.displayName ?? "",
          decoration: const InputDecoration(
            labelText: "Display Name",
            labelStyle: TextStyle(
              color: Colors.black,
              fontSize: 20,
            ),
            hintText: "Enter your display name",
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
            fontSize: 20,
          ),
          validator: (value) {
            if (value != null && value != "") {
              if (value.length < 5) {
                return "Display name must not be less than 5 characters";
              }
              if (value.length > 25) {
                return "Display name must not be more than 25 characters";
              }
            }
          },
          onSaved: (value) {
            if (value != "" &&  controller.user?.displayName !=value) {
              controller.isChangeValue=true;
              controller.user?.displayName = value;
            }
          },
        );
      },
    );
  }

  Widget _buildPhoneNumberField() {
    return GetBuilder<SettingInformationController>(
      id: "fetchUserInformation",
      builder: (_) {
        return TextFormField(
          initialValue: controller.user?.phoneNumber ?? "",
          decoration: const InputDecoration(
            labelText: "Phone Number",
            border: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black,
                width: 2.0,
              ),
            ),
            labelStyle: TextStyle(
              color: Colors.black,
              fontSize: 20,
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
            fontSize: 20,
          ),
          validator: (value) {},
          onSaved: (value) {
            if (value != "" && controller.user?.phoneNumber!=value) {
              controller.isChangeValue=true;
              controller.user?.phoneNumber = value;
            }
          },
        );
      },
    );
  }

  Widget _buildPasswordField() {
    return GetBuilder<SettingInformationController>(
      id: "fetchUserInformation",
      builder: (_) {
        return Container(
          padding: const EdgeInsets.only(top: AppDimens.spacing4),
          child: Row(
            children: [
              const TextWidget(text: "Password"),
              const SizedBox(
                width: AppDimens.spacing4,
              ),
              GestureDetector(
                onTap: () {
                  Get.offNamed("/changePassword");
                },
                child: const TextWidget(
                  text: "Change",
                  color: Colors.red,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
