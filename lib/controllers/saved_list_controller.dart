import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SavedListController extends GetxController {
  late CollectionReference<Map<String, dynamic>> savedList;
  late GetStorage box;
  late String _currentUserId;
  late final CollectionReference<Map<String, dynamic>> _propertyList;

  @override
  void onInit() {
    super.onInit();
    savedList = FirebaseFirestore.instance.collection('saved_property');
    box = GetStorage();
    _currentUserId = box.read('userUid');
    fetchSavedList();
  }

  Future<void> fetchSavedList() async {
    final QuerySnapshot querySnapshot = 
  }
}
