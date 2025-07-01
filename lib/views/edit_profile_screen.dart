import 'package:cached_network_image/cached_network_image.dart'
    show CachedNetworkImage;
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/utils.dart';

class EditProfileScreen extends StatelessWidget {
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
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 70,
                        child: ClipOval(
                          child: CachedNetworkImage(
                            imageUrl:
                                'https://i.pinimg.com/736x/ac/1c/a1/ac1ca1408e7d9c40b425d83484166178.jpg',
                            fit: BoxFit.contain,
                            width: 135,
                            height: 135,
                            placeholder: (context, url) => const Center(
                              child: CircularProgressIndicator(),
                            ),
                            errorWidget: (context, url, error) =>
                                const Center(child: Icon(Icons.error)),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'เปลี่ยนรูปโปรไฟล์',
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                      const SizedBox(height: 30),
                      SizedBox(
                        height: 45,
                        child: TextFormField(
                          autofocus: false,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                          decoration: _buildInputDecoration(
                            prefixIcon: const Icon(Icons.text_fields),
                            labelText: 'ชื่อจริง',
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        height: 45,
                        child: TextFormField(
                          autofocus: false,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                          decoration: _buildInputDecoration(
                            prefixIcon: const Icon(Icons.text_fields),
                            labelText: 'นามสกุล',
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        height: 45,
                        child: TextFormField(
                          autofocus: false,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                          decoration: _buildInputDecoration(
                            prefixIcon: const Icon(Icons.phone),
                            labelText: 'เบอร์โทร',
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        height: 45,
                        child: TextFormField(
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
                          onPressed: () {},
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
