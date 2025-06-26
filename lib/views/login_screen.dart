import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:livaplace_app/routes/app_routes.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginState();
}

class _LoginState extends State<LoginScreen> {
  late final _formKey;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    _emailController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Form(
                child: Padding(
                  padding: const EdgeInsets.all(40),
                  child: Column(
                    children: [
                      Image.asset('assets/icon/app_icon.png', height: 120),
                      const Text(
                        'เข้าสู่ระบบ',
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text('ผู้ใช้จำเป็นต้องเข้าสู่ระบบเพื่อใช้งาน'),
                      const SizedBox(height: 20),
                      TextFormField(
                        autofocus: false,
                        decoration: const InputDecoration(label: Text('อีเมล')),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        autofocus: false,
                        decoration: const InputDecoration(
                          label: Text('รหัสผ่าน'),
                        ),
                      ),
                      const SizedBox(height: 40),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                          ),
                          onPressed: () => Get.offAllNamed(AppRoutes.home),
                          child: const Text(
                            'เข้าสู่ระบบ',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      GestureDetector(
                        onTap: () => Get.toNamed(AppRoutes.register),
                        child: RichText(
                          text: TextSpan(
                            style: GoogleFonts.mitr(color: Colors.black),
                            children: [
                              TextSpan(text: 'ยังไม่มีบัญชี?'),
                              TextSpan(text: '\u00A0\u00A0'),
                              TextSpan(
                                text: 'สมัครสมาชิก',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
