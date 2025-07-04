import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:livaplace_app/routes/app_routes.dart';

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

  // GetStorage instance
  late final GetStorage _box;

  // for uploading images
  final RxList<XFile> selectedLocalImages =
      <XFile>[].obs; // To store locally selected images
  late final ImagePicker _picker;
  late final CloudinaryPublic _cloudinary;

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

    // initialize GetStorage
    _box = GetStorage();

    // initialize Image Picker
    _picker = ImagePicker();
    _cloudinary = CloudinaryPublic(
      'dme1aety8', // Cloudinary cloud name
      'flutter_property_upload', // Cloudinary upload preset
      cache: true,
    );
  }

  Future<void> pickImages() async {
    try {
      final List<XFile> images = await _picker.pickMultiImage();

      const int maxImages = 10; // images limit

      if (images.isNotEmpty) {
        // calculate how many more images can be added
        int availableSlots = maxImages - selectedLocalImages.length;

        // check if there are no available slots left
        if (availableSlots <= 0) {
          Get.snackbar(
            'ข้อจำกัดรูปภาพ',
            'คุณสามารถเพิ่มรูปภาพได้สูงสุด $maxImages รูป',
            snackPosition: SnackPosition.TOP,
            colorText: Colors.white,
            backgroundColor: Colors.black,
            duration: const Duration(seconds: 5),
          );
          return;
        }

        // only add up to the available slots
        List<XFile> imagesToAdd = images.take(availableSlots).toList();
        selectedLocalImages.addAll(imagesToAdd);

        // inform user if they selected more than the allowed limit
        if (images.length > availableSlots) {
          Get.snackbar(
            'ข้อจำกัดรูปภาพ',
            'คุณเลือกรูปภาพเกินจำนวนที่อนุญาต ($maxImages รูป) ระบบได้เพิ่มรูปภาพเพียง $availableSlots รูป',
            snackPosition: SnackPosition.TOP,
            colorText: Colors.white,
            backgroundColor: Colors.black,
            duration: const Duration(seconds: 5),
          );
        }
      }
    } catch (e) {
      Get.snackbar(
        'ข้อผิดพลาด',
        'ไม่สามารถเลือกรูปภาพได้: $e',
        snackPosition: SnackPosition.TOP,
        colorText: Colors.white,
        backgroundColor: Colors.black,
        duration: const Duration(seconds: 5),
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

    // validation for images
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
        "images": uploadedImageUrls,
        "facilities": facilitiesData,
        "detail": detail,
        "owner_id": uid,
        "created_at": DateTime.now().toIso8601String(),
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

      Get.offAllNamed(AppRoutes.home);

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
