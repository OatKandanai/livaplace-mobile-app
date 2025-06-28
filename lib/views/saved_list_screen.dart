import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SavedListScreen extends StatefulWidget {
  const SavedListScreen({super.key});

  @override
  State<SavedListScreen> createState() => _SavedListScreenState();
}

class _SavedListScreenState extends State<SavedListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30),
          child: Center(
            child: Column(
              children: [
                RichText(
                  text: TextSpan(
                    style: GoogleFonts.mitr(color: Colors.black),
                    children: const <TextSpan>[
                      TextSpan(
                        text: 'รายการที่บันทึก',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(text: '\u00A0\u00A0'),
                      TextSpan(
                        text: '(5)',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
