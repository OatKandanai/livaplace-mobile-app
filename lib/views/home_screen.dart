import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:livaplace_app/controllers/home_controller.dart';
import 'package:livaplace_app/routes/app_routes.dart';
import 'package:livaplace_app/views/property_card.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                const TabBar(
                  labelColor: Colors.black,
                  labelStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  indicator: UnderlineTabIndicator(
                    borderSide: BorderSide(width: 3.0, color: Colors.black),
                    insets: EdgeInsets.symmetric(horizontal: 30),
                  ),
                  tabs: [
                    Tab(text: 'หาเช่า'),
                    Tab(text: 'หาซื้อ'),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      _buildTabContent(propertyType: 'เช่า'),
                      _buildTabContent(propertyType: 'ขาย'),
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

  // each tab
  Widget _buildTabContent({required String propertyType}) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
      child: Center(
        child: Column(
          children: [
            // search bar
            TextField(
              readOnly: true,
              autofocus: false,
              decoration: InputDecoration(
                hint: const Text('ค้นหา'),
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.grey.shade200,
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
              onTap: () {
                Get.toNamed(AppRoutes.searchFilters, arguments: propertyType);
              },
            ),

            const SizedBox(height: 10),

            // card
            Expanded(
              child: Obx(() {
                final List<Map<String, dynamic>> filteredPropertys = controller
                    .propertys
                    .where((item) => item['property_type'] == propertyType)
                    .toList();

                return ListView.separated(
                  itemBuilder: (context, index) {
                    final Map<String, dynamic> property =
                        filteredPropertys[index];
                    final String propertyId = property['id'];
                    final String imageUrl =
                        property['images'][0]; // get only first image
                    final String propertyType = property['property_type'];
                    final String roomType = property['room_type'];
                    final String title = property['title'];
                    final String location = property['location'];
                    final int bedrooms = property['bedrooms'];
                    final int bathrooms = property['bathrooms'];
                    final int price = property['price'];
                    final String priceUnit = property['price_unit'];
                    final DateTime? created = DateTime.tryParse(
                      '${property['created_at']}',
                    );

                    return PropertyCard(
                      propertyId: propertyId,
                      imageUrl: imageUrl,
                      propertyType: propertyType,
                      roomType: roomType,
                      title: title,
                      location: location,
                      bedrooms: bedrooms,
                      bathrooms: bathrooms,
                      price: price,
                      priceUnit: priceUnit,
                      created: created!,
                    );
                  },
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 10),
                  itemCount: filteredPropertys.length,
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
