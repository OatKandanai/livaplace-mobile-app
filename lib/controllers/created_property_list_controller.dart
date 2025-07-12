import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:livaplace_app/controllers/home_controller.dart';
import 'package:livaplace_app/controllers/saved_list_controller.dart';

class CreatedPropertyListController extends GetxController {
  late final CollectionReference<Map<String, dynamic>> _propertysCollection;
  late final CollectionReference<Map<String, dynamic>> _savedPropertyCollection;
  late final GetStorage _box;
  late final String _currentUserId;
  final RxList<Map<String, dynamic>> propertyList =
      <Map<String, dynamic>>[].obs;
  final RxBool isLoading = true.obs;
  final RxString errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    _propertysCollection = FirebaseFirestore.instance.collection('propertys');
    _savedPropertyCollection = FirebaseFirestore.instance.collection(
      'saved_propertys',
    );
    _box = GetStorage();
    _currentUserId = _box.read('userUid');
    fetchCreatedProperty();
  }

  Future<void> fetchCreatedProperty() async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await _propertysCollection
              .where('owner_id', isEqualTo: _currentUserId)
              .get();

      if (querySnapshot.docs.isEmpty) {
        propertyList.clear();
        errorMessage.value = 'คุณไม่มีรายการประกาศที่สร้างไว้';
        isLoading.value = false;
        return;
      }

      propertyList.value = querySnapshot.docs.map((doc) {
        final Map<String, dynamic> data = doc.data();
        data['id'] = doc.id;
        return data;
      }).toList();
    } catch (e) {
      errorMessage.value = 'เกิดข้อผิดพลาดในการดึงข้อมูล: ${e.toString()}';
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteProperty(String propertyId) async {
    try {
      // delete the property from the 'propertys' collection
      await _propertysCollection.doc(propertyId).delete();
      // update the local property list
      propertyList.removeWhere((property) => property['id'] == propertyId);

      // delete corresponding entries in the 'saved_propertys' collection
      final QuerySnapshot savedPropertiesSnapshot =
          await _savedPropertyCollection
              .where('property_id', isEqualTo: propertyId)
              .get();
      for (DocumentSnapshot doc in savedPropertiesSnapshot.docs) {
        await doc.reference.delete();
      }

      Get.snackbar(
        'ลบสำเร็จ',
        'ประกาศถูกลบเรียบร้อยแล้ว',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.black,
      );

      // refresh Home Screen
      if (Get.isRegistered<HomeController>()) {
        Get.find<HomeController>().fetchPropertys();
      }

      // refresh Saved List Screen
      if (Get.isRegistered<SavedListController>()) {
        Get.find<SavedListController>().fetchSavedList();
      }
    } catch (e) {
      Get.snackbar(
        'เกิดข้อผิดพลาดในการลบ',
        'ไม่สามารถลบประกาศได้: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.black,
      );
      debugPrint('Error deleting property: $e');
    }
  }
}
