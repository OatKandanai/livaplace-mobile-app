import 'package:get/get_navigation/get_navigation.dart';
import 'package:livaplace_app/routes/app_routes.dart';
import 'package:livaplace_app/views/bottom_nav.dart';
import 'package:livaplace_app/views/edit_profile_screen.dart';
import 'package:livaplace_app/views/login_screen.dart';
import 'package:livaplace_app/views/profile_screen.dart';
import 'package:livaplace_app/views/register_screen.dart';
import 'package:livaplace_app/views/search_filters_screen.dart';

class AppPages {
  static final routes = [
    GetPage(name: AppRoutes.login, page: () => const LoginScreen()),
    GetPage(name: AppRoutes.register, page: () => const RegisterScreen()),
    GetPage(name: AppRoutes.home, page: () => BottomNav()),
    GetPage(name: AppRoutes.profile, page: () => const ProfileScreen()),
    GetPage(name: AppRoutes.searchFilters, page: () => SearchFiltersScreen()),
    GetPage(name: AppRoutes.editProfile, page: () => const EditProfileScreen()),
  ];
}
