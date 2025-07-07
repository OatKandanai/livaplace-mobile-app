import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class SearchFiltersController extends GetxController {
  final propertyType = Get.arguments as String;
  final List<String> types = ['ทุกประเภท', 'คอนโด', 'อพาร์ทเม้นท์', 'หอพัก'];
  final List<String> facilities = [
    'ฟิตเนส',
    'ครัว',
    'ที่จอดรถ',
    'WiFi',
    'เลี้ยงสัตว์ได้',
    'สระว่ายน้ำ',
    'เฟอร์นิเจอร์',
    'เครื่องปรับอากาศ',
    'เครื่องซักผ้า',
    'ระเบียง',
  ];
  late final TextEditingController textEditingController;
  final RxString selectedType = 'คอนโด'.obs;
  final RxSet<String> selectedFacilities = <String>{}.obs;
  final RxInt bedroomCount = 1.obs;
  final RxInt bathroomCount = 1.obs;

  @override
  void onInit() {
    super.onInit();
    textEditingController = TextEditingController();
  }

  void handleBedroomCount({required String type}) {
    if (type == 'increase') {
      bedroomCount.value++;
    } else if (type == 'decrease' && bedroomCount > 1) {
      bedroomCount.value--;
    }
  }

  void handleBathroomCount({required String type}) {
    if (type == 'increase') {
      bathroomCount.value++;
    } else if (type == 'decrease' && bathroomCount > 1) {
      bathroomCount.value--;
    }
  }

  void resetAllFilters() {
    textEditingController.clear();
    selectedType.value = 'คอนโด';
    selectedFacilities.clear();
    bedroomCount.value = 1;
    bathroomCount.value = 1;
  }

  Future<void> search() async {
    // show loading indicator
    Get.dialog(
      const Center(child: CircularProgressIndicator()),
      barrierDismissible: false,
    );

    try {
      CollectionReference propertiesRef = FirebaseFirestore.instance.collection(
        'propertys',
      );
      Query query = propertiesRef;

      if (textEditingController.text.isNotEmpty) {
        String searchText = textEditingController.text.toLowerCase();
      }

      if (selectedType.value != 'ทุกประเภท') {
        query = query.where('room_type', isEqualTo: selectedType.value);
      }

      if (selectedFacilities.isNotEmpty) {
        query = query.where(
          'facilities',
          arrayContainsAny: selectedFacilities.toList(),
        );
      }

      if (bedroomCount.value > 1) {
        query = query.where(
          'bedrooms',
          isGreaterThanOrEqualTo: bedroomCount.value,
        );
      }

      if (bathroomCount.value > 1) {
        query = query.where(
          'bathrooms',
          isGreaterThanOrEqualTo: bathroomCount.value,
        );
      }

      // execute the query
      QuerySnapshot querySnapshot = await query.get();

      List<Property> searchResults = querySnapshot.docs.map((doc) {
        return Property.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();

      if (textEditingController.text.isNotEmpty) {
        String searchText = textEditingController.text.toLowerCase();
        searchResults = searchResults.where((property) {
          return property.title.toLowerCase().contains(searchText);
        }).toList();
      }

      // close loading indicator
      Get.back();

      Get.toNamed(AppRoutes.searchResult, arguments: searchResults);
    } catch (e) {
      Get.back();
      Get.snackbar(
        'เกิดข้อผิดพลาด',
        'ไม่สามารถค้นหาได้: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }
}
