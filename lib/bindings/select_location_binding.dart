import 'package:get/get.dart';
import 'package:livaplace_app/controllers/select_location_controller.dart';

class SelectLocationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SelectLocationController(), fenix: true);
  }
}
