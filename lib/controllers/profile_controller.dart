import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:livaplace_app/routes/app_routes.dart';
import 'package:url_launcher/url_launcher.dart';

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

  Future<void> launchFacebookPage() async {
    const String facebookUrl = 'https://www.facebook.com/ksppp17';
    final Uri uri = Uri.parse(facebookUrl);

    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(
          uri,
          mode: LaunchMode.externalApplication,
        ); // opening in external browser/app
        debugPrint('Launched Facebook page: $facebookUrl');
      } else {
        debugPrint('Could not launch Facebook page: $facebookUrl');
        Get.snackbar(
          'เกิดข้อผิดพลาด',
          'ไม่สามารถเปิดหน้า Facebook ได้',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      debugPrint('Error launching Facebook page: $e');
      Get.snackbar(
        'เกิดข้อผิดพลาด',
        'ไม่สามารถเปิดหน้า Facebook ได้: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
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
