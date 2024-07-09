import 'package:find_food/core/ui/widgets/button/button_widget.dart';
import 'package:find_food/features/account_setting/nav/change_password/presentation/controller/change_password_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangePasswordPage extends GetView<ChangePasswordController> {
  const ChangePasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Change Password"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SizedBox(
            height: Get.height - Get.height * 0.16,
            child: Form(
              key: controller.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      _buildCurrentPasswordField(),
                      const SizedBox(height: 10.0),
                      _buildNewPasswordField(),
                      const SizedBox(height: 10.0),
                      _buildNewPasswordConfirmField(),
                      const SizedBox(height: 10.0),
                    ],
                  ),
                  ButtonWidget(
                    ontap: () {
                      if (controller.formKey.currentState!.validate()) {
                        controller.formKey.currentState!.save();
                        controller.saveNewPassword();
                      }
                    },
                    text: "Save Change",
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCurrentPasswordField() {
    return GetBuilder<ChangePasswordController>(
        id: "fetchUserInformation",
        builder: (_) {
          return TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            obscureText: !controller.showPassword.value,
            decoration: InputDecoration(
              labelText: "Current Password",
              labelStyle: const TextStyle(
                color: Colors.black,
                fontSize: 20,
              ),
              hintText: "Enter your current password",
              hintStyle: const TextStyle(
                color: Colors.grey,
                fontSize: 10,
              ),
              border: const UnderlineInputBorder(),
              suffixIcon: IconButton(
                onPressed: controller.toggleShowPassword,
                icon: Icon(
                  controller.showPassword.value
                      ? Icons.visibility
                      : Icons.visibility_off,
                ),
              ),
            ),
            style: const TextStyle(
              color: Colors.black,
              fontSize: 20,
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please enter your current password";
              }
              if (value != controller.user?.password) {
                return "Your password is incorrect";
              }
              return null;
            },
            onChanged: (value) {
              controller.currentPassword.text;
            },
          );
        });
  }

  Widget _buildNewPasswordField() {
    return GetBuilder<ChangePasswordController>(
        id: "fetchUserInformation",
        builder: (_) {
          return TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(
              labelText: "New Password",
              labelStyle: const TextStyle(
                color: Colors.black,
                fontSize: 20,
              ),
              hintText: "Enter your new password",
              hintStyle: const TextStyle(
                color: Colors.grey,
                fontSize: 10,
              ),
              border: const UnderlineInputBorder(),
              suffixIcon: IconButton(
                onPressed: controller.toggleShowPassword,
                icon: Icon(
                  controller.showPassword.value
                      ? Icons.visibility
                      : Icons.visibility_off,
                ),
              ),
            ),
            obscureText: !controller.showPassword.value,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 20,
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please enter a new password";
              }
              if (value.length < 6) {
                return "Password must be at least 6 characters long";
              }
              return null;
            },
            onChanged: (value) {
              controller.newPassword.text = value;
            },
          );
        });
  }

  Widget _buildNewPasswordConfirmField() {
    return GetBuilder<ChangePasswordController>(
        id: "fetchUserInformation",
        builder: (_) {
          return TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(
              labelText: "Confirm New Password",
              border: const UnderlineInputBorder(),
              labelStyle: const TextStyle(
                color: Colors.black,
                fontSize: 20,
              ),
              hintText: "Confirm your new password",
              hintStyle: const TextStyle(
                color: Colors.grey,
                fontSize: 10,
              ),
              suffixIcon: IconButton(
                onPressed: controller.toggleShowPassword,
                icon: Icon(
                  controller.showPassword.value
                      ? Icons.visibility
                      : Icons.visibility_off,
                ),
              ),
            ),
            obscureText: !controller.showPassword.value,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 20,
            ),
            onChanged: (value) {
              controller.confirmPassword.text;
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please confirm your new password";
              }
              if (value != controller.newPassword.text) {
                return "New passwords do not match";
              }
              return null;
            },
          );
        });
  }
}
