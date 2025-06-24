import 'package:flutter/material.dart';
import 'package:livaplace_app/screens/login_screen.dart';

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
          child: Center(
            child: SingleChildScrollView(
              child: Form(
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/app_icon_bg_removed.png',
                      width: 150,
                    ),
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
                      decoration: InputDecoration(label: const Text('อีเมล')),
                    ),
                    TextFormField(
                      autofocus: false,
                      decoration: InputDecoration(
                        label: const Text('ชื่อจริง'),
                      ),
                    ),
                    TextFormField(
                      autofocus: false,
                      decoration: InputDecoration(label: const Text('นามสกุล')),
                    ),
                    TextFormField(
                      autofocus: false,
                      decoration: InputDecoration(label: const Text('LINE ID')),
                    ),
                    TextFormField(
                      autofocus: false,
                      decoration: InputDecoration(
                        label: const Text('เบอร์โทรศัพท์'),
                      ),
                    ),
                    TextFormField(
                      autofocus: false,
                      decoration: InputDecoration(
                        label: const Text('รหัสผ่าน'),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text('สมัครสมาชิก'),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const LoginScreen(),
                          ),
                        );
                      },
                      child: RichText(
                        text: TextSpan(
                          style: TextStyle(color: Colors.black),
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
