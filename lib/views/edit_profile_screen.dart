import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:livaplace_app/controllers/edit_profile_controller.dart';

class EditProfileScreen extends GetView<EditProfileController> {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: FocusScope.of(context).unfocus,
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: Form(
                  key: controller.formkey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    children: [
                      Obx(
                        () => CircleAvatar(
                          radius: 70,
                          backgroundColor: Colors.grey.shade200,
                          child: ClipOval(
                            child: controller.pickedImageFile.value != null
                                ? Image.file(
                                    controller.pickedImageFile.value!,
                                    fit: BoxFit.cover,
                                    width: 140,
                                    height: 140,
                                  )
                                : controller.profileImageUrl.value.isNotEmpty
                                ? CachedNetworkImage(
                                    imageUrl: controller.profileImageUrl.value,
                                    fit: BoxFit.cover,
                                    width: 140,
                                    height: 140,
                                    placeholder: (context, url) => const Center(
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                      ),
                                    ),
                                    errorWidget: (context, url, error) =>
                                        const Center(
                                          child: Icon(
                                            Icons.person,
                                            size: 70,
                                            color: Colors.grey,
                                          ),
                                        ),
                                  )
                                : const Icon(
                                    Icons.person,
                                    size: 70,
                                    color: Colors.grey,
                                  ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextButton.icon(
                        onPressed: controller.pickImage,
                        icon: const Icon(
                          Icons.photo_library,
                          color: Colors.blueGrey,
                        ),
                        label: const Text(
                          'อัพโหลดรูปภาพ',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: BorderSide(color: Colors.grey.shade300),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      SizedBox(
                        height: 45,
                        child: TextFormField(
                          controller: controller.firstNameController,
                          autofocus: false,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                          decoration: _buildInputDecoration(
                            prefixIcon: const Icon(Icons.text_fields),
                            labelText: 'ชื่อจริง',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'กรุณากรอกชื่อจริง';
                            }
                            if (value.length < 4) {
                              return 'ชื่อจริงต้องมีอย่างน้อย 4 ตัวอักษร';
                            }
                            if (!RegExp(r'^[a-zA-Z\sก-ฮ]+$').hasMatch(value)) {
                              return 'ชื่อจริงต้องเป็นตัวอักษรเท่านั้น';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        height: 45,
                        child: TextFormField(
                          controller: controller.lastNameController,
                          autofocus: false,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                          decoration: _buildInputDecoration(
                            prefixIcon: const Icon(Icons.text_fields),
                            labelText: 'นามสกุล',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'กรุณากรอกนามสกุล';
                            }
                            if (value.length < 4) {
                              return 'นามสกุลต้องมีอย่างน้อย 4 ตัวอักษร';
                            }
                            if (!RegExp(r'^[a-zA-Z\sก-ฮ]+$').hasMatch(value)) {
                              return 'นามสกุลต้องเป็นตัวอักษรเท่านั้น';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        height: 45,
                        child: TextFormField(
                          controller: controller.phoneController,
                          autofocus: false,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                          decoration: _buildInputDecoration(
                            prefixIcon: const Icon(Icons.phone),
                            labelText: 'เบอร์โทร',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'กรุณากรอกเบอร์โทรศัพท์';
                            }
                            final thaiPhoneRegex = RegExp(r'^0[689][0-9]{8}$');
                            if (!thaiPhoneRegex.hasMatch(value)) {
                              return 'รูปแบบเบอร์โทรศัพท์ไม่ถูกต้อง (เช่น 0812345678)';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        height: 45,
                        child: TextFormField(
                          controller: controller.lineIdController,
                          autofocus: false,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                          decoration: InputDecoration(
                            prefixIcon: Image.asset(
                              'assets/icon/line_icon.png',
                              fit: BoxFit.contain,
                            ),
                            hintText: 'LINE ID',
                            hintStyle: const TextStyle(fontSize: 14),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 1,
                                color: Colors.grey.shade400,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 1,
                                color: Colors.grey.shade400,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'กรุณาใส่ LINE ID';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: controller.editProfile,
                          child: const Text('บันทึก'),
                        ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: () {
                            FocusScope.of(context).unfocus();
                            Get.back();
                          },
                          child: const Text('ยกเลิก'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration _buildInputDecoration({
    required Widget prefixIcon,
    required String labelText,
  }) {
    return InputDecoration(
      prefixIcon: prefixIcon,
      label: Text(labelText),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(width: 1, color: Colors.grey.shade400),
        borderRadius: BorderRadius.circular(10),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(width: 1, color: Colors.grey.shade400),
        borderRadius: BorderRadius.circular(10),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(width: 1, color: Colors.grey.shade400),
        borderRadius: BorderRadius.circular(10),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(width: 1, color: Colors.grey.shade400),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
