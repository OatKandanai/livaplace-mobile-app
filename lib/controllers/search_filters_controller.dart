import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:livaplace_app/models/property_model.dart';
import 'package:livaplace_app/routes/app_routes.dart';

class SearchFiltersController extends GetxController {
  late final String propertyType;
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
  late final TextEditingController searchController;
  late final TextEditingController minPriceController;
  late final TextEditingController maxPriceController;

  // UI related variables
  final RxString selectedType = 'คอนโด'.obs;
  final RxSet<String> selectedFacilities = <String>{}.obs;
  final RxInt bedroomCount = 1.obs;
  final RxInt bathroomCount = 1.obs;

  @override
  void onInit() {
    super.onInit();
    propertyType = Get.arguments is String ? Get.arguments : '';
    searchController = TextEditingController();
    minPriceController = TextEditingController();
    maxPriceController = TextEditingController();
  }

  void handleBedroomCount({required String type}) {
    if (type == 'increase') {
      bedroomCount.value++;
    } else if (type == 'decrease' && bedroomCount.value > 1) {
      bedroomCount.value--;
    }
  }

  void handleBathroomCount({required String type}) {
    if (type == 'increase') {
      bathroomCount.value++;
    } else if (type == 'decrease' && bathroomCount.value > 1) {
      bathroomCount.value--;
    }
  }

  void resetAllFilters() {
    searchController.clear();
    minPriceController.clear();
    maxPriceController.clear();
    selectedType.value = 'คอนโด';
    selectedFacilities.clear();
    bedroomCount.value = 1;
    bathroomCount.value = 1;
  }

  Future<void> search() async {
    // show loading
    Get.dialog(
      const Center(child: CircularProgressIndicator()),
      barrierDismissible: false,
    );

    try {
      CollectionReference propertiesRef = FirebaseFirestore.instance.collection(
        'propertys',
      );
      Query query = propertiesRef;

      if (propertyType.isNotEmpty) {
        query = query.where('property_type', isEqualTo: propertyType);
      }

      if (selectedType.value != 'ทุกประเภท') {
        query = query.where('room_type', isEqualTo: selectedType.value);
      }

      if (bedroomCount.value > 1) {
        query = query.where(
          'bedrooms',
          isGreaterThanOrEqualTo: num.parse(bedroomCount.value.toString()),
        );
      }

      if (bathroomCount.value > 1) {
        query = query.where(
          'bathrooms',
          isGreaterThanOrEqualTo: num.parse(bathroomCount.value.toString()),
        );
      }

      num? minPrice = num.tryParse(minPriceController.text.trim());
      num? maxPrice = num.tryParse(maxPriceController.text.trim());
      if (minPrice != null) {
        query = query.where('price', isGreaterThanOrEqualTo: minPrice);
      }
      if (maxPrice != null) {
        query = query.where('price', isLessThanOrEqualTo: maxPrice);
      }

      // execute the query
      final QuerySnapshot querySnapshot = await query.get();

      List<PropertyModel> searchResults = querySnapshot.docs.map((doc) {
        final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        data['id'] = doc.id; // Add the document ID to the map
        return PropertyModel.fromMap(data);
      }).toList();

      // filter by search text
      if (searchController.text.isNotEmpty) {
        String searchText = searchController.text.toLowerCase();
        searchResults = searchResults.where((property) {
          return property.title.toLowerCase().contains(searchText);
        }).toList();
      }

      // filter by at least one facility
      if (selectedFacilities.isNotEmpty) {
        final facilityMap = {
          'ฟิตเนส': 'fitness',
          'ครัว': 'kitchen',
          'ที่จอดรถ': 'parking',
          'WiFi': 'wifi',
          'เลี้ยงสัตว์ได้': 'pet_friendly',
          'สระว่ายน้ำ': 'pool',
          'เฟอร์นิเจอร์': 'furniture',
          'เครื่องปรับอากาศ': 'air_conditioner',
          'เครื่องซักผ้า': 'washing_machine',
          'ระเบียง': 'balcony',
        };

        searchResults = searchResults.where((property) {
          // convert selected Thai names to keys
          final selectedKeys = selectedFacilities
              .map((thaiName) => facilityMap[thaiName])
              .toSet();

          final propertyFacilities = property.facilities.toSet();

          final hasAtLeastOne = selectedKeys.any(propertyFacilities.contains);
          final hasAnyFalse = selectedKeys.any(
            (key) => !propertyFacilities.contains(key),
          );

          return hasAtLeastOne && !hasAnyFalse;
        }).toList();
      }

      // close loading indicator
      Get.back();

      await Get.toNamed(AppRoutes.searchResult, arguments: searchResults);
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
    searchController.dispose();
    minPriceController.dispose();
    maxPriceController.dispose();
    super.dispose();
  }
}
