import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:livaplace_app/controllers/home_controller.dart';

class CreatedPropertyListController extends GetxController {
  late final CollectionReference<Map<String, dynamic>> _propertysCollection;
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
      await _propertysCollection.doc(propertyId).delete();
      propertyList.removeWhere((property) => property['id'] == propertyId);
      Get.snackbar(
        'ลบสำเร็จ',
        'ประกาศถูกลบเรียบร้อยแล้ว',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.black,
      );

      // fetch new list in Home Screen after deleted
      if (Get.isRegistered<HomeController>()) {
        Get.find<HomeController>().fetchPropertys();
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
