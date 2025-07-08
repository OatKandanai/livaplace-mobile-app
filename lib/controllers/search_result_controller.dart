import 'package:get/get.dart';
import 'package:livaplace_app/models/property_model.dart';

class SearchResultController extends GetxController {
  final RxList<PropertyModel> searchResults = <PropertyModel>[].obs;
  final RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null && Get.arguments is List<PropertyModel>) {
      searchResults.assignAll(Get.arguments as List<PropertyModel>);
    }
    isLoading.value = false;
  }
}
