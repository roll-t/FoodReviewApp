import 'package:find_food/core/configs/app_colors.dart';
import 'package:find_food/core/configs/app_dimens.dart';
import 'package:find_food/core/ui/widgets/text/text_widget.dart';
import 'package:find_food/core/ui/widgets/textfield/textfield_widget.dart';
import 'package:find_food/features/auth/login/presentation/controller/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends GetView<LoginController> {
  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        leading: IconButton(
          color: AppColors.white,
          icon: const Icon(Icons.arrow_back),
          onPressed: () {},
        ),
        title: const Text(
          "Sign In",
          style: TextStyle(color: AppColors.white),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Welcome to Tamangg Food Servicess",
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  color: AppColors.primary,
                  fontSize: 30,
                  fontFamily: GoogleFonts.roboto().fontFamily,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                "Enter your Phone number or Email address for sign in. Enjoy your food :)",
                style: TextStyle(
                  color: AppColors.black,
                  fontSize: 20,
                  fontFamily: GoogleFonts.robotoCondensed().fontFamily,
                ),
              ),
              const SizedBox(height: 20),
              Form(
                key: controller.formKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      controller: controller.emailController,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: AppColors.grey,
                          ),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.green,
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        // if (!controller.validateEmail()) {
                        //   return "Email invalid";
                        // }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    Obx(() {
                      return TextFormField(
                        controller: controller.passwordController,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                              onPressed: controller.toggleIsEyePassword,
                              icon: Icon(
                                controller.isEyePassword.value
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              )),
                          labelText: 'Password',
                          enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey,
                            ),
                          ),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.green,
                            ),
                          ),
                        ),
                        obscureText: controller.visiblePassword.value,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          return null;
                        },
                      );
                    }),
                    const SizedBox(height: 15),
                    SizedBox(
                      width: double.infinity,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.black,
                          backgroundColor: AppColors.primary,
                          padding: const EdgeInsets.all(16.0),
                          textStyle: const TextStyle(fontSize: 20),
                          side: const BorderSide(
                            color: Colors.white,
                            width: 2,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () {
                          if (controller.formKey.currentState!.validate()) {
                            controller.handleLoginWithEmail();
                          }
                        },
                        child: const Text(
                          'Sign In',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              GestureDetector(
                onTap: () {
                  Get.toNamed('/forgetpass');
                },
                child: const Text(
                  'Forget Password ?',
                  style: TextStyle(
                    color: AppColors.primary,
                    decoration: TextDecoration.none,
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Don’t have account?'),
                  const SizedBox(width: 4),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed('/register');
                    },
                    child: const Text(
                      'Create New Account here',
                      style: TextStyle(
                        color: AppColors.primary,
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const Row(
                children: [
                  Expanded(
                    child: Divider(
                      indent: 50,
                      endIndent: 50,
                      color: Colors.grey,
                      thickness: 0.5,
                    ),
                  ),
                ],
              ),
              const Text(
                "Or",
                style: TextStyle(color: Colors.black),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: const Color(0xFF395998),
                    padding: const EdgeInsets.all(16.0),
                    textStyle: const TextStyle(fontSize: 20),
                    side: const BorderSide(
                      color: Colors.white,
                      width: 2,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {},
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.white,
                        ),
                        child: SvgPicture.asset(
                          'assets/icons/ic_facebook_logo.svg',
                          width: 15,
                          height: 15,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Expanded(
                        child: Text(
                          'Login with Facebook',
                          style: TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: const Color(0xFF4285F4),
                    padding: const EdgeInsets.all(16.0),
                    textStyle: const TextStyle(fontSize: 20),
                    side: const BorderSide(
                      color: Colors.white,
                      width: 2,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {},
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.white,
                        ),
                        child: SvgPicture.asset(
                          'assets/icons/ic_google_logo.svg',
                          width: 15,
                          height: 15,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Expanded(
                        child: Text(
                          'Login with Google',
                          style: TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
