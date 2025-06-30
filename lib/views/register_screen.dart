import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  late final GlobalKey<FormState> _formKey;
  late final TextEditingController _emailController;
  late final TextEditingController _firstNameController;
  late final TextEditingController _lastNameController;
  late final TextEditingController _lineIdController;
  late final TextEditingController _phoneController;
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmPasswordController;
  late final FirebaseAuth _auth;
  late final CollectionReference<Map<String, dynamic>> _users;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    _emailController = TextEditingController();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _lineIdController = TextEditingController();
    _phoneController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    _auth = FirebaseAuth.instance;
    _users = FirebaseFirestore.instance.collection('users');
  }

  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) {
      Get.snackbar(
        'ข้อมูลไม่ครบถ้วน',
        'โปรดกรอกข้อมูลให้ถูกต้องและครบถ้วน',
        snackPosition: SnackPosition.BOTTOM,
        colorText: Colors.black,
      );
      return;
    }

    String email = _emailController.text.trim();
    String firstName = _firstNameController.text.trim();
    String lastName = _lastNameController.text.trim();
    String lineId = _lineIdController.text.trim();
    String phone = _phoneController.text.trim();
    String password = _passwordController.text.trim();
    String confirmPassword = _confirmPasswordController.text.trim();

    Get.dialog(
      const Center(child: CircularProgressIndicator()),
      barrierDismissible: false,
    );

    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      if (userCredential.user != null) {
        await _users.doc(userCredential.user!.uid).set({
          'email': email,
          'first_name': firstName,
          'last_name': lastName,
          'line_id': lineId,
          'phone': phone,
          'password': password,
          'created_at': Timestamp.now(),
        });

        Get.back();
        Get.snackbar(
          'สมัครสมาชิกสำเร็จ',
          'เข้าสู่ระบบอัตโนมัติ',
          snackPosition: SnackPosition.TOP,
        );

        Get.offAllNamed(AppRoutes.login);
      }
    } catch (e) {
      Get.back();
      Get.snackbar(
        'เกิดข้อผิดพลาด',
        'ไม่สามารถสมัครสมาชิกได้',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  @override
  void dispose() {
    _emailController.clear();
    _firstNameController.clear();
    _lastNameController.clear();
    _lineIdController.clear();
    _phoneController.clear();
    _passwordController.clear();
    super.dispose();
  }

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
                key: _formKey,
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
                      controller: _emailController,
                      autofocus: false,
                      decoration: const InputDecoration(label: Text('อีเมล')),
                      validator: (value) {
                        if (value != null || value!.isEmpty) {
                          return 'จำเป็นต้องกรอกข้อมูล';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _firstNameController,
                      autofocus: false,
                      decoration: const InputDecoration(
                        label: Text('ชื่อจริง'),
                      ),
                      validator: (value) {
                        if (value != null || value!.isEmpty) {
                          return 'จำเป็นต้องกรอกข้อมูล';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _lastNameController,
                      autofocus: false,
                      decoration: const InputDecoration(label: Text('นามสกุล')),
                      validator: (value) {
                        if (value != null || value!.isEmpty) {
                          return 'จำเป็นต้องกรอกข้อมูล';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _lineIdController,
                      autofocus: false,
                      decoration: const InputDecoration(label: Text('LINE ID')),
                      validator: (value) {
                        if (value != null || value!.isEmpty) {
                          return 'จำเป็นต้องกรอกข้อมูล';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _phoneController,
                      autofocus: false,
                      decoration: const InputDecoration(
                        label: Text('เบอร์โทรศัพท์'),
                      ),
                      validator: (value) {
                        if (value != null || value!.isEmpty) {
                          return 'จำเป็นต้องกรอกข้อมูล';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _passwordController,
                      autofocus: false,
                      decoration: const InputDecoration(
                        label: Text('รหัสผ่าน'),
                      ),
                      validator: (value) {
                        if (value != null || value!.isEmpty) {
                          return 'จำเป็นต้องกรอกข้อมูล';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _confirmPasswordController,
                      autofocus: false,
                      decoration: const InputDecoration(
                        label: Text('ยืนยันรหัสผ่าน'),
                      ),
                      validator: (value) {
                        if (value != null || value!.isEmpty) {
                          return 'จำเป็นต้องกรอกข้อมูล';
                        }
                        return null;
                      },
                    ),
                    ElevatedButton(
                      onPressed: _register,
                      child: const Text('สมัครสมาชิก'),
                    ),
                    GestureDetector(
                      onTap: () => Get.offAllNamed(AppRoutes.login),
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
