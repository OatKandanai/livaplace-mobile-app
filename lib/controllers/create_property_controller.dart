import 'package:get/get.dart';

class CreatePropertyController extends GetxController {
  final List<String> propertyType = ['เช่า', 'ขาย'];
  final List<String> roomType = ['คอนโด', 'อพาร์ทเม้นท์', 'หอพัก'];
  final RxString selectedPropertyType = 'เช่า'.obs;
  final RxString selectedRoomType = 'คอนโด'.obs;
  final RxInt bedroomCount = 1.obs;
  final RxInt bathroomCount = 1.obs;
}
