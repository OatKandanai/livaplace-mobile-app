import 'package:get/get_navigation/get_navigation.dart';
import 'package:livaplace_app/routes/app_routes.dart';
import 'package:livaplace_app/views/bottom_nav.dart';
import 'package:livaplace_app/views/create_property_screen.dart';
import 'package:livaplace_app/views/edit_profile_screen.dart';
import 'package:livaplace_app/views/login_screen.dart';
import 'package:livaplace_app/views/profile_screen.dart';
import 'package:livaplace_app/views/property_details_screen.dart';
import 'package:livaplace_app/views/register_screen.dart';
import 'package:livaplace_app/views/search_filters_screen.dart';
import 'package:livaplace_app/views/search_result_screen.dart';

class AppPages {
  static final routes = [
    GetPage(name: AppRoutes.login, page: () => LoginScreen()),
    GetPage(name: AppRoutes.register, page: () => RegisterScreen()),
    GetPage(name: AppRoutes.home, page: () => BottomNav()),
    GetPage(
      name: AppRoutes.searchFilters,
      page: () => SearchFiltersScreen(),
      transition: Transition.downToUp,
      transitionDuration: const Duration(milliseconds: 700),
    ),
    GetPage(
      name: AppRoutes.searchResult,
      page: () => const SearchResultScreen(),
    ),
    GetPage(
      name: AppRoutes.propertyDetails,
      page: () => const PropertyDetailsScreen(),
    ),
    GetPage(name: AppRoutes.profile, page: () => const ProfileScreen()),
    GetPage(name: AppRoutes.editProfile, page: () => const EditProfileScreen()),
    GetPage(name: AppRoutes.create, page: () => CreatePropertyScreen()),
  ];
}
