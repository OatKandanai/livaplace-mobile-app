import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:livaplace_app/controllers/register_controller.dart';

class RegisterScreen extends GetView<RegisterController> {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Form(
                key: controller.formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Column(
                    children: [
                      Image.asset('assets/icon/app_icon.png', width: 150),
                      const Text(
                        'สมัครสมาชิก',
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text('กรุณาสมัครสมาชิกเพื่อเข้าใช้งานแอปพลิเคชัน'),
                      SizedBox(
                        height: 40,
                        child: TextFormField(
                          controller: controller.emailController,
                          autofocus: false,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          style: const TextStyle(fontSize: 14),
                          decoration: _buildInputDecoration(labelText: 'อีเมล'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'กรุณากรอกอีเมล';
                            }
                            if (!GetUtils.isEmail(value)) {
                              return 'รูปแบบอีเมลไม่ถูกต้อง';
                            }
                            return null;
                          },
                        ),
                      ),
                      TextFormField(
                        controller: controller.firstNameController,
                        autofocus: false,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.name,
                        style: const TextStyle(fontSize: 14),
                        decoration: InputDecoration(
                          label: const Text(
                            'ชื่อจริง',
                            style: TextStyle(fontSize: 14),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 1,
                              color: Colors.grey.shade300,
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 1,
                              color: Colors.grey.shade300,
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
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
                      TextFormField(
                        controller: controller.lastNameController,
                        autofocus: false,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.name,
                        style: const TextStyle(fontSize: 14),
                        decoration: const InputDecoration(
                          label: Text(
                            'นามสกุล',
                            style: TextStyle(fontSize: 14),
                          ),
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
                      TextFormField(
                        controller: controller.lineIdController,
                        autofocus: false,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.text,
                        style: const TextStyle(fontSize: 14),
                        decoration: const InputDecoration(
                          label: Text(
                            'LINE ID',
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'กรุณากรอก LINE ID';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: controller.phoneController,
                        autofocus: false,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.phone,
                        style: const TextStyle(fontSize: 14),
                        decoration: const InputDecoration(
                          label: Text(
                            'เบอร์โทรศัพท์',
                            style: TextStyle(fontSize: 14),
                          ),
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
                      TextFormField(
                        controller: controller.passwordController,
                        autofocus: false,
                        obscureText: true,
                        textInputAction: TextInputAction.next,
                        style: const TextStyle(fontSize: 14),
                        decoration: const InputDecoration(
                          label: Text(
                            'รหัสผ่าน',
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'กรุณากรอกรหัสผ่าน';
                          }
                          if (value.length < 6) {
                            return 'รหัสผ่านต้องมีอย่างน้อย 6 ตัวอักษร';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: controller.confirmPasswordController,
                        autofocus: false,
                        obscureText: true,
                        style: const TextStyle(fontSize: 14),
                        decoration: const InputDecoration(
                          label: Text(
                            'ยืนยันรหัสผ่าน',
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'กรุณายืนยันรหัสผ่าน';
                          }
                          if (controller.passwordController.text.trim() !=
                              value.trim()) {
                            return 'รหัสไม่ตรงกัน';
                          }
                          if (value.length < 6) {
                            return 'รหัสผ่านต้องมีอย่างน้อย 6 ตัวอักษร';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: controller.register,
                        child: const Text('สมัครสมาชิก'),
                      ),
                      const SizedBox(height: 20),
                      GestureDetector(
                        onTap: () {
                          Get.back();
                          controller.formKey.currentState!.reset();
                        },
                        child: RichText(
                          text: TextSpan(
                            style: GoogleFonts.mitr(color: Colors.black),
                            children: const [
                              TextSpan(text: 'มีบัญชีอยู่แล้ว?'),
                              TextSpan(text: '\u00A0\u00A0'),
                              TextSpan(
                                text: 'เข้าสู่ระบบ',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
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

  InputDecoration _buildInputDecoration({required String labelText}) {
    return InputDecoration(
      labelText: labelText,
      labelStyle: const TextStyle(fontSize: 14, color: Colors.black),
      contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
      filled: true,
      fillColor: Colors.white,
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(width: 1, color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(10),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(width: 2, color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
