import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:livaplace_app/routes/app_routes.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SafeArea(
          minimum: const EdgeInsets.symmetric(horizontal: 20),
          child: Center(
            child: SingleChildScrollView(
              child: Form(
                child: Column(
                  children: [
                    Image.asset('assets/icon/app_icon.png', width: 150),
                    const SizedBox(height: 20),
                    const Text(
                      'สมัครสมาชิก',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text('กรุณาสมัครสมาชิกเพื่อเข้าใช้งานแอปพลิเคชัน'),
                    TextFormField(
                      autofocus: false,
                      decoration: const InputDecoration(label: Text('อีเมล')),
                    ),
                    TextFormField(
                      autofocus: false,
                      decoration: const InputDecoration(
                        label: Text('ชื่อจริง'),
                      ),
                    ),
                    TextFormField(
                      autofocus: false,
                      decoration: const InputDecoration(label: Text('นามสกุล')),
                    ),
                    TextFormField(
                      autofocus: false,
                      decoration: const InputDecoration(label: Text('LINE ID')),
                    ),
                    TextFormField(
                      autofocus: false,
                      decoration: const InputDecoration(
                        label: Text('เบอร์โทรศัพท์'),
                      ),
                    ),
                    TextFormField(
                      autofocus: false,
                      decoration: const InputDecoration(
                        label: Text('รหัสผ่าน'),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text('สมัครสมาชิก'),
                    ),
                    GestureDetector(
                      onTap: () => Get.offAllNamed(AppRoutes.login),
                      child: RichText(
                        text: TextSpan(
                          style: GoogleFonts.mitr(color: Colors.black),
                          children: [
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
