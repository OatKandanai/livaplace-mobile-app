import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SavedListController extends GetxController {
  // Firebase
  late FirebaseFirestore _firestore;
  late CollectionReference<Map<String, dynamic>> _savedPropertysCollection;
  late CollectionReference<Map<String, dynamic>> _propertysCollection;

  // GetStorage
  late GetStorage _box;
  late String? _currentUserId;

  // UI related variable
  final RxList<Map<String, dynamic>> savedPropertyList =
      <Map<String, dynamic>>[].obs;
  final RxBool isLoading = true.obs;
  final RxString errorMessage = ''.obs;
  final RxMap<String, bool> isRemovingFavorite = <String, bool>{}.obs;

  @override
  void onInit() {
    super.onInit();
    _firestore = FirebaseFirestore.instance;
    _savedPropertysCollection = _firestore.collection('saved_propertys');
    _propertysCollection = _firestore.collection('propertys');
    _box = GetStorage();
    _currentUserId = _box.read('userUid');

    if (_currentUserId != null) {
      fetchSavedList();
    } else {
      isLoading.value = false;
      errorMessage.value = 'โปรดเข้าสู่ระบบเพื่อดูรายการที่บันทึกไว้';
      Get.snackbar(
        'เกิดข้อผิดพลาด',
        'ไม่พบผู้ใช้, โปรดเข้าสู่ระบบ',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.black,
        colorText: Colors.white,
      );
    }
  }

  Future<void> fetchSavedList() async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      // fetch saved property IDs for the current user
      QuerySnapshot<Map<String, dynamic>> snapshot =
          await _savedPropertysCollection
              .where('user_id', isEqualTo: _currentUserId)
              .get();

      if (snapshot.docs.isEmpty) {
        savedPropertyList.clear();
        errorMessage.value = 'ไม่พบรายการที่บันทึกไว้';
        isLoading.value = false;
        return;
      }

      // extract property IDs from the snapshot
      List<String> propertyIds = snapshot.docs
          .map((doc) => doc['property_id'] as String)
          .toList();

      // fetch details for each property using Future.wait
      List<Future<DocumentSnapshot<Map<String, dynamic>>>> fetchFutures =
          propertyIds.map((id) {
            return _propertysCollection.doc(id).get();
          }).toList();

      // wait for all property document fetches to complete
      List<DocumentSnapshot<Map<String, dynamic>>> propertyDocuments =
          await Future.wait(fetchFutures);

      // process fetched property documents
      List<Map<String, dynamic>> propertiesData = [];
      for (var doc in propertyDocuments) {
        if (doc.exists && doc.data() != null) {
          propertiesData.add({
            ...doc.data()!,
            'id': doc.id,
          }); // Add document ID to data
        } else {
          debugPrint(
            'Property with ID ${doc.id} not found in "propertys" collection.',
          );
        }
      }

      savedPropertyList.value = propertiesData;
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      errorMessage.value = 'เกิดข้อผิดพลาดในการดึงข้อมูล ${e.toString()}';
      Get.snackbar(
        'เกิดข้อผิดพลาด',
        errorMessage.value,
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.black,
        colorText: Colors.white,
      );
      debugPrint('Error in fetchSavedList: $e');
    }
  }

  // Future<void> removePropertyFromSaved(String propertyId) async {
  //   try {
  //     // find the saved_property document to delete
  //     QuerySnapshot<Map<String, dynamic>> snapshot =
  //         await _savedPropertysCollection
  //             .where('user_id', isEqualTo: _currentUserId)
  //             .where('property_id', isEqualTo: propertyId)
  //             .limit(1)
  //             .get();

  //     if (snapshot.docs.isNotEmpty) {
  //       await _savedPropertysCollection.doc(snapshot.docs.first.id).delete();
  //       Get.snackbar(
  //         'ลบออกจากรายการที่บันทึกแล้ว',
  //         'ประกาศนี้ถูกลบออกจากรายการของคุณแล้ว',
  //         snackPosition: SnackPosition.BOTTOM,
  //         backgroundColor: Colors.black,
  //         colorText: Colors.white,
  //       );
  //     } else {
  //       Get.snackbar(
  //         'เกิดข้อผิดพลาด',
  //         'ไม่พบประกาศในรายการที่บันทึกไว้',
  //         snackPosition: SnackPosition.BOTTOM,
  //         backgroundColor: Colors.black,
  //         colorText: Colors.white,
  //       );
  //     }
  //   } catch (e) {
  //     Get.snackbar(
  //       'เกิดข้อผิดพลาดในการลบรายการ',
  //       e.toString(),
  //       snackPosition: SnackPosition.BOTTOM,
  //       backgroundColor: Colors.black,
  //       colorText: Colors.white,
  //     );
  //   }

  //   fetchSavedList();
  // }
}
