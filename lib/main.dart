import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:livaplace_app/routes/app_pages.dart';
import 'package:livaplace_app/routes/app_routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'LivaPlace',
      theme: ThemeData(textTheme: GoogleFonts.kanitTextTheme()),
      initialRoute: AppRoutes.login,
      getPages: AppPages.routes,
    );
  }
}
