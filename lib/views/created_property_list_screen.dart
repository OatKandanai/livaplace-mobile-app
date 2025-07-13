import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:livaplace_app/controllers/created_property_list_controller.dart';
import 'package:livaplace_app/routes/app_routes.dart';
import 'package:livaplace_app/views/property_card.dart';

class CreatedPropertyListScreen extends GetView<CreatedPropertyListController> {
  const CreatedPropertyListScreen({super.key});

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
                  text: 'รายการประกาศของฉัน',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const TextSpan(text: '\u00A0\u00A0'),
                TextSpan(
                  text: '(${controller.propertyList.length})',
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
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Center(
          child: Obx(() {
            if (controller.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            }

            if (controller.propertyList.isEmpty) {
              return const Center(
                child: Text(
                  'คุณไม่มีรายการที่บันทึก',
                  style: TextStyle(fontSize: 16),
                ),
              );
            }

            return ListView.separated(
              itemBuilder: (context, index) {
                final Map<String, dynamic> property =
                    controller.propertyList[index];
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

                return Stack(
                  children: [
                    PropertyCard(
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
                    ),
                    Positioned(
                      left: 10,
                      bottom: 10,
                      child: Container(
                        width: 40,
                        height: 40,
                        padding: const EdgeInsets.all(0),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          icon: const Icon(
                            Icons.delete_forever_rounded,
                            size: 26,
                            color: Colors.redAccent,
                          ),
                          onPressed: () {
                            Get.defaultDialog(
                              barrierDismissible: false,
                              title: 'คุณแน่ใจหรือไม่ว่าต้องการลบประกาศนี้',
                              titleStyle: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                              // middleText:
                              //     'คุณแน่ใจหรือไม่ว่าต้องการลบประกาศนี้',
                              // middleTextStyle: const TextStyle(fontSize: 16),
                              content: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(title),
                              ),
                              textConfirm: 'ลบประกาศ',
                              textCancel: 'ยกเลิก',
                              confirmTextColor: Colors.white,
                              cancelTextColor: Colors.black,
                              buttonColor: Colors.red,
                              backgroundColor: Colors.white,
                              onConfirm: () {
                                Get.back();
                                controller.deleteProperty(propertyId);
                              },
                              onCancel: () {},
                            );
                          },
                        ),
                      ),
                    ),
                    Positioned(
                      left: 60,
                      bottom: 10,
                      child: Container(
                        width: 40,
                        height: 40,
                        padding: const EdgeInsets.all(0),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          icon: const Icon(
                            Icons.edit_document,
                            size: 26,
                            color: Colors.orange,
                          ),
                          onPressed: () {
                            Get.toNamed(AppRoutes.edit, arguments: propertyId);
                          },
                        ),
                      ),
                    ),
                  ],
                );
              },
              separatorBuilder: (context, index) => const SizedBox(height: 10),
              itemCount: controller.propertyList.length,
            );
          }),
        ),
      ),
    );
  }
}
