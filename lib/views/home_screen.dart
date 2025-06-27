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
  final List<Map<String, dynamic>> roomsData = [
    {
      "type": "เช่า",
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
      "type": "ขาย",
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
      "type": "เช่า",
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
      "type": "ขาย",
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
      "type": "เช่า",
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
                    final String imageUrl = filteredRooms[index]['image'];
                    final String type = filteredRooms[index]['type'];
                    final String roomType = filteredRooms[index]['roomType'];
                    final String title = filteredRooms[index]['title'];
                    final int bedrooms = filteredRooms[index]['bedrooms'];
                    final int bathrooms = filteredRooms[index]['bathrooms'];
                    final int price = filteredRooms[index]['price'];
                    final String priceUnit = filteredRooms[index]['priceUnit'];
                    final bool isFavorite = filteredRooms[index]['isFavorite'];
                    final String created = filteredRooms[index]['created'];

                    return Stack(
                      children: [
                        Card(
                          clipBehavior: Clip.antiAlias,
                          elevation: 2,
                          child: Row(
                            children: [
                              // image
                              Expanded(
                                flex: 1,
                                child: CachedNetworkImage(
                                  imageUrl: imageUrl,
                                  height: 220,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) => const Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      const Center(child: Icon(Icons.error)),
                                ),
                              ),

                              // information
                              Expanded(
                                flex: 2,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                  ),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.check,
                                            size: 20,
                                            color: Colors.green,
                                          ),
                                          const SizedBox(width: 5),
                                          Text(
                                            'ประเภท$type,',
                                            style: const TextStyle(
                                              fontSize: 12,
                                            ),
                                          ),
                                          const SizedBox(width: 5),
                                          const Icon(
                                            Icons.home_work,
                                            size: 18,
                                            color: Colors.blueAccent,
                                          ),
                                          const SizedBox(width: 5),
                                          Text(
                                            roomType,
                                            style: const TextStyle(
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        title,
                                        style: const TextStyle(fontSize: 14),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.location_on,
                                            size: 20,
                                            color: Colors.blueAccent,
                                          ),
                                          const SizedBox(width: 5),
                                          Text(
                                            filteredRooms[index]['location'],
                                            style: const TextStyle(
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.bed_outlined,
                                            size: 20,
                                          ),
                                          const SizedBox(width: 3),
                                          Text(
                                            '$bedrooms ห้องนอน',
                                            style: const TextStyle(
                                              fontSize: 12,
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          const Icon(
                                            Icons.bathtub_outlined,
                                            size: 20,
                                          ),
                                          const SizedBox(width: 3),
                                          Text(
                                            '$bathrooms ห้องนอน',
                                            style: const TextStyle(
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 16),
                                      Text(
                                        '$price $priceUnit',
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                      const SizedBox(height: 4),
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.access_time_filled,
                                            color: Colors.blueGrey,
                                            size: 20,
                                          ),
                                          const SizedBox(width: 3),
                                          Text(
                                            'ประกาศเมื่อ $created',
                                            style: const TextStyle(
                                              fontSize: 10,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          bottom: 5,
                          right: 5,
                          child: IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.favorite,
                              size: 22,
                              color: isFavorite
                                  ? Colors.redAccent
                                  : Colors.grey,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 10),
                  itemCount: filteredRooms.length,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
