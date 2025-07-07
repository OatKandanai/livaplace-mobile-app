import 'package:get/get.dart';
import 'package:livaplace_app/controllers/search_filters_controller.dart';

class SearchFiltersBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SearchFiltersController());
  }
}
