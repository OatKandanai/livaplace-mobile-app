import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:livaplace_app/controllers/bottom_nav_controller.dart';
import 'package:livaplace_app/views/home_screen.dart';

class BottomNav extends StatelessWidget {
  BottomNav({super.key});

  final List<Widget> pages = [
    const HomeScreen(),
    const Center(child: Text("ยังไม่เสร็จ")),
  ];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BottomNavController>(
      init: BottomNavController(),
      builder: (controller) {
        return Scaffold(
          body: pages[controller.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: controller.currentIndex,
            onTap: controller.changeTab,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'หน้าแรก'),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                label: 'บันทึก',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.account_circle),
                label: 'โปรไฟล์',
              ),
            ],
          ),
        );
      },
    );
  }
}
