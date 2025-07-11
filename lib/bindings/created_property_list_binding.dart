import 'package:get/get.dart';
import 'package:livaplace_app/controllers/created_property_list_controller.dart';

class CreatedPropertyListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CreatedPropertyListController());
  }
}
