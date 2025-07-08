import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:livaplace_app/routes/app_routes.dart';

class EditProfileController extends GetxController {
  late final CollectionReference<Map<String, dynamic>> _usersCollection;
  late final GetStorage box;
  late final String uid;
  late final GlobalKey<FormState> formkey;
  late final TextEditingController firstNameController;
  late final TextEditingController lastNameController;
  late final TextEditingController phoneController;
  late final TextEditingController lineIdController;
  final RxString profileImageUrl = ''.obs;
  final RxBool isLoadingImage = false.obs;
  final String _cloudinaryCloudName = 'dme1aety8';
  final String _cloudinaryUploadPreset = 'flutter_property_upload';

  @override
  void onInit() {
    super.onInit();
    _usersCollection = FirebaseFirestore.instance.collection('users');
    box = GetStorage();
    uid = box.read('userUid');
    formkey = GlobalKey<FormState>();
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    phoneController = TextEditingController();
    lineIdController = TextEditingController();

    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    try {
      final DocumentSnapshot userDocument = await _usersCollection
          .doc(uid)
          .get();
      final userData = userDocument.data() as Map<String, dynamic>;
      firstNameController.text = userData['first_name'];
      lastNameController.text = userData['last_name'];
      phoneController.text = userData['phone'];
      lineIdController.text = userData['line_id'];
      profileImageUrl.value = userData['profile_picture'];
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

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    try {
      // pick an image from the gallery
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);

      if (image != null) {
        await uploadImageToCloudinary(image); // upload the picked image
      } else {
        // user cancelled the image selection
        Get.snackbar(
          'ยกเลิก',
          'ไม่ได้เลือกรูปภาพ',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.black,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        'เกิดข้อผิดพลาด',
        'ไม่สามารถเลือกรูปภาพได้: $e',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.black,
        colorText: Colors.white,
      );
    }
  }

  Future<void> uploadImageToCloudinary(XFile image) async {
    isLoadingImage.value = true;
    Get.dialog(
      const Center(child: CircularProgressIndicator()),
      barrierDismissible: false,
    );

    try {
      final cloudinary = CloudinaryPublic(
        _cloudinaryCloudName,
        _cloudinaryUploadPreset,
        cache: false,
      );
      final CloudinaryResponse response = await cloudinary.uploadFile(
        CloudinaryFile.fromFile(
          image.path,
          resourceType: CloudinaryResourceType.Image,
        ),
      );

      profileImageUrl.value =
          response.secureUrl; // update the reactive image URL
      Get.back(); // close loading dialog
      Get.snackbar(
        'สำเร็จ',
        'อัปโหลดรูปภาพโปรไฟล์เรียบร้อยแล้ว',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.black,
        colorText: Colors.white,
      );
    } on CloudinaryException catch (e) {
      Get.back(); // close loading dialog
      Get.snackbar(
        'เกิดข้อผิดพลาด Cloudinary',
        'ไม่สามารถอัปโหลดรูปภาพได้: ${e.message}',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.black,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.back(); // close loading dialog
      Get.snackbar(
        'เกิดข้อผิดพลาด',
        'ไม่สามารถอัปโหลดรูปภาพได้: $e',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.black,
        colorText: Colors.white,
      );
    } finally {
      isLoadingImage.value = false;
    }
  }

  Future<void> editProfile() async {
    if (!formkey.currentState!.validate()) {
      Get.snackbar(
        'เกิดข้อผิดพลาด',
        'โปรดใส่ข้อมูลให้ถูกต้อง',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.black,
        colorText: Colors.white,
      );
      return;
    }

    final Map<String, dynamic> updatedData = {
      'first_name': firstNameController.text.trim(),
      'last_name': lastNameController.text.trim(),
      'phone': phoneController.text.trim(),
      'line_id': lineIdController.text.trim(),
      'profile_picture': profileImageUrl.value,
    };

    Get.dialog(
      const Center(child: CircularProgressIndicator()),
      barrierDismissible: false,
    ); // show loading

    try {
      await _usersCollection.doc(uid).update(updatedData);
      Get.back(); // close loading
      Get.snackbar(
        'สำเร็จ',
        'อัปเดตข้อมูลโปรไฟล์เรียบร้อยแล้ว',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.black,
        colorText: Colors.white,
      );
      await Get.offAllNamed(AppRoutes.home);
    } catch (e) {
      Get.back(); // close loading
      Get.snackbar(
        'เกิดข้อผิดพลาด',
        'ไม่สามารถอัปเดตข้อมูลได้: $e',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.black,
        colorText: Colors.white,
      );
    }
  }

  @override
  void onClose() {
    firstNameController.dispose();
    lastNameController.dispose();
    phoneController.dispose();
    lineIdController.dispose();
    super.onClose();
  }
}
