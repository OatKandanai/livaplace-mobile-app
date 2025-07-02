import 'package:get/get.dart';
import 'package:livaplace_app/controllers/create_property_controller.dart';

class CreatePropertyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CreatePropertyController());
  }
}
