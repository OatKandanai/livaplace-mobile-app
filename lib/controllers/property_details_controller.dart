import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_storage/get_storage.dart';
import 'package:livaplace_app/controllers/saved_list_controller.dart';

class PropertyDetailsController extends GetxController {
  // UI related variables
  final RxMap<String, dynamic> propertyDetails = <String, dynamic>{}.obs;
  final RxMap<String, dynamic> ownerDetails = <String, dynamic>{}.obs;
  RxBool isSaved = false.obs;

  // Firebase
  late final FirebaseFirestore _firestore;
  late final CollectionReference<Map<String, dynamic>> _savedPropertyCollection;

  // GetStorage
  late GetStorage box;
  late final String _currentUserId;

  @override
  void onInit() {
    super.onInit();

    // initialize Firebase
    _firestore = FirebaseFirestore.instance;
    _savedPropertyCollection = _firestore.collection('saved_propertys');

    // initialize GetStorage
    box = GetStorage();
    _currentUserId = box.read('userUid');

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

        // check if the property is saved by the current user
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
      Get.snackbar(
        'เกิดข้อผิดพลาดในการดึงข้อมูลประกาศ',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        colorText: Colors.white,
        backgroundColor: Colors.black,
      );
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

  Future<void> _checkIfPropertyIsSaved() async {
    final String propertyId = propertyDetails['id'];

    try {
      final QuerySnapshot querySnapshot = await _savedPropertyCollection
          .where('user_id', isEqualTo: _currentUserId)
          .where('property_id', isEqualTo: propertyId)
          .limit(1)
          .get();

      isSaved.value = querySnapshot.docs.isNotEmpty;
    } catch (e) {
      debugPrint("เกิดข้อผิดพลาดในการเช็ครายการที่บันทึก: $e");
      isSaved.value = false;
    }
  }

  Future<void> saveProperty() async {
    final String propertyId = propertyDetails['id'];

    // if the property is currently saved, unsave it (delete from Firestore)
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
            'ลบออกจากรายการที่บันทึกแล้ว',
            'ประกาศนี้ถูกลบออกจากรายการของคุณแล้ว',
            snackPosition: SnackPosition.BOTTOM,
            colorText: Colors.white,
            backgroundColor: Colors.black,
          );
        }
      } catch (e) {
        Get.snackbar(
          'เกิดข้อผิดพลาดในการลบรายการที่บันทึก',
          e.toString(),
          snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.white,
          backgroundColor: Colors.black,
        );
      }
    } else {
      // if the property is not saved, save it (add to Firestore)
      try {
        await _savedPropertyCollection.add({
          'user_id': _currentUserId,
          'property_id': propertyId,
        });

        isSaved.value = true;

        Get.snackbar(
          'เพิ่มในรายการที่บันทึกแล้ว',
          'ประกาศนี้ถูกเพิ่มในรายการของคุณแล้ว',
          snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.white,
          backgroundColor: Colors.black,
        );
      } catch (e) {
        Get.snackbar(
          'เกิดข้อผิดพลาดในการบันทึกรายการ',
          e.toString(),
          snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.white,
          backgroundColor: Colors.black,
        );
      }
    }

    // after saving/unsaving, refresh the saved list in SavedListController
    if (Get.isRegistered<SavedListController>()) {
      Get.find<SavedListController>().fetchSavedList();
    }
  }
}
