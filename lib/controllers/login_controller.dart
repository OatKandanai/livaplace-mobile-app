import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:livaplace_app/routes/app_routes.dart';

class LoginController extends GetxController {
  late final GlobalKey<FormState> formKey;
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late final FirebaseAuth _auth;
  late final GetStorage box;

  @override
  void onInit() {
    super.onInit();
    formKey = GlobalKey<FormState>();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    _auth = FirebaseAuth.instance;
    box = GetStorage();
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
        final String uid = userCredential.user!.uid;

        await box.write('isLoggedIn', true);
        await box.write('userUid', uid);

        Get.back(); // dismiss loading
        Get.snackbar(
          'เข้าสู่ระบบสำเร็จ',
          'ยินดีต้อนรับ',
          snackPosition: SnackPosition.TOP,
          colorText: Colors.white,
          backgroundColor: Colors.black,
        );
        Get.offAllNamed(AppRoutes.home);
      }
    } on FirebaseAuthException catch (e) {
      Get.back(); // dismiss loading

      String errorMessage;
      switch (e.code) {
        case 'user-not-found':
          errorMessage = 'ไม่พบบัญชีผู้ใช้นี้';
          break;
        case 'wrong-password':
          errorMessage = 'รหัสผ่านไม่ถูกต้อง';
          break;
        case 'invalid-email':
          errorMessage = 'อีเมลไม่ถูกต้อง';
          break;
        case 'user-disabled':
          errorMessage = 'บัญชีนี้ถูกปิดใช้งาน';
          break;
        default:
          errorMessage = 'เกิดข้อผิดพลาด: ${e.message}';
          break;
      }

      Get.snackbar(
        'ไม่สามารถเข้าสู่ระบบได้',
        errorMessage,
        snackPosition: SnackPosition.TOP,
        colorText: Colors.white,
        backgroundColor: Colors.red,
      );
    } catch (e) {
      Get.back(); // dismiss loading
      Get.snackbar(
        'เกิดข้อผิดพลาด',
        e.toString(),
        snackPosition: SnackPosition.TOP,
        colorText: Colors.white,
        backgroundColor: Colors.red,
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
