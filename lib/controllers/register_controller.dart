import 'package:cloud_firestore/cloud_firestore.dart'
    show CollectionReference, FirebaseFirestore, Timestamp;
import 'package:firebase_auth/firebase_auth.dart'
    show FirebaseAuth, UserCredential;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:livaplace_app/routes/app_routes.dart';

class RegisterController extends GetxController {
  late final GlobalKey<FormState> formKey;
  late final TextEditingController emailController;
  late final TextEditingController firstNameController;
  late final TextEditingController lastNameController;
  late final TextEditingController lineIdController;
  late final TextEditingController phoneController;
  late final TextEditingController passwordController;
  late final TextEditingController confirmPasswordController;
  late final FirebaseAuth _auth;
  late final CollectionReference<Map<String, dynamic>> _users;

  @override
  void onInit() {
    super.onInit();
    formKey = GlobalKey<FormState>();
    emailController = TextEditingController();
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    lineIdController = TextEditingController();
    phoneController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    _auth = FirebaseAuth.instance;
    _users = FirebaseFirestore.instance.collection('users');
  }

  Future<void> register() async {
    String email = emailController.text.trim();
    String firstName = firstNameController.text.trim();
    String lastName = lastNameController.text.trim();
    String lineId = lineIdController.text.trim();
    String phone = phoneController.text.trim();
    String password = passwordController.text.trim();

    if (!formKey.currentState!.validate()) {
      Get.snackbar(
        'ข้อมูลไม่ถูกต้อง',
        'โปรดกรอกข้อมูลให้ถูกต้องและครบถ้วน',
        snackPosition: SnackPosition.BOTTOM,
        colorText: Colors.white,
        backgroundColor: Colors.black,
      );
      return;
    }

    // show loading
    Get.dialog(
      const Center(child: CircularProgressIndicator()),
      barrierDismissible: false,
    );

    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      // register is successful
      if (userCredential.user != null) {
        await _users.doc(userCredential.user!.uid).set({
          'email': email,
          'first_name': firstName,
          'last_name': lastName,
          'line_id': lineId,
          'phone': phone,
          'created_at': Timestamp.now(),
        });

        Get.back();
        Get.snackbar(
          'สมัครสมาชิกสำเร็จ',
          'เข้าสู่ระบบเพื่อดำเนินการต่อ',
          snackPosition: SnackPosition.TOP,
          colorText: Colors.white,
          backgroundColor: Colors.black,
        );
        formKey.currentState!.reset();
        await Get.toNamed(AppRoutes.login);
      }
    } catch (e) {
      Get.back();
      Get.snackbar(
        'เกิดข้อผิดพลาด',
        'ไม่สามารถสมัครสมาชิกได้ โปรดลองอีกครั้ง',
        snackPosition: SnackPosition.BOTTOM,
        colorText: Colors.white,
        backgroundColor: Colors.black,
      );
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    lineIdController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
