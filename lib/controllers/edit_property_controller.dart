import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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

  // for convert Thai facility names to English keys for Firestore
  final Map<String, String> _facilityKeyMap = {
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

  // Firestore Reference
  late final CollectionReference<Map<String, dynamic>> _propertysCollection;

  // retrieve the property ID passed as arguments
  final String properyId = Get.arguments;

  @override
  void onInit() {
    super.onInit();
    // initialize form key and text controllers
    formKey = GlobalKey<FormState>();
    titleController = TextEditingController();
    areaController = TextEditingController();
    floorController = TextEditingController();
    priceController = TextEditingController();
    detailController = TextEditingController();
    locationController = TextEditingController();

    // initialize Firestore collection reference and FirebaseAuth
    _propertysCollection = FirebaseFirestore.instance.collection('propertys');

    _fetchPropertyData();
  }

  Future<void> _fetchPropertyData() async {
    try {
      final DocumentSnapshot propertyDocument = await _propertysCollection
          .doc(properyId)
          .get();
      final propertyData = propertyDocument.data() as Map<String, dynamic>;
      titleController.text = propertyData['title'];
    } catch (e) {}
  }

  Future<void> updateProperty() async {}
}
