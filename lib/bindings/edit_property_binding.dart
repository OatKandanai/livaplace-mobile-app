import 'package:get/get.dart';
import 'package:livaplace_app/controllers/edit_property_controller.dart';

class EditPropertyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => EditPropertyController());
  }
}
