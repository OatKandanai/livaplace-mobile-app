import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:livaplace_app/routes/app_routes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _ItemListState();
}

class _ItemListState extends State<HomeScreen> {
  bool isRentSelected = true;

  final List<Map<String, dynamic>> roomsData = [
    {
      "type": "เช่า",
      "title": "คอนโดพร้อมเข้าอยู่ใจกลางเมือง",
      "location": "อโศก, กรุงเทพมหานคร",
      "bedrooms": 2,
      "bathrooms": 1,
      "price": 25000,
      "priceUnit": "บาท / เดือน",
      "isFavorite": false,
      "image":
          'https://images.unsplash.com/photo-1719884630688-45ca69d68870?q=80&w=1740&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    },
    {
      "type": "ขาย",
      "title": "คอนโดวิวแม่น้ำเจ้าพระยา",
      "location": "บางโพ, กรุงเทพมหานคร",
      "bedrooms": 1,
      "bathrooms": 1,
      "price": 3450000,
      "priceUnit": "บาท",
      "isFavorite": true,
      "image":
          'https://plus.unsplash.com/premium_photo-1681553602523-5dadbbf66fa5?q=80&w=870&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    },
    {
      "type": "เช่า",
      "title": "ห้องพักตกแต่งใหม่ พร้อมเฟอร์นิเจอร์",
      "location": "จตุจักร, กรุงเทพมหานคร",
      "bedrooms": 1,
      "bathrooms": 1,
      "price": 9000,
      "priceUnit": "บาท / เดือน",
      "isFavorite": false,
      "image":
          'https://images.unsplash.com/photo-1622644874224-7bdb61351dca?q=80&w=870&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    },
    {
      "type": "ขาย",
      "title": "คอนโดหรูใจกลางทองหล่อ",
      "location": "ทองหล่อ, กรุงเทพมหานคร",
      "bedrooms": 3,
      "bathrooms": 2,
      "price": 8750000,
      "priceUnit": "บาท",
      "isFavorite": true,
      "image":
          'https://images.unsplash.com/photo-1630699144886-d6d025f5d0f1?q=80&w=1170&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    },
  ];

  Widget _buildTabContent(String type) {
    final List<Map<String, dynamic>> filteredRooms = roomsData
        .where((room) => room['type'] == type)
        .toList();

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            children: [
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
              const SizedBox(height: 20),
              Expanded(
                child: ListView.separated(
                  itemBuilder: (context, index) {
                    return Card(
                      clipBehavior: Clip.antiAlias,
                      child: Row(
                        children: [
                          Expanded(
                            child: CachedNetworkImage(
                              imageUrl: filteredRooms[index]['image'],
                              height: 150,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => const Center(
                                child: CircularProgressIndicator(),
                              ),
                              errorWidget: (context, url, error) =>
                                  const Center(child: Icon(Icons.error)),
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('ประเภท${filteredRooms[index]['type']}'),
                                Text(filteredRooms[index]['title']),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 20),
                  itemCount: filteredRooms.length,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

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
                      _buildTabContent('เช่า'),
                      _buildTabContent('ขาย'),
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
