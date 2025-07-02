import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:livaplace_app/routes/app_pages.dart';
import 'package:livaplace_app/routes/app_routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await dotenv.load(fileName: ".env");
  String? apiKey = dotenv.env['API_KEY'];
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'LivaPlace',
      theme: ThemeData(
        textTheme: GoogleFonts.mitrTextTheme(),
        scaffoldBackgroundColor: Colors.white,
      ),
      initialRoute: AppRoutes.login,
      getPages: AppPages.routes,
    );
  }
}
