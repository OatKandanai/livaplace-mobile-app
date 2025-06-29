import 'package:get/get.dart';

class CreatePropertyController extends GetxController {
  List<String> propertyType = ['เช่า', 'ขาย'];
  List<String> roomType = ['คอนโด', 'อพาร์ทเม้นท์', 'หอพัก'];
  RxString selectedPropertyType = 'เช่า'.obs;
  RxString selectedRoomType = 'คอนโด'.obs;
}
