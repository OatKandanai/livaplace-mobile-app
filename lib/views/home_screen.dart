import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:livaplace_app/routes/app_routes.dart';
import 'package:livaplace_app/views/property_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _ItemListState();
}

class _ItemListState extends State<HomeScreen> {
  final List<Map<String, dynamic>> propertyData = [
    {
      "propertyType": "เช่า",
      "roomType": "คอนโด",
      "title":
          "คอนโดพร้อมเข้าอยู่ใจกลางเมืองงงงงงงงงงงงงงงงงงงงงงงงงงงงงงงงงงงง",
      "location": "อโศก, กรุงเทพมหานคร",
      "bedrooms": 2,
      "bathrooms": 1,
      "price": 25000,
      "priceUnit": "บาท / เดือน",
      "isFavorite": false,
      "image":
          'https://images.unsplash.com/photo-1719884630688-45ca69d68870?q=80&w=1740&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      "created": "27/06/2025",
    },
    {
      "propertyType": "ขาย",
      "roomType": "คอนโด",
      "title": "คอนโดวิวแม่น้ำเจ้าพระยา",
      "location": "บางโพ, กรุงเทพมหานคร",
      "bedrooms": 1,
      "bathrooms": 1,
      "price": 3450000,
      "priceUnit": "บาท",
      "isFavorite": true,
      "image":
          'https://plus.unsplash.com/premium_photo-1681553602523-5dadbbf66fa5?q=80&w=870&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      "created": "27/06/2025",
    },
    {
      "propertyType": "เช่า",
      "roomType": "หอพัก",
      "title": "ห้องพักตกแต่งใหม่ พร้อมเฟอร์นิเจอร์",
      "location": "จตุจักร, กรุงเทพมหานคร",
      "bedrooms": 1,
      "bathrooms": 1,
      "price": 9000,
      "priceUnit": "บาท / เดือน",
      "isFavorite": false,
      "image":
          'https://images.unsplash.com/photo-1622644874224-7bdb61351dca?q=80&w=870&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      "created": "27/06/2025",
    },
    {
      "propertyType": "ขาย",
      "roomType": "คอนโด",
      "title": "คอนโดหรูใจกลางทองหล่อ",
      "location": "ทองหล่อ, กรุงเทพมหานคร",
      "bedrooms": 3,
      "bathrooms": 2,
      "price": 8750000,
      "priceUnit": "บาท",
      "isFavorite": true,
      "image":
          'https://images.unsplash.com/photo-1630699144886-d6d025f5d0f1?q=80&w=1170&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      "created": "27/06/2025",
    },
    {
      "propertyType": "เช่า",
      "roomType": "อพาร์ตเมนต์",
      "title": "อพาร์ตเมนต์ใกล้ BTS พร้อมอยู่ ราคาประหยัด",
      "location": "ลาดพร้าว, กรุงเทพมหานคร",
      "bedrooms": 1,
      "bathrooms": 1,
      "price": 6500,
      "priceUnit": "บาท / เดือน",
      "isFavorite": false,
      "image":
          'https://images.unsplash.com/photo-1600585154340-be6161a56a0c?q=80&w=1170&auto=format&fit=crop&ixlib=rb-4.1.0',
      "created": "27/06/2025",
    },
  ];

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
    final List<Map<String, dynamic>> filteredPropertys = propertyData
        .where((item) => item['propertyType'] == propertyType)
        .toList();

    return Padding(
      padding: const EdgeInsets.all(20),
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
                Get.toNamed(AppRoutes.searchFilters);
              },
            ),

            const SizedBox(height: 10),

            // card
            Expanded(
              child: ListView.separated(
                itemBuilder: (context, index) {
                  final Map<String, dynamic> property =
                      filteredPropertys[index];
                  final String imageUrl = property['image'];
                  final String propertyType = property['propertyType'];
                  final String roomType = property['roomType'];
                  final String title = property['title'];
                  final String location = property['location'];
                  final int bedrooms = property['bedrooms'];
                  final int bathrooms = property['bathrooms'];
                  final int price = property['price'];
                  final String priceUnit = property['priceUnit'];
                  final bool isFavorite = property['isFavorite'];
                  final String created = property['created'];

                  return PropertyCard(
                    imageUrl: imageUrl,
                    propertyType: propertyType,
                    roomType: roomType,
                    title: title,
                    location: location,
                    bedrooms: bedrooms,
                    bathrooms: bathrooms,
                    price: price,
                    priceUnit: priceUnit,
                    isFavorite: isFavorite,
                    created: created,
                  );
                },
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 10),
                itemCount: filteredPropertys.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
