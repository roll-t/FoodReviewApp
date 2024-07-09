import 'package:find_food/core/routes/routes.dart';
import 'package:find_food/features/account_setting/di/account_setting_binding.dart';
import 'package:find_food/features/account_setting/nav/change_password/di/change_password_binding.dart';
import 'package:find_food/features/account_setting/nav/change_password/presentation/page/change_password_page.dart';
import 'package:find_food/features/account_setting/nav/create_restaurant/di/create_restaurant_binding.dart';
import 'package:find_food/features/account_setting/nav/create_restaurant/presentation/page/create_restaurant_page.dart';
import 'package:find_food/features/account_setting/nav/setting_information/di/setting_information_binding.dart';
import 'package:find_food/features/account_setting/nav/setting_information/presentation/page/setting_information_page.dart';
import 'package:find_food/features/account_setting/presentation/page/account_setting_page.dart';
import 'package:find_food/features/auth/forget_password/di/forget_password_binding.dart';
import 'package:find_food/features/auth/forget_password/presentation/page/forget_password_page.dart';
import 'package:find_food/features/auth/login/di/login_binding.dart';
import 'package:find_food/features/auth/login/presentation/page/login_page.dart';
import 'package:find_food/features/auth/register/di/register_binding.dart';
import 'package:find_food/features/auth/register/presentation/page/register_page.dart';
import 'package:find_food/features/edit_posts/edit/di/edit_posts_binding.dart';
import 'package:find_food/features/edit_posts/edit/presentation/page/edit_post_page.dart';
import 'package:find_food/features/find_post/category/di/category_binding.dart';
import 'package:find_food/features/find_post/category/presentation/page/category_page.dart';
import 'package:find_food/features/control_restaurants/create_menu_restaurant/di/create_menu_binding.dart';
import 'package:find_food/features/control_restaurants/create_menu_restaurant/pressentation/page/create_menu_page.dart';
import 'package:find_food/features/find_post/result_search/di/resutl_search_binding.dart';
import 'package:find_food/features/find_post/result_search/presentation/page/result_search_page.dart';
import 'package:find_food/features/location_restaurant/di/location_restaurant_binding.dart';
import 'package:find_food/features/location_restaurant/presentation/page/location_restaurant_page.dart';
import 'package:find_food/features/main/di/main_binding.dart';
import 'package:find_food/features/main/presentation/page/main_page.dart';
import 'package:find_food/features/maps/location/di/location_binding.dart';
import 'package:find_food/features/maps/location/presentation/page/location_page.dart';
import 'package:find_food/features/maps/maps/di/maps_binding.dart';
import 'package:find_food/features/maps/maps/presentation/page/maps_page.dart';
import 'package:find_food/features/nav/notify/di/notify_binding.dart';
import 'package:find_food/features/nav/notify/presentation/page/notify_setting_page.dart';
import 'package:find_food/features/posts_detail/di/posts_detail_binding.dart';
import 'package:find_food/features/posts_detail/presentation/page/posts_detail_page.dart';
import 'package:find_food/features/control_restaurants/restaurant/di/restaurant_binding.dart';
import 'package:find_food/features/control_restaurants/restaurant/pressentation/page/restaurant_page.dart';
import 'package:find_food/features/control_restaurants/restaurant_change_infor/di/restaurant_change_info_binding.dart';
import 'package:find_food/features/control_restaurants/restaurant_change_infor/pressentation/page/restaurant_change_info.dart';
import 'package:find_food/features/control_restaurants/restaurant_setting/di/restaurant_setting_binding.dart';
import 'package:find_food/features/control_restaurants/restaurant_setting/pressentation/page/restaurant_setting_page.dart';
import 'package:find_food/features/control_restaurants/restaurant_social_network/di/restaurant_social_network_binding.dart';
import 'package:find_food/features/control_restaurants/restaurant_social_network/pressentation/page/restaurant_social_network.dart';
import 'package:find_food/features/profile_client/di/profile_client_binding.dart';
import 'package:find_food/features/profile_client/presentation/controller/profile_client_controller.dart';
import 'package:find_food/features/profile_client/presentation/page/profile_client_page.dart';
import 'package:find_food/features/splash/di/splash_binding.dart';
import 'package:find_food/features/splash/presentation/pages/splash_page.dart';
import 'package:get/get.dart';

class Pages {
  static const initial = Routes.none;
  static const main = Routes.main;

  static final routes = [
    // màng hình chờ loading
    GetPage(
      name: Routes.none,
      page: () => const SplashPage(),
      binding: SplashBinding(),
    ),

    // trang đăng nhập
    GetPage(
      name: Routes.login,
      page: () => LoginPage(),
      binding: LoginBindding(),
    ),

    // trang đăng ký
    GetPage(
      name: Routes.register,
      page: () => RegisterPage(),
      binding: RegisterBindding(),
    ),

    // màng hình chính
    GetPage(
      name: Routes.main,
      page: () => const MainPage(),
      binding: MainBindding(),
    ),

    //Trang quên mật khẩu

    GetPage(
      name: Routes.forgetpass,
      page: () => const ForgetPasswordPage(),
      binding: ForgetPasswordBinding(),
    ),

    //trang setting account
    GetPage(
      name: Routes.accountSetting,
      page: () => const AccountSettingPage(),
      binding: AccountSettingBinding(),
    ),

    
    //trang setting account
    GetPage(
      name: Routes.profileClient,
      page: () => const ProfileClientPage(),
      binding: ProfileClientBinding(),
    ),



    GetPage(
      name: Routes.editPosts,
      page: () => const EditPostPage(),
      binding: EditPostsBinding(),
    ),

    //trang setting information
    GetPage(
      name: Routes.settingInformation,
      page: () => const SettingInformationPage(),
      binding: SettingInformationBinding(),
    ),

    //trang change password
    GetPage(
      name: Routes.changePassword,
      page: () => const ChangePasswordPage(),
      binding: ChangePasswordBinding(),
    ),

    //trang tạo cửa hàng
    GetPage(
      name: Routes.createRestaurant,
      page: () => const CreateRestaurantPage(),
      binding: CreateRestaurantBinding(),
    ),

    //trang Notify Settings
    GetPage(
      name: Routes.notifySetting,
      page: () => const NotifySettingPage(),
      binding: NotifyBinding(),
    ),

    // =====================  ROUTE POST =====================

    //màng hình đăng bài viết
    // GetPage(
    //   name: Routes.uploadPostPage,
    //   page: () => const UploadPage(),
    //   binding: UploadBinding(),
    // ),

    // màng hình lấy vị trí cửa hàng trong bài viết
    GetPage(
      name: Routes.getLoactionPage,
      page: () => const LocationPage(),
      binding: LocationBinding(),
    ),

    // màng hình hiển thị Maps
    GetPage(
      name: Routes.maps,
      page: () => const MapsPage(),
      binding: MapsBinding(),
    ),

    // màng hình tìm kiếm
    GetPage(
      name: Routes.resultSearch,
      page: () => const ResultSearchPage(),
      binding: ResultSearchBinding(),
    ),
    GetPage(
      name: Routes.categorySearch,
      page: () => const CategoryPage(),
      binding: CategoryBinding(),
    ),
    GetPage(
      name: Routes.resultSearch,
      page: () => const ResultSearchPage(),
      binding: ResultSearchBinding(),
    ),

    // màng hình tìm kiếm
    GetPage(
      name: Routes.postsDetail,
      page: () => const PostsDetailPage(),
      binding: PostsDetailBinding(),
    ),

    //restaurant page
    GetPage(
      name: Routes.restaurant,
      page: () => RestaurantPage(),
      binding: RestaurantBinding(),
    ),

    GetPage(
        name: Routes.restaurantsetting,
        page: () => const RestaurantSettingPage(),
        binding: RestaurantSettingBinding()),
    GetPage(
        name: Routes.changeinfor,
        page: () => RestaurantChangeInfo(),
        binding: RestaurantChangeInfoBinding()),
    GetPage(
        name: Routes.setrestaurant,
        page: () => LocationRestaurantPage(),
        binding: LocationRestaurantBinding()),
    GetPage(
        name: Routes.addlink,
        page: () => RestaurantSocialNetwork(),
        binding: RestaurantSocialNetworkBinding()),
    GetPage(
        name: Routes.createmenu,
        page: () => CreateMenuPage(),
        binding: CreateMenuBinding())
  ];
}
