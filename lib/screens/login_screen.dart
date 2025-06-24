import 'package:flutter/material.dart';
import 'package:livaplace_app/screens/home_screen.dart';
import 'package:livaplace_app/screens/register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginState();
}

class _LoginState extends State<LoginScreen> {
  late final _formKey;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    _emailController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
  }

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
                      width: 180,
                    ),
                    const Text(
                      'เข้าสู่ระบบ',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text('ผู้ใช้จำเป็นต้องเข้าสู่ระบบเพื่อใช้งาน'),
                    TextFormField(
                      autofocus: false,
                      decoration: InputDecoration(label: const Text('อีเมล')),
                    ),
                    TextFormField(
                      autofocus: false,
                      decoration: InputDecoration(
                        label: const Text('รหัสผ่าน'),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const HomeScreen()),
                        );
                      },
                      child: const Text('เข้าสู่ระบบ'),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const RegisterScreen(),
                          ),
                        );
                      },
                      child: RichText(
                        text: TextSpan(
                          style: TextStyle(color: Colors.black),
                          children: [
                            TextSpan(text: 'ยังไม่มีบัญชี?'),
                            TextSpan(text: '\u00A0\u00A0'),
                            TextSpan(
                              text: 'สมัครสมาชิก',
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
