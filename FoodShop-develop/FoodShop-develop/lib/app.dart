import 'package:find_food/app_binding.dart';
import 'package:find_food/core/configs/app_colors.dart';
import 'package:find_food/core/lang/translation_service.dart';
import 'package:find_food/core/routes/pages.dart';
import 'package:find_food/core/utils/behavior.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(  
      debugShowCheckedModeBanner: false,
      initialRoute: Pages.initial,
      scrollBehavior: MyBehavior(),
      getPages: Pages.routes,
      initialBinding: AppBinding(),
      locale: LocalizationService.locale,
      fallbackLocale: LocalizationService.fallbackLocale,
      translations: LocalizationService(),
      theme: ThemeData(
        appBarTheme: const AppBarTheme(backgroundColor: AppColors.white),
        scaffoldBackgroundColor:AppColors.white, 
      ),
    );
  }
}
