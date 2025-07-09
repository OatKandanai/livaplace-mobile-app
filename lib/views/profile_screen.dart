import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:livaplace_app/controllers/home_controller.dart';
import 'package:livaplace_app/controllers/profile_controller.dart';
import 'package:livaplace_app/routes/app_routes.dart';

class ProfileScreen extends GetView<ProfileController> {
  ProfileScreen({super.key});

  final HomeController _homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
          child: ListView(
            children: [
              // Top Section
              Center(
                child: Column(
                  children: [
                    Obx(
                      () => CircleAvatar(
                        radius: 40,
                        child: ClipOval(
                          child: controller.profilePictureUrl.value.isNotEmpty
                              ? CachedNetworkImage(
                                  imageUrl: controller.profilePictureUrl.value,
                                  fit: BoxFit.contain,
                                  width: 80,
                                  height: 80,
                                  placeholder: (context, url) => const Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      const Center(child: Icon(Icons.error)),
                                )
                              : const Icon(
                                  Icons.person,
                                  size: 50,
                                  color: Colors.grey,
                                ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Obx(
                      () => Text(
                        '${controller.firstName.value} ${controller.lastName.value}',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Obx(
                      () => Text(
                        controller.email.value,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const Divider(height: 40, thickness: 1),

              // Middle Section
              ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: const [
                      BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.08),
                        offset: Offset(0, 8),
                        blurRadius: 20,
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                  child: const Icon(Icons.account_circle),
                ),
                title: const Text(
                  'ข้อมูลของผู้ใช้',
                  style: TextStyle(fontSize: 14),
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  size: 18,
                  color: Colors.grey,
                ),
                onTap: () => Get.toNamed(AppRoutes.editProfile),
              ),
              const SizedBox(height: 10),
              ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: const [
                      BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.08),
                        offset: Offset(0, 8),
                        blurRadius: 20,
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                  child: const Icon(Icons.list_alt),
                ),
                title: const Text(
                  'รายการที่รออนุมัติ',
                  style: TextStyle(fontSize: 14),
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  size: 18,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 10),
              ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: const [
                      BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.08),
                        offset: Offset(0, 8),
                        blurRadius: 20,
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                  child: const Icon(Icons.library_books_sharp),
                ),
                title: const Text(
                  'รายการประกาศของฉัน',
                  style: TextStyle(fontSize: 14),
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  size: 18,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 10),
              ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: const [
                      BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.08),
                        offset: Offset(0, 8),
                        blurRadius: 20,
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                  child: const Icon(Icons.contact_support_rounded),
                ),
                title: const Text('ติดต่อเรา', style: TextStyle(fontSize: 14)),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  size: 18,
                  color: Colors.grey,
                ),
              ),

              const Divider(height: 40, thickness: 1),

              // Bottom Section
              ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: const [
                      BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.08),
                        offset: Offset(0, 8),
                        blurRadius: 20,
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                  child: const Icon(Icons.create),
                ),
                title: const Text(
                  'ลงประกาศเช่า / ขาย',
                  style: TextStyle(fontSize: 14),
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  size: 18,
                  color: Colors.grey,
                ),
                onTap: () async {
                  await Get.toNamed(AppRoutes.create);
                  _homeController.fetchPropertys();
                },
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: controller.logout,
                  child: const Text(
                    'ออกจากระบบ',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
