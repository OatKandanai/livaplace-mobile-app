import 'package:firebase_auth/firebase_auth.dart';
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
  late final FirebaseAuth _auth;
  late final CollectionReference<Map<String, dynamic>> _savedPropertyCollection;
  late final String _currentUserId;

  @override
  void onInit() {
    super.onInit();

    // initialize Firebase
    _firestore = FirebaseFirestore.instance;
    _auth = FirebaseAuth.instance;
    _savedPropertyCollection = FirebaseFirestore.instance.collection(
      'saved_propertys',
    ); // access saved_propertys collection
    _currentUserId = _auth.currentUser!.uid; // get uid

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
      // fetch property details
      final DocumentSnapshot propertyDocument = await _firestore
          .collection('propertys')
          .doc(propertyId)
          .get();

      if (propertyDocument.exists) {
        propertyDetails.value = propertyDocument.data() as Map<String, dynamic>;
        propertyDetails['id'] =
            propertyDocument.id; // add key-value of property ID

        // fetch owner details
        final String ownerId = propertyDetails['owner_id'];
        await fetchOwnerDetails(ownerId);

        // check if the property is saved by the currect user
        await _checkIfPropertyIsSaved();
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

  Future<void> _checkIfPropertyIsSaved() async {}

  Future<void> saveProperty() async {
    final String propertyId = propertyDetails['id'];

    // If the property is currently saved, unsave it (delete from Firestore)
    if (isSaved.value) {
      try {
        // get first matching document by user ID and property ID
        final QuerySnapshot querySnapshot = await _savedPropertyCollection
            .where('user_id', isEqualTo: _currentUserId)
            .where('property_id', isEqualTo: propertyId)
            .limit(1)
            .get();

        // delete document if found matching
        if (querySnapshot.docs.isNotEmpty) {
          await _savedPropertyCollection
              .doc(querySnapshot.docs.first.id)
              .delete();

          isSaved.value = false;

          Get.snackbar(
            'ลบออกจากรายการโปรดแล้ว',
            'ประกาศนี้ถูกลบออกจากรายการโปรดของคุณแล้ว',
            snackPosition: SnackPosition.BOTTOM,
            colorText: Colors.white,
            backgroundColor: Colors.black,
          );
        }
      } catch (e) {}
    }
  }
}
