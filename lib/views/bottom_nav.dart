import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:livaplace_app/controllers/bottom_nav_controller.dart';
import 'package:livaplace_app/views/home_screen.dart';
import 'package:livaplace_app/views/profile_screen.dart';
import 'package:livaplace_app/views/saved_list_screen.dart';

class BottomNav extends StatelessWidget {
  BottomNav({super.key});

  // apply bottom nav bar to these screens
  final List<Widget> pages = [HomeScreen(), SavedListScreen(), ProfileScreen()];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BottomNavController>(
      init: BottomNavController(),
      builder: (controller) {
        return Scaffold(
          body: pages[controller.currentIndex], // screen to show
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: controller.currentIndex,
            onTap: controller.changeTab,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'หน้าแรก'),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                label: 'รายการที่บันทึก',
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
