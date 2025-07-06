import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:livaplace_app/controllers/saved_list_controller.dart';

class SavedListScreen extends GetView<SavedListController> {
  const SavedListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: RichText(
          text: TextSpan(
            style: GoogleFonts.mitr(color: Colors.black),
            children: const <TextSpan>[
              TextSpan(
                text: 'รายการที่บันทึก',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              TextSpan(text: '\u00A0\u00A0'),
              TextSpan(
                text: '(0)',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30),
        child: Center(child: Column(children: [const Text('text')])),
      ),
    );
  }
}
