import 'package:flutter/material.dart';

class CreatePropertyScreen extends StatelessWidget {
  const CreatePropertyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(color: Colors.grey.shade200),
              child: Form(
                child: Column(
                  children: [
                    const Text('ลงประกาศ', style: TextStyle(fontSize: 24)),
                    const Text('หมายเหตุ : ประกาศจะต้องรอการอนุมัติจากผู้ดูแล'),
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
