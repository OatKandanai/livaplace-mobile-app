import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:livaplace_app/bindings/create_property_binding.dart';
import 'package:livaplace_app/bindings/created_property_list_binding.dart';
import 'package:livaplace_app/bindings/edit_profile_binding.dart';
import 'package:livaplace_app/bindings/home_binding.dart';
import 'package:livaplace_app/bindings/login_binding.dart';
import 'package:livaplace_app/bindings/profile_binding.dart';
import 'package:livaplace_app/bindings/property_details_binding.dart';
import 'package:livaplace_app/bindings/register_binding.dart';
import 'package:livaplace_app/bindings/saved_list_binding.dart';
import 'package:livaplace_app/bindings/search_filters_binding.dart';
import 'package:livaplace_app/bindings/search_result_binding.dart';
import 'package:livaplace_app/routes/app_routes.dart';
import 'package:livaplace_app/views/bottom_nav.dart';
import 'package:livaplace_app/views/create_property_screen.dart';
import 'package:livaplace_app/views/created_property_list_screen.dart';
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
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: AppRoutes.register,
      page: () => RegisterScreen(),
      binding: RegisterBinding(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 400),
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => BottomNav(),
      bindings: [HomeBinding(), SavedListBinding(), ProfileBinding()],
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
      binding: SearchResultBinding(),
      transition: Transition.rightToLeftWithFade,
      transitionDuration: const Duration(milliseconds: 400),
    ),
    GetPage(
      name: AppRoutes.propertyDetails,
      page: () => PropertyDetailsScreen(),
      binding: PropertyDetailsBinding(),
      transition: Transition.downToUp,
      transitionDuration: const Duration(milliseconds: 400),
    ),
    GetPage(
      name: AppRoutes.profile,
      page: () => ProfileScreen(),
      binding: ProfileBinding(),
      transition: Transition.leftToRight,
      transitionDuration: const Duration(milliseconds: 400),
    ),
    GetPage(
      name: AppRoutes.editProfile,
      page: () => EditProfileScreen(),
      binding: EditProfileBinding(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 400),
    ),
    GetPage(
      name: AppRoutes.created,
      page: () => CreatedPropertyListScreen(),
      binding: CreatedPropertyListBinding(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 400),
    ),
    GetPage(
      name: AppRoutes.create,
      page: () => CreatePropertyScreen(),
      binding: CreatePropertyBinding(),
      transition: Transition.upToDown,
      transitionDuration: const Duration(milliseconds: 400),
    ),
    GetPage(
      name: AppRoutes.saved,
      page: () => const SavedListScreen(),
      binding: SavedListBinding(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 400),
    ),
  ];
}
