import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:livaplace_app/controllers/edit_property_controller.dart';

class EditPropertyScreen extends GetView<EditPropertyController> {
  const EditPropertyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: FocusScope.of(context).unfocus,
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 10,
                right: 10,
                top: 30,
                bottom: 20,
              ),
              child: Center(
                child: Column(
                  children: [
                    const Text('แก้ไขประกาศ', style: TextStyle(fontSize: 24)),
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Form(
                        key: controller.formKey,
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
                              controller: controller.titleController,
                              autofocus: false,
                              maxLength: 60,
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.next,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                              ),
                              decoration: _buildInputDecoration(
                                labelText: 'ชื่อประกาศ',
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'กรุณากรอกชื่อประกาศ';
                                }
                                return null;
                              },
                            ),

                            const SizedBox(height: 20),

                            // area and floor number
                            Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    controller: controller.areaController,
                                    autofocus: false,
                                    maxLength: 3,
                                    keyboardType: TextInputType.number,
                                    textInputAction: TextInputAction.next,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly,
                                    ],
                                    buildCounter:
                                        (
                                          _, {
                                          required currentLength,
                                          required isFocused,
                                          maxLength,
                                        }) => null,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.black,
                                    ),
                                    decoration: _buildInputDecoration(
                                      labelText: 'ขนาดห้อง (ตร.ม.)',
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'กรุณากรอกขนาด';
                                      }
                                      if (int.tryParse(value) == null) {
                                        return 'เป็นตัวเลขเท่านั้น';
                                      }
                                      if (int.parse(value) <= 0) {
                                        return 'ต้องมากกว่า 0';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: TextFormField(
                                    controller: controller.floorController,
                                    autofocus: false,
                                    maxLength: 3,
                                    keyboardType: TextInputType.number,
                                    textInputAction: TextInputAction.next,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly,
                                    ],
                                    buildCounter:
                                        (
                                          _, {
                                          required currentLength,
                                          required isFocused,
                                          maxLength,
                                        }) => null,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.black,
                                    ),
                                    decoration: _buildInputDecoration(
                                      labelText: 'อยู่ชั้นที่',
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'กรุณากรอกชั้น';
                                      }
                                      if (int.tryParse(value) == null) {
                                        return 'เป็นตัวเลขเท่านั้น';
                                      }
                                      if (int.parse(value) <= 0) {
                                        return 'ต้องมากกว่า 0';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 20),

                            // bedrooms and bathrooms
                            Row(
                              children: [
                                Expanded(
                                  child: Obx(
                                    () => DropdownButtonFormField(
                                      decoration: _buildInputDecoration(
                                        labelText: 'จำนวนห้องนอน',
                                      ),
                                      value: controller.bedroomCount.value,
                                      items: List.generate(
                                        20,
                                        (index) => DropdownMenuItem(
                                          value: index + 1,
                                          child: Text(
                                            '${index + 1} ห้องนอน',
                                            style: const TextStyle(
                                              fontSize: 12,
                                            ),
                                          ),
                                        ),
                                      ),
                                      onChanged: (value) {
                                        if (value != null) {
                                          controller.bedroomCount.value = value;
                                        }
                                      },
                                      validator: (value) {
                                        if (value == null || value <= 0) {
                                          return 'กรุณาเลือกจำนวนห้องนอน';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Obx(
                                    () => DropdownButtonFormField(
                                      decoration: _buildInputDecoration(
                                        labelText: 'จำนวนห้องน้ำ',
                                      ),
                                      value: controller.bathroomCount.value,
                                      items: List.generate(
                                        20,
                                        (index) => DropdownMenuItem(
                                          value: index + 1,
                                          child: Text(
                                            '${index + 1} ห้องน้ำ',
                                            style: const TextStyle(
                                              fontSize: 12,
                                            ),
                                          ),
                                        ),
                                      ),
                                      onChanged: (value) {
                                        if (value != null) {
                                          controller.bathroomCount.value =
                                              value;
                                        }
                                      },
                                      validator: (value) {
                                        if (value == null || value <= 0) {
                                          return 'กรุณาเลือกจำนวนห้องน้ำ';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 20),

                            // price
                            Row(
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: TextFormField(
                                    controller: controller.priceController,
                                    autofocus: false,
                                    maxLength: 9,
                                    keyboardType: TextInputType.number,
                                    textInputAction: TextInputAction.next,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly,
                                    ],
                                    buildCounter:
                                        (
                                          _, {
                                          required currentLength,
                                          required isFocused,
                                          maxLength,
                                        }) => null,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.black,
                                    ),
                                    decoration: _buildInputDecoration(
                                      labelText: 'ราคา',
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'กรุณากรอกราคา';
                                      }
                                      if (int.tryParse(value) == null) {
                                        return 'เป็นตัวเลขเท่านั้น';
                                      }
                                      if (int.parse(value) <= 0) {
                                        return 'ต้องมากกว่า 0';
                                      }
                                      return null;
                                    },
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
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 20),

                            // detail
                            TextFormField(
                              controller: controller.detailController,
                              autofocus: false,
                              maxLines: 5,
                              maxLength: 300,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                              ),
                              decoration: _buildInputDecoration(
                                labelText: 'รายละเอียดเพิ่มเติม',
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'กรุณากรอกรายละเอียด';
                                }
                                return null;
                              },
                            ),

                            const SizedBox(height: 10),

                            // location
                            TextFormField(
                              controller: controller.locationController,
                              autofocus: false,
                              maxLength: 60,
                              maxLines: 1,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                              ),
                              decoration: _buildInputDecoration(
                                labelText: 'ตำแหน่ง',
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'กรุณากรอกตำแหน่ง';
                                }
                                return null;
                              },
                            ),

                            const SizedBox(height: 10),
                            const Text('สิ่งอำนวยความสะดวก'),
                            const SizedBox(height: 10),

                            // facilities
                            Obx(
                              () => Wrap(
                                spacing: 10,
                                runSpacing: 10,
                                children: controller.facilities.map((facility) {
                                  final bool isSelected = controller
                                      .selectedFacilities
                                      .contains(facility);

                                  return FilterChip(
                                    showCheckmark: false,
                                    label: Text(facility),
                                    labelStyle: TextStyle(
                                      color: isSelected
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                    elevation: 10,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    backgroundColor:
                                        Colors.white, // unactive bg color
                                    selectedColor:
                                        Colors.black, // active bg color
                                    selected: isSelected,
                                    onSelected: (bool selected) {
                                      if (selected) {
                                        controller.selectedFacilities.add(
                                          facility,
                                        );
                                      } else {
                                        controller.selectedFacilities.remove(
                                          facility,
                                        );
                                      }
                                    },
                                  );
                                }).toList(),
                              ),
                            ),

                            // const SizedBox(height: 20),
                            // const Text('รูปภาพทรัพย์สิน'),
                            // const SizedBox(height: 10),

                            // // Image Picker Button
                            // ElevatedButton.icon(
                            //   onPressed: controller.pickImages,
                            //   icon: const Icon(Icons.add_a_photo),
                            //   label: const Text('เลือกรูปภาพ'),
                            //   style: ElevatedButton.styleFrom(
                            //     backgroundColor: Colors.black,
                            //     foregroundColor: Colors.white,
                            //     shape: RoundedRectangleBorder(
                            //       borderRadius: BorderRadius.circular(10),
                            //     ),
                            //   ),
                            // ),

                            // const SizedBox(height: 10),

                            // // image display
                            // Obx(
                            //   () => controller.selectedLocalImages.isEmpty
                            //       ? const Text('ยังไม่มีรูปภาพที่เลือก')
                            //       : GridView.builder(
                            //           shrinkWrap: true,
                            //           physics:
                            //               const NeverScrollableScrollPhysics(),
                            //           gridDelegate:
                            //               const SliverGridDelegateWithFixedCrossAxisCount(
                            //                 crossAxisCount: 3,
                            //                 crossAxisSpacing: 8,
                            //                 mainAxisSpacing: 8,
                            //               ),
                            //           itemCount:
                            //               controller.selectedLocalImages.length,
                            //           itemBuilder: (context, index) {
                            //             final image = controller
                            //                 .selectedLocalImages[index];

                            //             return Stack(
                            //               children: [
                            //                 Image.file(
                            //                   File(image.path),
                            //                   fit: BoxFit.cover,
                            //                   width: double.infinity,
                            //                   height: double.infinity,
                            //                 ),
                            //                 Positioned(
                            //                   top: 0,
                            //                   right: 0,
                            //                   child: GestureDetector(
                            //                     onTap: () => controller
                            //                         .selectedLocalImages
                            //                         .removeAt(index),
                            //                     child: Container(
                            //                       color: Colors.black54,
                            //                       padding: const EdgeInsets.all(
                            //                         4,
                            //                       ),
                            //                       child: const Icon(
                            //                         Icons.close,
                            //                         color: Colors.white,
                            //                         size: 18,
                            //                       ),
                            //                     ),
                            //                   ),
                            //                 ),
                            //               ],
                            //             );
                            //           },
                            //         ),
                            // ),
                            const SizedBox(height: 20),

                            // button group
                            Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.black,
                                      foregroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    onPressed: () {
                                      FocusScope.of(context).unfocus();
                                      controller.updateProperty();
                                    },
                                    child: const Text(
                                      'แก้ไขประกาศ',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.black,
                                      foregroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    onPressed: () {
                                      FocusScope.of(context).unfocus();
                                      Get.back();
                                    },
                                    child: const Text(
                                      'ยกเลิก',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 20),
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
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(width: 1, color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(10),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(width: 1, color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
