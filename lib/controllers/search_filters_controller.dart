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

  Future<void> search() async {}

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }
}
