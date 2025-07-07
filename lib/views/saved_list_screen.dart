import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:livaplace_app/controllers/saved_list_controller.dart';
import 'package:livaplace_app/views/property_card.dart';

class SavedListScreen extends GetView<SavedListController> {
  const SavedListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(
          () => RichText(
            text: TextSpan(
              style: GoogleFonts.mitr(color: Colors.black),
              children: <TextSpan>[
                const TextSpan(
                  text: 'รายการที่บันทึก',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const TextSpan(text: '\u00A0\u00A0'),
                TextSpan(
                  text: '(${controller.savedPropertyList.length})',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Obx(() {
            if (controller.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            }

            if (controller.savedPropertyList.isEmpty) {
              return const Center(
                child: Text(
                  'คุณไม่มีรายการที่บันทึก',
                  style: TextStyle(fontSize: 16),
                ),
              );
            }

            if (controller.errorMessage.isNotEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      controller.errorMessage.value,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () => controller.fetchSavedList(),
                      child: const Text('ลองอีกครั้ง'),
                    ),
                  ],
                ),
              );
            }

            return ListView.separated(
              itemBuilder: (context, index) {
                final Map<String, dynamic> property =
                    controller.savedPropertyList[index];
                final String propertyId = property['id'];
                final String imageUrl =
                    property['images'][0]; // get only first image
                final String propertyType = property['property_type'];
                final String roomType = property['room_type'];
                final String title = property['title'];
                final String location = property['location'];
                final int bedrooms = property['bedrooms'];
                final int bathrooms = property['bathrooms'];
                final int price = property['price'];
                final String priceUnit = property['price_unit'];
                final DateTime? created = DateTime.tryParse(
                  '${property['created_at']}',
                );

                return PropertyCard(
                  propertyId: propertyId,
                  imageUrl: imageUrl,
                  propertyType: propertyType,
                  roomType: roomType,
                  title: title,
                  location: location,
                  bedrooms: bedrooms,
                  bathrooms: bathrooms,
                  price: price,
                  priceUnit: priceUnit,
                  created: created!,
                );
              },
              separatorBuilder: (context, index) => const SizedBox(height: 10),
              itemCount: controller.savedPropertyList.length,
            );
          }),
        ),
      ),
    );
  }
}
