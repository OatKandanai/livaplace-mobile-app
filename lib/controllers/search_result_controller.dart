import 'package:get/get.dart';
import 'package:livaplace_app/models/property_model.dart';

class SearchResultController extends GetxController {
  final RxList<PropertyModel> searchResults = <PropertyModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    _loadSearchResult();
  }

  void _loadSearchResult() async {
    final args = Get.arguments;
    if (args != null && args is List<PropertyModel>) {
      searchResults.assignAll(args);
    } else {
      searchResults.clear();
    }
  }
}
