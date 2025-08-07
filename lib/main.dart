import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:livaplace_app/routes/app_pages.dart';
import 'package:livaplace_app/routes/app_routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_storage/get_storage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // load environment variables
  await dotenv.load(fileName: "assets/.env");

  // disable landscape mode
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await Firebase.initializeApp(); // Initialize Firebase
  await GetStorage.init(); // Initialize Get Storage
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final GetStorage box = GetStorage();
    final bool isLoggedIn = box.read('isLoggedIn') ?? false;

    return GetMaterialApp(
      title: 'LivaPlace',
      theme: ThemeData(
        textTheme: GoogleFonts.mitrTextTheme(),
        scaffoldBackgroundColor: Colors.white,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: isLoggedIn ? AppRoutes.home : AppRoutes.login,
      getPages: AppPages.routes,
    );
  }
}
