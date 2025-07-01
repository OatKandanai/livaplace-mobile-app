import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:livaplace_app/routes/app_routes.dart';

class LoginController extends GetxController {
  late final GlobalKey<FormState> formKey;
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late final FirebaseAuth _auth;

  @override
  void onInit() {
    super.onInit();
    formKey = GlobalKey<FormState>();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    _auth = FirebaseAuth.instance;
  }

  Future<void> login() async {
    if (!formKey.currentState!.validate()) {
      Get.snackbar(
        'ข้อมูลไม่ครบถ้วน',
        'โปรดกรอกอีเมลและรหัสผ่านให้ถูกต้อง',
        snackPosition: SnackPosition.TOP,
        colorText: Colors.white,
        backgroundColor: Colors.black,
      );
      return;
    }

    // show loading
    Get.dialog(
      const Center(child: CircularProgressIndicator()),
      barrierDismissible: false, // prevent dimiss by tapping
    );

    try {
      final UserCredential userCredential = await _auth
          .signInWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text.trim(),
          );

      // login is successful
      if (userCredential.user != null) {
        Get.back();
        Get.snackbar(
          'เข้าสู่ระบบสำเร็จ',
          'ยินดีต้อนรับ',
          snackPosition: SnackPosition.TOP,
          colorText: Colors.white,
          backgroundColor: Colors.black,
        );
        Get.offAllNamed(AppRoutes.home);
      }
    } catch (e) {
      Get.back();
      Get.snackbar(
        'เกิดข้อผิดพลาด',
        'ไม่สามารถเข้าสู่ระบบได้ โปรดลองอีกครั้ง',
        snackPosition: SnackPosition.TOP,
        colorText: Colors.white,
        backgroundColor: Colors.black,
      );
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
