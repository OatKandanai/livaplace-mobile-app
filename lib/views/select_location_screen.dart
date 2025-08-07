import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:get/get.dart';
import 'package:livaplace_app/controllers/select_location_controller.dart';

class SelectLocationScreen extends GetView<SelectLocationController> {
  const SelectLocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('เลือกตำแหน่ง'), centerTitle: true),
      body: Stack(
        children: [
          Obx(
            () => GoogleMap(
              initialCameraPosition: CameraPosition(
                target: controller.initialLocation,
                zoom: 14,
              ),
              onMapCreated: (ctx) => controller.mapController = ctx,
              onTap: controller.onMapTap,
              markers: controller.pickedLocation.value != null
                  ? {
                      Marker(
                        markerId: const MarkerId('picked'),
                        position: controller.pickedLocation.value!,
                      ),
                    }
                  : {},
            ),
          ),

          // search bar
          Positioned(
            top: 20,
            left: 20,
            right: 20,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(color: Colors.black26, blurRadius: 5),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: controller.searchController,
                      decoration: const InputDecoration(
                        hintText: 'ค้นหาสถานที่...',
                        border: InputBorder.none,
                      ),
                      onSubmitted: controller.searchPlace,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () => controller.searchPlace(
                      controller.searchController.text,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // submit button
          Positioned(
            bottom: 20,
            left: 20,
            child: FloatingActionButton.extended(
              onPressed: controller.onSave,
              backgroundColor: Colors.white,
              icon: const Icon(Icons.check),
              label: const Text(
                'บันทึกตำแหน่ง',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
