import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PropertyDetailsController extends GetxController {
  // UI related variables
  final RxMap<String, dynamic> propertyDetails = <String, dynamic>{}.obs;
  final RxMap<String, dynamic> ownerDetails = <String, dynamic>{}.obs;
  RxBool isSaved = false.obs;

  // Firebase
  late final FirebaseFirestore _firestore;
  late final CollectionReference<Map<String, dynamic>> _savedProperty;

  @override
  void onInit() {
    super.onInit();

    // initialize Firebase
    _firestore = FirebaseFirestore.instance;
    _savedProperty = FirebaseFirestore.instance.collection('saved_propertys');

    // retrieve the property ID passed as arguments
    final String? propertyId = Get.arguments as String?;
    if (propertyId != null) {
      _fetchPropertyDetails(propertyId);
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

  Future<void> _fetchPropertyDetails(String propertyId) async {
    try {
      final DocumentSnapshot propertyDocument = await _firestore
          .collection('propertys')
          .doc(propertyId)
          .get();

      if (propertyDocument.exists) {
        propertyDetails.value = propertyDocument.data() as Map<String, dynamic>;
        propertyDetails['id'] = propertyDocument.id;

        // after fetching property details, fetch owner details
        final String ownerId = propertyDetails['owner_id'];
        await fetchOwnerDetails(ownerId);
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

  Future<void> fetchOwnerDetails(String ownerId) async {
    try {
      final DocumentSnapshot ownerDocument = await _firestore
          .collection('users')
          .doc(ownerId)
          .get();

      if (ownerDocument.exists) {
        ownerDetails.value = ownerDocument.data() as Map<String, dynamic>;
      } else {
        ownerDetails.value = {}; // clear on not found
      }
    } catch (e) {
      ownerDetails.value = {}; // clear on error
    }
  }

  Future<void> saveProperty() async {
    final String ownerId = propertyDetails['owner_id'];
  }
}
