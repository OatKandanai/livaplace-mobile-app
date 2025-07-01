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

                            // title
                            TextFormField(
                              autofocus: false,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                              ),
                              decoration: _buildInputDecoration(
                                labelText: 'ชื่อประกาศ',
                              ),
                            ),

                            const SizedBox(height: 10),

                            // area and floor number
                            Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    autofocus: false,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.black,
                                    ),
                                    decoration: _buildInputDecoration(
                                      labelText: 'ขนาดห้อง (ตร.ม.)',
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
                                    decoration: _buildInputDecoration(
                                      labelText: 'อยู่ชั้นที่',
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 10),

                            // bedrooms and bathrooms
                            Row(
                              children: [
                                Expanded(
                                  child: DropdownButtonFormField(
                                    items: items,
                                    onChanged: onChanged,
                                  ),
                                ),

                                Expanded(
                                  child: DropdownButtonFormField(
                                    items: items,
                                    onChanged: onChanged,
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 10),

                            // price
                            Row(
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: TextFormField(
                                    autofocus: false,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.black,
                                    ),
                                    decoration: _buildInputDecoration(
                                      labelText: 'ราคา',
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  flex: 1,
                                  child: Obx(
                                    () => Text(
                                      controller.selectedPropertyType.value ==
                                              'เช่า'
                                          ? 'บาท / เดือน'
                                          : 'บาท',
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 10),

                            // location
                            TextFormField(
                              autofocus: false,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                              ),
                              decoration: _buildInputDecoration(
                                labelText: 'ตำแหน่ง',
                              ),
                            ),

                            const SizedBox(height: 10),
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

  InputDecoration _buildInputDecoration({required String labelText}) {
    return InputDecoration(
      label: Text(labelText, style: const TextStyle(fontSize: 12)),
      hintStyle: TextStyle(fontSize: 12, color: Colors.grey.shade400),
      contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      filled: true,
      fillColor: Colors.white,
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(width: 1, color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(10),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(width: 1, color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
