import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  late final CollectionReference<Map<String, dynamic>> _propertysCollection;
  final RxList<Map<String, dynamic>> propertys = <Map<String, dynamic>>[].obs;
  final RxBool isLoading = true.obs;
  final RxString errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    _propertysCollection = FirebaseFirestore.instance.collection('propertys');
    fetchPropertys();
  }

  Future<void> fetchPropertys() async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot = await _propertysCollection
          .get();

      // include the document ID in the mapped data
      propertys.value = snapshot.docs.map((doc) {
        final Map<String, dynamic> data = doc.data();
        data['id'] = doc.id; // Add the document ID to the map
        return data;
      }).toList();
    } on FirebaseException catch (e) {
      errorMessage.value = 'Failed to fetch properties: ${e.message}';
    } catch (e) {
      errorMessage.value = 'An unexpected error occurred: ${e.toString()}';
    } finally {
      isLoading.value = false;
    }
  }
}
