import 'package:firebase_auth/firebase_auth.dart';
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
  late final GlobalKey<FormState> _formKey;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final FirebaseAuth _auth;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _auth = FirebaseAuth.instance;
  }

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) {
      Get.snackbar(
        'ข้อมูลไม่ครบถ้วน',
        'โปรดกรอกอีเมลและรหัสผ่านให้ถูกต้อง',
        snackPosition: SnackPosition.BOTTOM,
        colorText: Colors.white,
      );
      return;
    }

    try {
      // show loading
      Get.dialog(
        const Center(child: CircularProgressIndicator()),
        barrierDismissible: false,
      );

      final UserCredential userCredential = await _auth
          .signInWithEmailAndPassword(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim(),
          );

      if (userCredential.user != null) {
        Get.back();
        Get.offAllNamed(AppRoutes.home);
      } else {
        Get.back();
        Get.snackbar(
          'เกิดข้อผิดพลาด',
          'ไม่สามารถเข้าสู่ระบบได้ โปรดลองอีกครั้ง',
          snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.back();
      Get.snackbar(
        'เกิดข้อผิดพลาด',
        'ไม่สามารถเข้าสู่ระบบได้ โปรดลองอีกครั้ง',
        snackPosition: SnackPosition.BOTTOM,
        colorText: Colors.white,
      );
    }
  }

  @override
  void dispose() {
    _emailController.clear();
    _passwordController.clear();
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
                key: _formKey,
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
                        controller: _emailController,
                        autofocus: false,
                        decoration: const InputDecoration(label: Text('อีเมล')),
                        validator: (value) {
                          if (value != null || value!.isEmpty) {
                            return 'จำเป็นต้องกรอกข้อมูล';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _passwordController,
                        autofocus: false,
                        decoration: const InputDecoration(
                          label: Text('รหัสผ่าน'),
                        ),
                        validator: (value) {
                          if (value != null || value!.isEmpty) {
                            return 'จำเป็นต้องกรอกข้อมูล';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 40),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                          ),
                          onPressed: _login,
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
                            children: const [
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
