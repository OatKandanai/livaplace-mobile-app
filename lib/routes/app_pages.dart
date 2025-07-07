import 'package:get/get_navigation/get_navigation.dart';
import 'package:livaplace_app/bindings/create_property_binding.dart';
import 'package:livaplace_app/bindings/home_binding.dart';
import 'package:livaplace_app/bindings/login_binding.dart';
import 'package:livaplace_app/bindings/property_details_binding.dart';
import 'package:livaplace_app/bindings/register_binding.dart';
import 'package:livaplace_app/bindings/saved_list_binding.dart';
import 'package:livaplace_app/bindings/search_filters_binding.dart';
import 'package:livaplace_app/routes/app_routes.dart';
import 'package:livaplace_app/views/bottom_nav.dart';
import 'package:livaplace_app/views/create_property_screen.dart';
import 'package:livaplace_app/views/edit_profile_screen.dart';
import 'package:livaplace_app/views/login_screen.dart';
import 'package:livaplace_app/views/profile_screen.dart';
import 'package:livaplace_app/views/property_details_screen.dart';
import 'package:livaplace_app/views/register_screen.dart';
import 'package:livaplace_app/views/saved_list_screen.dart';
import 'package:livaplace_app/views/search_filters_screen.dart';
import 'package:livaplace_app/views/search_result_screen.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: AppRoutes.login,
      page: () => LoginScreen(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: AppRoutes.register,
      page: () => RegisterScreen(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => BottomNav(),
      bindings: [HomeBinding(), SavedListBinding()],
    ),
    GetPage(
      name: AppRoutes.searchFilters,
      page: () => SearchFiltersScreen(),
      binding: SearchFiltersBinding(),
      transition: Transition.downToUp,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: AppRoutes.searchResult,
      page: () => const SearchResultScreen(),
    ),
    GetPage(
      name: AppRoutes.propertyDetails,
      page: () => PropertyDetailsScreen(),
      binding: PropertyDetailsBinding(),
    ),
    GetPage(name: AppRoutes.profile, page: () => const ProfileScreen()),
    GetPage(name: AppRoutes.editProfile, page: () => EditProfileScreen()),
    GetPage(
      name: AppRoutes.create,
      page: () => CreatePropertyScreen(),
      binding: CreatePropertyBinding(),
    ),
    GetPage(
      name: AppRoutes.saved,
      page: () => const SavedListScreen(),
      binding: SavedListBinding(),
    ),
  ];
}
