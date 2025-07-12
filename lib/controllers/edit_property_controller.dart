import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:livaplace_app/controllers/created_property_list_controller.dart';
import 'package:livaplace_app/controllers/home_controller.dart';
import 'package:livaplace_app/controllers/property_details_controller.dart';

class EditPropertyController extends GetxController {
  // List variables to display choices in UI
  final List<String> propertyType = ['เช่า', 'ขาย'];
  final List<String> roomType = ['คอนโด', 'อพาร์ทเม้นท์', 'หอพัก'];
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

  // for convert English facility names to thai for UI
  final Map<String, String> _engToThaiFacilityMap = {
    'fitness': 'ฟิตเนส',
    'kitchen': 'ครัว',
    'parking': 'ที่จอดรถ',
    'wifi': 'WiFi',
    'pet_friendly': 'เลี้ยงสัตว์ได้',
    'pool': 'สระว่ายน้ำ',
    'furniture': 'เฟอร์นิเจอร์',
    'air_conditioner': 'เครื่องปรับอากาศ',
    'washing_machine': 'เครื่องซักผ้า',
    'balcony': 'ระเบียง',
  };

  // for convert Thai facility names to English keys for Firestore
  final Map<String, String> _thaiToEngFacilityMap = {
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

  // variables for selected UI choices
  final RxString selectedPropertyType = 'เช่า'.obs;
  final RxString selectedRoomType = 'คอนโด'.obs;
  final RxSet<String> selectedFacilities = <String>{}.obs;
  final RxInt bedroomCount = 1.obs;
  final RxInt bathroomCount = 1.obs;
  late final GlobalKey<FormState> formKey;
  late final TextEditingController titleController;
  late final TextEditingController areaController;
  late final TextEditingController floorController;
  late final TextEditingController priceController;
  late final TextEditingController detailController;
  late final TextEditingController locationController;

  // Firebase and GetStorage
  late final CollectionReference<Map<String, dynamic>> _propertysCollection;
  late final String _propertyId;
  late final GetStorage _box;

  @override
  void onInit() {
    super.onInit();
    formKey = GlobalKey<FormState>();
    titleController = TextEditingController();
    areaController = TextEditingController();
    floorController = TextEditingController();
    priceController = TextEditingController();
    detailController = TextEditingController();
    locationController = TextEditingController();

    _propertysCollection = FirebaseFirestore.instance.collection('propertys');
    _propertyId = Get.arguments;
    _box = GetStorage();

    _fetchPropertyData(_propertyId);
  }

  Future<void> _fetchPropertyData(String propertyId) async {
    try {
      final DocumentSnapshot propertyDocument = await _propertysCollection
          .doc(propertyId)
          .get();
      final data = propertyDocument.data() as Map<String, dynamic>;
      selectedPropertyType.value = data['property_type'];
      selectedRoomType.value = data['room_type'];
      titleController.text = data['title'];
      areaController.text = data['area'].toString();
      floorController.text = data['floor'].toString();
      bedroomCount.value = data['bedrooms'];
      bathroomCount.value = data['bathrooms'];
      priceController.text = data['price'].toString();
      detailController.text = data['detail'];
      locationController.text = data['location'];

      selectedFacilities.clear();
      if (data.containsKey('facilities') && data['facilities'] is Map) {
        Map<String, dynamic> firestoreFacilities = data['facilities'];
        for (var entry in firestoreFacilities.entries) {
          // convert English key back to Thai display name for UI
          String? thaiFacilityName = _engToThaiFacilityMap[entry.key];
          if (entry.value == true && thaiFacilityName != null) {
            selectedFacilities.add(thaiFacilityName);
          }
        }
      }
    } catch (e) {
      Get.snackbar(
        'เกิดข้อผิดพลาดในการดึงข้อมูล',
        'ไม่สามารถดึงข้อมูลประกาศได้: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.black,
        colorText: Colors.white,
      );
    }
  }

  Future<void> updateProperty() async {
    if (!formKey.currentState!.validate()) {
      Get.snackbar(
        'ข้อมูลไม่ถูกต้อง',
        'โปรดกรอกข้อมูลให้ถูกต้องและครบถ้วน',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    // use must select at least one facility
    if (selectedFacilities.isEmpty) {
      Get.snackbar(
        'ข้อมูลไม่ถูกต้อง',
        'โปรดเลือกสิ่งอำนวยความสะดวกอย่างน้อยหนึ่งรายการ',
        snackPosition: SnackPosition.TOP,
        colorText: Colors.white,
        backgroundColor: Colors.black,
      );
      return;
    }

    // show loading
    Get.dialog(
      const Center(child: CircularProgressIndicator()),
      barrierDismissible: false,
    );

    try {
      final String title = titleController.text.trim();
      final int area = int.parse(areaController.text.trim());
      final int floor = int.parse(floorController.text.trim());
      final int price = int.parse(priceController.text.trim());
      final String priceUnit = selectedPropertyType.value == 'เช่า'
          ? 'บาท / เดือน'
          : 'บาท';
      final String detail = detailController.text.trim();
      final String location = locationController.text.trim();
      final String uid = _box.read('userUid');

      // convert selected facilities to a map of boolean values for Firestore
      final Map<String, bool> facilitiesData = {};
      for (String facility in facilities) {
        final String? englishFacilityName = _thaiToEngFacilityMap[facility];
        if (englishFacilityName != null) {
          facilitiesData[englishFacilityName] = selectedFacilities.contains(
            facility,
          );
        }
      }

      // Prepare data for Firestore update
      final Map<String, dynamic> propertyData = {
        "property_type": selectedPropertyType.value,
        "room_type": selectedRoomType.value,
        "title": title,
        "location": location,
        "bedrooms": bedroomCount.value,
        "bathrooms": bathroomCount.value,
        "area": area,
        "floor": floor,
        "price": price,
        "price_unit": priceUnit,
        "facilities": facilitiesData,
        "detail": detail,
        "owner_id": uid,
        "updated_at": DateTime.now().toIso8601String(), // add updated timestamp
        "is_approved": false,
      };

      await _propertysCollection.doc(_propertyId).update(propertyData);

      Get.back();
      Get.snackbar(
        'แก้ไขประกาศสำเร็จ',
        'ประกาศของคุณได้รับการแก้ไขแล้ว',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

      // Refresh relevant lists/details after successful update
      if (Get.isRegistered<CreatedPropertyListController>()) {
        Get.find<CreatedPropertyListController>().fetchCreatedProperty();
      }

      if (Get.isRegistered<HomeController>()) {
        Get.find<HomeController>().fetchPropertys();
      }

      if (Get.isRegistered<PropertyDetailsController>()) {
        Get.find<PropertyDetailsController>().fetchPropertyDetails(_propertyId);
      }
    } catch (e) {
      Get.back();
      Get.snackbar(
        'เกิดข้อผิดพลาด',
        'ไม่สามารถแก้ไขประกาศได้: ${e.toString()}',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  @override
  void onClose() {
    titleController.dispose();
    areaController.dispose();
    floorController.dispose();
    priceController.dispose();
    detailController.dispose();
    locationController.dispose();
    super.onClose();
  }
}
