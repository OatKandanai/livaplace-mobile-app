import 'package:get/get.dart';
import 'package:livaplace_app/controllers/property_details_controller.dart';

class PropertyDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PropertyDetailsController());
  }
}
