import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:livaplace_app/routes/app_routes.dart';

class ProfileController extends GetxController {
  late FirebaseAuth _auth;
  late GetStorage box;
  late final CollectionReference<Map<String, dynamic>> _usersCollection;
  late final String uid;
  final RxString firstName = ''.obs;
  final RxString lastName = ''.obs;
  final RxString email = ''.obs;
  final RxString profilePictureUrl = ''.obs;

  @override
  void onInit() {
    super.onInit();
    _auth = FirebaseAuth.instance;
    box = GetStorage();
    _usersCollection = FirebaseFirestore.instance.collection('users');
    uid = box.read('userUid');

    fetchUserData();
  }

  Future<void> fetchUserData() async {
    try {
      final DocumentSnapshot userDocument = await _usersCollection
          .doc(uid)
          .get();
      final userData = userDocument.data() as Map<String, dynamic>;
      firstName.value = userData['first_name'] ?? '';
      lastName.value = userData['last_name'] ?? '';
      email.value = userData['email'] ?? '';
      profilePictureUrl.value = userData['profile_picture'] ?? '';
    } catch (e) {
      Get.snackbar(
        'เกิดข้อผิดพลาด',
        'ไม่สามารถดึงข้อมูลผู้ใช้งาน : $e',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.black,
        colorText: Colors.white,
      );
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
    await box.remove('isLoggedIn');
    await box.remove('userUid');
    Get.offAllNamed(AppRoutes.login);
  }
}
