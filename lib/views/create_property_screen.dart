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
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: FocusScope.of(context).unfocus,
      child: Scaffold(
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
                      child: Form(
                        child: Column(
                          children: [
                            const Text('ประเภททรัพย์'),
                            const SizedBox(height: 10),

                            // property type
                            Obx(
                              () => Wrap(
                                spacing: 10,
                                children: controller.propertyType.map((type) {
                                  return ChoiceChip(
                                    showCheckmark: false,
                                    label: Text(type),
                                    labelStyle: TextStyle(
                                      color:
                                          controller
                                                  .selectedPropertyType
                                                  .value ==
                                              type
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                    elevation: 10,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    backgroundColor: Colors
                                        .grey
                                        .shade200, // unactive bg color
                                    selectedColor:
                                        Colors.black, // active bg color
                                    selected:
                                        controller.selectedPropertyType.value ==
                                        type,
                                    onSelected: (_) {
                                      controller.selectedPropertyType.value =
                                          type;
                                    },
                                  );
                                }).toList(),
                              ),
                            ),

                            const SizedBox(height: 10),
                            const Text('ประเภทห้อง'),
                            const SizedBox(height: 10),

                            // room type
                            Obx(
                              () => Wrap(
                                spacing: 10,
                                children: controller.roomType.map((type) {
                                  return ChoiceChip(
                                    showCheckmark: false,
                                    label: Text(type),
                                    labelStyle: TextStyle(
                                      color:
                                          controller.selectedRoomType.value ==
                                              type
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                    elevation: 10,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    backgroundColor: Colors
                                        .grey
                                        .shade200, // unactive bg color
                                    selectedColor:
                                        Colors.black, // active bg color
                                    selected:
                                        controller.selectedRoomType.value ==
                                        type,
                                    onSelected: (_) {
                                      controller.selectedRoomType.value = type;
                                    },
                                  );
                                }).toList(),
                              ),
                            ),

                            const SizedBox(height: 20),

                            TextFormField(
                              autofocus: false,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                              ),
                              decoration: InputDecoration(
                                label: const Text(
                                  'ชื่อประกาศ',
                                  style: TextStyle(fontSize: 12),
                                ),
                                hintStyle: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey.shade400,
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  vertical: 8, // ปรับระยะห่างแนวตั้ง
                                  horizontal: 12, // ปรับระยะห่างแนวนอน
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 1,
                                    color: Colors.grey.shade300,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 1,
                                    color: Colors.grey.shade300,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),

                            const SizedBox(height: 10),

                            Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    autofocus: false,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.black,
                                    ),
                                    decoration: InputDecoration(
                                      label: const Text(
                                        'ขนาดห้อง (ตร.ม.)',
                                        style: TextStyle(fontSize: 12),
                                      ),
                                      hintStyle: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey.shade400,
                                      ),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                            vertical: 8, // ปรับระยะห่างแนวตั้ง
                                            horizontal:
                                                12, // ปรับระยะห่างแนวนอน
                                          ),
                                      filled: true,
                                      fillColor: Colors.white,
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          width: 1,
                                          color: Colors.grey.shade300,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          width: 1,
                                          color: Colors.grey.shade300,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: TextFormField(
                                    autofocus: false,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.black,
                                    ),
                                    decoration: InputDecoration(
                                      label: const Text(
                                        'อยู่ชั้นที่',
                                        style: TextStyle(fontSize: 12),
                                      ),
                                      hintStyle: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey.shade400,
                                      ),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                            vertical: 8, // ปรับระยะห่างแนวตั้ง
                                            horizontal:
                                                12, // ปรับระยะห่างแนวนอน
                                          ),
                                      filled: true,
                                      fillColor: Colors.white,
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          width: 1,
                                          color: Colors.grey.shade300,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          width: 1,
                                          color: Colors.grey.shade300,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 10),

                            Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    autofocus: false,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.black,
                                    ),
                                    decoration: InputDecoration(
                                      label: const Text(
                                        'จำนวนห้องนอน',
                                        style: TextStyle(fontSize: 12),
                                      ),
                                      hintStyle: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey.shade400,
                                      ),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                            vertical: 8, // ปรับระยะห่างแนวตั้ง
                                            horizontal:
                                                12, // ปรับระยะห่างแนวนอน
                                          ),
                                      filled: true,
                                      fillColor: Colors.white,
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          width: 1,
                                          color: Colors.grey.shade300,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          width: 1,
                                          color: Colors.grey.shade300,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: TextFormField(
                                    autofocus: false,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.black,
                                    ),
                                    decoration: InputDecoration(
                                      label: const Text(
                                        'จำนวนห้องน้ำ',
                                        style: TextStyle(fontSize: 12),
                                      ),
                                      hintStyle: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey.shade400,
                                      ),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                            vertical: 8, // ปรับระยะห่างแนวตั้ง
                                            horizontal:
                                                12, // ปรับระยะห่างแนวนอน
                                          ),
                                      filled: true,
                                      fillColor: Colors.white,
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          width: 1,
                                          color: Colors.grey.shade300,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          width: 1,
                                          color: Colors.grey.shade300,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 10),

                            TextFormField(
                              autofocus: false,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                              ),
                              decoration: InputDecoration(
                                label: const Text(
                                  'ตำแหน่ง',
                                  style: TextStyle(fontSize: 12),
                                ),
                                hintStyle: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey.shade400,
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  vertical: 8, // ปรับระยะห่างแนวตั้ง
                                  horizontal: 12, // ปรับระยะห่างแนวนอน
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 1,
                                    color: Colors.grey.shade300,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 1,
                                    color: Colors.grey.shade300,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
