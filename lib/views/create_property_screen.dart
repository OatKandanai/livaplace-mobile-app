import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:livaplace_app/controllers/create_property_controller.dart';

class CreatePropertyScreen extends StatelessWidget {
  CreatePropertyScreen({super.key});

  final CreatePropertyController controller = Get.put(
    CreatePropertyController(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 40),
            child: Center(
              child: Column(
                children: [
                  const Text('ลงประกาศ', style: TextStyle(fontSize: 24)),
                  const Text('หมายเหตุ : ประกาศจะต้องรอการอนุมัติจากผู้ดูแล'),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        const Text('ประเภททรัพย์ : '),
                        Obx(
                          () => Wrap(
                            spacing: 10,
                            children: controller.propertyType.map((type) {
                              return ChoiceChip(
                                showCheckmark: false,
                                label: Text(type),
                                labelStyle: TextStyle(
                                  color:
                                      controller.selectedPropertyType.value ==
                                          type
                                      ? Colors.white
                                      : Colors.black,
                                ),
                                elevation: 10,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                backgroundColor:
                                    Colors.grey.shade200, // unactive bg color
                                selectedColor: Colors.black, // active bg color
                                selected:
                                    controller.selectedPropertyType.value ==
                                    type,
                                onSelected: (_) {
                                  controller.selectedPropertyType.value = type;
                                },
                              );
                            }).toList(),
                          ),
                        ),

                        const Text('ประเภทห้อง : '),
                        Obx(
                          () => Wrap(
                            spacing: 10,
                            children: controller.roomType.map((type) {
                              return ChoiceChip(
                                showCheckmark: false,
                                label: Text(type),
                                labelStyle: TextStyle(
                                  color:
                                      controller.selectedRoomType.value == type
                                      ? Colors.white
                                      : Colors.black,
                                ),
                                elevation: 10,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                backgroundColor:
                                    Colors.grey.shade200, // unactive bg color
                                selectedColor: Colors.black, // active bg color
                                selected:
                                    controller.selectedRoomType.value == type,
                                onSelected: (_) {
                                  controller.selectedRoomType.value = type;
                                },
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
