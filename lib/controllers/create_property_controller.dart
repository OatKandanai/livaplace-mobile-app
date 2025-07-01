import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreatePropertyController extends GetxController {
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
  final Map<String, String> facilityKeyMap = {
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
  final RxString selectedPropertyType = 'เช่า'.obs;
  final RxString selectedRoomType = 'คอนโด'.obs;
  final RxInt bedroomCount = 1.obs;
  final RxInt bathroomCount = 1.obs;
  final RxSet<String> selectedFacilities = <String>{}.obs;
  late final GlobalKey<FormState> formKey;
  late final TextEditingController titleController;
  late final TextEditingController areaController;
  late final TextEditingController floorController;
  late final TextEditingController priceController;
  late final TextEditingController detailController;
  late final TextEditingController locationController;

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
  }

  Future<void> createProperty() async {
    String title = titleController.text.trim();
    int area = int.parse(areaController.text.trim());
    int floor = int.parse(floorController.text.trim());
    int price = int.parse(priceController.text.trim());
    String detail = detailController.text.trim();
    String location = locationController.text.trim();

    if (!formKey.currentState!.validate()) {
      Get.snackbar(
        'ข้อมูลไม่ถูกต้อง',
        'โปรดกรอกข้อมูลให้ถูกต้องและครบถ้วน',
        snackPosition: SnackPosition.TOP,
        colorText: Colors.white,
        backgroundColor: Colors.black,
      );
      return;
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
