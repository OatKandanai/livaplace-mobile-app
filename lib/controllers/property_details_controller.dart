import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_storage/get_storage.dart';
import 'package:livaplace_app/controllers/saved_list_controller.dart';
import 'package:url_launcher/url_launcher.dart';

class PropertyDetailsController extends GetxController {
  // UI related variables
  final RxMap<String, dynamic> propertyDetails = <String, dynamic>{}.obs;
  final RxMap<String, dynamic> ownerDetails = <String, dynamic>{}.obs;
  RxBool isSaved = false.obs;
  RxBool isSaving = false.obs;
  DateTime? _lastTapTime;

  // Firebase
  late final FirebaseFirestore _firestore;
  late final CollectionReference<Map<String, dynamic>> _savedPropertyCollection;

  // GetStorage
  late GetStorage box;
  late final String _currentUserId;

  @override
  void onInit() {
    super.onInit();

    // initialize Firebase
    _firestore = FirebaseFirestore.instance;
    _savedPropertyCollection = _firestore.collection('saved_propertys');

    // initialize GetStorage
    box = GetStorage();
    _currentUserId = box.read('userUid');

    // retrieve the property ID passed as arguments
    final String propertyId = Get.arguments;
    fetchPropertyDetails(propertyId);
  }

  Future<void> fetchPropertyDetails(String propertyId) async {
    try {
      // fetch property details
      final DocumentSnapshot propertyDocument = await _firestore
          .collection('propertys')
          .doc(propertyId)
          .get();

      if (propertyDocument.exists) {
        propertyDetails.value = propertyDocument.data() as Map<String, dynamic>;
        propertyDetails['id'] =
            propertyDocument.id; // add key-value of property ID

        // fetch owner details
        final String ownerId = propertyDetails['owner_id'];
        await fetchOwnerDetails(ownerId);

        // check if the property is saved by the current user
        await _checkIfPropertyIsSaved();
      } else {
        Get.snackbar(
          'เกิดข้อผิดพลาด',
          'ไม่พบประกาศ',
          snackPosition: SnackPosition.TOP,
          colorText: Colors.white,
          backgroundColor: Colors.black,
        );
        propertyDetails.value = {}; // clear details if not found
      }
    } catch (e) {
      Get.snackbar(
        'เกิดข้อผิดพลาดในการดึงข้อมูลประกาศ',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        colorText: Colors.white,
        backgroundColor: Colors.black,
      );
      propertyDetails.value = {}; // clear details on error
    }
  }

  Future<void> fetchOwnerDetails(String ownerId) async {
    try {
      final DocumentSnapshot ownerDocument = await _firestore
          .collection('users')
          .doc(ownerId)
          .get();

      if (ownerDocument.exists) {
        ownerDetails.value = ownerDocument.data() as Map<String, dynamic>;
      } else {
        ownerDetails.value = {}; // clear on not found
      }
    } catch (e) {
      ownerDetails.value = {}; // clear on error
    }
  }

  Future<void> _checkIfPropertyIsSaved() async {
    final String propertyId = propertyDetails['id'];

    try {
      final QuerySnapshot querySnapshot = await _savedPropertyCollection
          .where('user_id', isEqualTo: _currentUserId)
          .where('property_id', isEqualTo: propertyId)
          .limit(1)
          .get();

      isSaved.value = querySnapshot.docs.isNotEmpty;
    } catch (e) {
      debugPrint("เกิดข้อผิดพลาดในการเช็ครายการที่บันทึก: $e");
      isSaved.value = false;
    }
  }

  Future<void> saveProperty() async {
    final now = DateTime.now();
    if (_lastTapTime != null &&
        now.difference(_lastTapTime!) < const Duration(seconds: 2)) {
      return;
    }
    _lastTapTime = now;

    if (isSaving.value) return;
    isSaving.value = true;

    final String propertyId = propertyDetails['id'];

    try {
      if (isSaved.value) {
        // UNSAVE LOGIC
        final QuerySnapshot querySnapshot = await _savedPropertyCollection
            .where('user_id', isEqualTo: _currentUserId)
            .where('property_id', isEqualTo: propertyId)
            .limit(1)
            .get();

        if (querySnapshot.docs.isNotEmpty) {
          await _savedPropertyCollection
              .doc(querySnapshot.docs.first.id)
              .delete();

          isSaved.value = false;

          Get.snackbar(
            'ลบออกจากรายการที่บันทึกแล้ว',
            'ประกาศนี้ถูกลบออกจากรายการของคุณแล้ว',
            snackPosition: SnackPosition.BOTTOM,
            colorText: Colors.white,
            backgroundColor: Colors.black,
            duration: const Duration(seconds: 1),
          );
        }
      } else {
        // SAVE LOGIC
        await _savedPropertyCollection.add({
          'user_id': _currentUserId,
          'property_id': propertyId,
        });

        isSaved.value = true;

        Get.snackbar(
          'เพิ่มในรายการที่บันทึกแล้ว',
          'ประกาศนี้ถูกเพิ่มในรายการของคุณแล้ว',
          snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.white,
          backgroundColor: Colors.black,
          duration: const Duration(seconds: 1),
        );
      }

      // Refresh saved list if controller exists
      if (Get.isRegistered<SavedListController>()) {
        Get.find<SavedListController>().fetchSavedList();
      }
    } catch (e) {
      Get.snackbar(
        'เกิดข้อผิดพลาด',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        colorText: Colors.white,
        backgroundColor: Colors.black,
      );
    } finally {
      isSaving.value = false;
    }
  }

  Future<void> makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    } else {
      Get.snackbar(
        'เกิดข้อผิดพลาด',
        'ไม่สามารถโทรออกได้',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.black,
        colorText: Colors.white,
      );
    }
  }

  Future<void> contactViaLine(String lineId) async {
    if (lineId.isEmpty) {
      Get.snackbar(
        'ข้อผิดพลาด',
        'ไม่พบ LINE ID',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    debugPrint('Attempting to contact LINE ID: $lineId');

    // copy LINE ID to clipboard
    await Clipboard.setData(ClipboardData(text: lineId));
    debugPrint('LINE ID "$lineId" copied to clipboard.');

    final Uri lineAppUri = Uri.parse('line://ti/p/~$lineId');
    final Uri lineWebUri = Uri.parse('https://line.me/ti/p/~$lineId');

    String snackbarMessage =
        'คัดลอก LINE ID แล้ว: "$lineId"\nโปรดวางในช่องค้นหาเพื่อนใน LINE';
    Color snackbarColor = Colors.blueGrey;

    try {
      if (await canLaunchUrl(lineAppUri)) {
        debugPrint('Launching LINE app via scheme: $lineAppUri');
        await launchUrl(lineAppUri);
        debugPrint('LINE app launched successfully.');
        snackbarMessage =
            'คัดลอก LINE ID แล้ว: "$lineId"\nโปรดวางในช่องค้นหาเพื่อนใน LINE';
        snackbarColor = Colors.green; // indicate success and instruction
      } else if (await canLaunchUrl(lineWebUri)) {
        debugPrint('Launching LINE web via universal link: $lineWebUri');
        await launchUrl(lineWebUri);
        debugPrint('LINE web launched successfully.');
        snackbarMessage =
            'คัดลอก LINE ID แล้ว: "$lineId"\nโปรดวางในช่องค้นหาเพื่อนใน LINE';
        snackbarColor = Colors.green; // indicate success and instruction
      } else {
        debugPrint('Neither LINE app nor web link could be launched.');
        snackbarMessage =
            'คัดลอก LINE ID แล้ว: "$lineId"\nไม่สามารถเปิด LINE ได้อัตโนมัติ โปรดเปิด LINE และวางในช่องค้นหาเพื่อน';
        snackbarColor =
            Colors.orange; // indicate partial success with more instruction
      }
    } catch (e) {
      debugPrint('Error launching LINE: $e');
      snackbarMessage =
          'คัดลอก LINE ID แล้ว: "$lineId"\nเกิดข้อผิดพลาดในการเปิด LINE: $e';
      snackbarColor = Colors.red; // indicate error
    }

    Get.snackbar(
      'แจ้งเตือน',
      snackbarMessage,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: snackbarColor,
      colorText: Colors.white,
      duration: const Duration(seconds: 5),
    );
  }
}
