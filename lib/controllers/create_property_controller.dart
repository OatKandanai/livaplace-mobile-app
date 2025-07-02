import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:image_picker/image_picker.dart';

class CreatePropertyController extends GetxController {
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

    // initialize Firestore collection reference
    _propertysCollection = FirebaseFirestore.instance.collection('propertys');
  }

  Future<void> createProperty() async {
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

    // Add validation for images
    if (selectedLocalImages.isEmpty) {
      Get.snackbar(
        'ข้อมูลไม่ถูกต้อง',
        'โปรดอัปโหลดรูปภาพอย่างน้อยหนึ่งรูป',
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
      final List<String> uploadedImageUrls = await _uploadImagesToCloudinary();
      if (uploadedImageUrls.isEmpty && selectedLocalImages.isNotEmpty) {
        Get.back(); // Dismiss loading
        Get.snackbar(
          'ข้อผิดพลาดในการอัปโหลดรูปภาพ',
          'ไม่สามารถอัปโหลดรูปภาพทั้งหมดได้ โปรดลองอีกครั้ง',
          snackPosition: SnackPosition.TOP,
          colorText: Colors.white,
          backgroundColor: Colors.red,
        );
        return;
      }

      String title = titleController.text.trim();
      int area = int.parse(areaController.text.trim());
      int floor = int.parse(floorController.text.trim());
      int price = int.parse(priceController.text.trim());
      String priceUnit = selectedPropertyType.value == 'เช่า'
          ? 'บาท / เดือน'
          : 'บาท';
      String detail = detailController.text.trim();
      String location = locationController.text.trim();

      // convert selected facilities to a map of boolean values for Firestores
      final Map<String, bool> facilitiesData = {};
      for (String facility in facilities) {
        final String? englishFacilityName = _facilityKeyMap[facility];
        if (englishFacilityName != null) {
          facilitiesData[englishFacilityName] = selectedFacilities.contains(
            facility,
          );
        }
      }

      // prepare data for FireStore
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
        "images": [
          'https://images.unsplash.com/photo-1594873604892-b599f847e859?q=80&w=687&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
          'https://images.unsplash.com/photo-1704040686413-2c607dbd2f06?q=80&w=1740&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
          'https://images.unsplash.com/photo-1628744876497-eb30460be9f6?q=80&w=1740&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
        ],
        "facilities": facilitiesData,
        "detail": detail,
        "owner_id": 1,
        "owner_name": "Lisa",
        "created_at": Timestamp.now(),
        "is_approved": false,
      };

      // add property data to FireStore
      await _propertysCollection.add(propertyData);

      // dismiss loading and show success
      Get.back();
      Get.snackbar(
        'สร้างประกาศสำเร็จ',
        'ประกาศของคุณจะได้รับการตรวจสอบจากผู้ดูแลระบบ',
        snackPosition: SnackPosition.TOP,
        colorText: Colors.white,
        backgroundColor: Colors.black,
      );

      // clear form fields after successful create
      // _clearForm();
    } catch (e) {
      Get.back(); // dismiss get dialog
      Get.snackbar(
        'เกิดข้อผิดพลาด',
        'ไม่สามารถสร้างประกาศได้ ${e.toString()}',
        snackPosition: SnackPosition.TOP,
        colorText: Colors.white,
        backgroundColor: Colors.black,
      );
    }
  }

  final RxList<XFile> selectedLocalImages =
      <XFile>[].obs; // To store locally selected images
  final ImagePicker _picker = ImagePicker();
  final CloudinaryPublic _cloudinary = CloudinaryPublic(
    'dme1aety8', // Replace with your Cloudinary cloud name
    'flutter_property_upload', // Replace with your Cloudinary upload preset
    cache: true,
  );

  Future<void> pickImages() async {
    try {
      final List<XFile> images = await _picker.pickMultiImage();
      if (images.isNotEmpty) {
        selectedLocalImages.addAll(images);
      }
    } catch (e) {
      Get.snackbar(
        'ข้อผิดพลาด',
        'ไม่สามารถเลือกรูปภาพได้: $e',
        snackPosition: SnackPosition.BOTTOM,
        colorText: Colors.white,
        backgroundColor: Colors.red,
      );
    }
  }

  Future<List<String>> _uploadImagesToCloudinary() async {
    List<String> imageUrls = [];
    if (selectedLocalImages.isEmpty) return imageUrls;

    for (XFile image in selectedLocalImages) {
      try {
        CloudinaryResponse response = await _cloudinary.uploadFile(
          CloudinaryFile.fromFile(
            image.path,
            resourceType: CloudinaryResourceType.Image,
          ),
        );
        imageUrls.add(response.secureUrl);
      } catch (e) {
        print("Error uploading image to Cloudinary: $e");
        // Handle individual image upload errors, maybe skip this image
      }
    }
    return imageUrls;
  }

  // void _clearForm() {
  //   titleController.clear();
  //   areaController.clear();
  //   floorController.clear();
  //   priceController.clear();
  //   detailController.clear();
  //   locationController.clear();
  //   selectedPropertyType.value = 'เช่า'; // reset to default
  //   selectedRoomType.value = 'คอนโด'; // reset to default
  //   selectedFacilities.clear(); // clear selected facilities
  //   bedroomCount.value = 1; // reset to default
  //   bathroomCount.value = 1; // reset to default
  //   formKey.currentState?.reset();
  // }

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
