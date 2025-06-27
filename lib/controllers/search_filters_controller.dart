import 'package:get/get.dart';

class SearchFiltersController extends GetxController {
  final List<String> types = ['ทุกประเภท', 'คอนโด', 'หอพัก'];
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
  final RxString selectedType = 'คอนโด'.obs;
  final RxSet<String> selectedFacilities = <String>{}.obs;
  final RxInt bedroomCount = 1.obs;
  final RxInt bathroomCount = 1.obs;

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
}
