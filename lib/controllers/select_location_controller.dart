import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class SelectLocationController extends GetxController {
  final Rxn<LatLng> pickedLocation = Rxn<LatLng>();
  late GoogleMapController mapController;
  final LatLng initialLocation = const LatLng(
    13.736717,
    100.523186,
  ); // Default to Bangkok.
  final Dio _dio = Dio();
  late TextEditingController searchController;

  final String _googleApiKey = dotenv.env['GOOGLE_MAPS_API_KEY'] ?? '';

  @override
  void onInit() {
    super.onInit();
    searchController = TextEditingController();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        Get.snackbar(
          'บริการตำแหน่งปิดอยู่',
          'กรุณาเปิด GPS',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.black,
          colorText: Colors.white,
        );
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.deniedForever) {
        Get.snackbar(
          'สิทธิ์ถูกปฏิเสธถาวร',
          'กรุณาเปิดสิทธิ์การเข้าถึงตำแหน่งในตั้งค่า',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.black,
          colorText: Colors.white,
        );
        return;
      }

      if (permission == LocationPermission.whileInUse ||
          permission == LocationPermission.always) {
        final position = await Geolocator.getCurrentPosition();
        mapController.animateCamera(
          CameraUpdate.newLatLngZoom(
            LatLng(position.latitude, position.longitude),
            15,
          ),
        );
      }
    } catch (e) {
      Get.snackbar(
        'ไม่สามารถระบุตำแหน่งได้',
        'เกิดข้อผิดพลาด: $e',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.black,
        colorText: Colors.white,
      );
    }
  }

  void onMapTap(LatLng position) {
    pickedLocation.value = position;
  }

  void onSave() async {
    if (pickedLocation.value != null) {
      await fetchAddressFromCoordinates(pickedLocation.value!);
    } else {
      Get.snackbar(
        'ยังไม่เลือกตำแหน่ง',
        'กรุณาแตะที่แผนที่เพื่อเลือกตำแหน่ง',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.black,
        colorText: Colors.white,
      );
    }
  }

  Future<void> fetchAddressFromCoordinates(LatLng latLng) async {
    try {
      const url = "https://maps.googleapis.com/maps/api/geocode/json";
      final response = await _dio.get(
        url,
        queryParameters: {
          'latlng': '${latLng.latitude},${latLng.longitude}',
          'key': _googleApiKey,
          'language': 'th',
        },
      );

      final results = response.data['results'];
      if (results != null && results.isNotEmpty) {
        final formattedAddress = results[0]['formatted_address'];
        Get.back(result: {'latLng': latLng, 'address': formattedAddress});
      } else {
        Get.snackbar('ไม่พบที่อยู่', 'ไม่สามารถแปลงพิกัดเป็นที่อยู่ได้');
      }
    } catch (e) {
      Get.snackbar(
        'เกิดข้อผิดพลาด',
        'ไม่สามารถเรียกข้อมูลที่อยู่ได้',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<LatLng?> getLatLngFromPlace(String place) async {
    try {
      const url = "https://maps.googleapis.com/maps/api/geocode/json";
      final response = await _dio.get(
        url,
        queryParameters: {
          'address': place,
          'key': _googleApiKey,
          'language': 'th',
        },
      );

      final data = response.data;
      if (data['status'] != 'OK') {
        debugPrint(
          'Geocoding failed: ${data['status']} - ${data['error_message']}',
        );
        return null;
      }

      final results = data['results'];
      if (results != null && results.isNotEmpty) {
        final location = results[0]['geometry']['location'];
        return LatLng(location['lat'], location['lng']);
      }
    } catch (e) {
      debugPrint('Error in getLatLngFromPlace: $e');
    }

    return null;
  }

  Future<void> searchPlace(String query) async {
    final trimmed = query.trim();
    if (trimmed.isEmpty) return;

    final result = await getLatLngFromPlace(trimmed);
    if (result != null) {
      mapController.animateCamera(CameraUpdate.newLatLngZoom(result, 15));
      pickedLocation.value = result;
    } else {
      Get.snackbar(
        'ไม่พบตำแหน่ง',
        'กรุณาลองคำค้นหาอื่น',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.black,
        colorText: Colors.white,
      );
    }
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}
