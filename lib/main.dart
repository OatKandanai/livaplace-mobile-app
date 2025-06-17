import 'package:flutter/material.dart';
import 'package:livaplace_app/features/auth/screens/login_screen.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LivaPlace',
      theme: ThemeData(textTheme: GoogleFonts.interTextTheme()),
      home: const Login(),
    );
  }
}
