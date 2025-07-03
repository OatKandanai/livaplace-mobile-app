import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PropertyDetailsController extends GetxController {
  final RxMap<String, dynamic> propertyDetails = <String, dynamic>{}.obs;
  late final FirebaseFirestore _firestore;

  @override
  void onInit() {
    super.onInit();

    _firestore = FirebaseFirestore.instance;

    // retrieve the property ID passed as arguments
    final String? propertyId = Get.arguments as String?;

    if (propertyId != null) {
      fetchPropertyDetails(propertyId);
    } else {
      Get.snackbar(
        'เกิดข้อผิดพลาด',
        'ไม่พบไอดีของประกาศ',
        snackPosition: SnackPosition.TOP,
        colorText: Colors.white,
        backgroundColor: Colors.black,
      );
    }
  }

  Future<void> fetchPropertyDetails(String propertyId) async {
    try {
      final DocumentSnapshot document = await _firestore
          .collection('propertys')
          .doc(propertyId)
          .get();

      if (document.exists) {
        propertyDetails.value = document.data() as Map<String, dynamic>;
        propertyDetails['id'] = document.id;
      } else {
        Get.snackbar(
          'เกิดข้อผิดพลาด',
          'ไม่พบประกาศ',
          snackPosition: SnackPosition.TOP,
          colorText: Colors.white,
          backgroundColor: Colors.black,
        );
        propertyDetails.value = {}; // clear details if not found
      }
    } catch (e) {
      Get.snackbar('เกิดข้อผิดพลาดในการดึงข้อมูลประกาศ', e.toString());
      propertyDetails.value = {}; // clear details on error
    }
  }
}
