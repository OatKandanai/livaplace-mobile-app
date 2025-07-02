import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:livaplace_app/routes/app_routes.dart';
import 'package:livaplace_app/views/property_card.dart';

class SearchResultScreen extends StatefulWidget {
  const SearchResultScreen({super.key});

  @override
  State<SearchResultScreen> createState() => _SearchResultScreenState();
}

class _SearchResultScreenState extends State<SearchResultScreen> {
  final List<Map<String, dynamic>> searchResult = [
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
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: FocusScope.of(context).unfocus,
      child: Scaffold(
        body: SafeArea(
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
                      prefixIcon: GestureDetector(
                        onTap: () => Get.offAllNamed(AppRoutes.home),
                        child: const Icon(Icons.arrow_back_ios, size: 30),
                      ),
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
                  RichText(
                    text: TextSpan(
                      style: GoogleFonts.mitr(color: Colors.black),
                      children: <TextSpan>[
                        const TextSpan(
                          text: 'ผลการค้นหา',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const TextSpan(text: '\u00A0\u00A0'),
                        TextSpan(
                          text: '(${searchResult.length})',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),

                  // card
                  Expanded(
                    child: ListView.separated(
                      itemBuilder: (context, index) {
                        final Map<String, dynamic> result = searchResult[index];
                        final String imageUrl = result['image'];
                        final String propertyType = result['propertyType'];
                        final String roomType = result['roomType'];
                        final String title = result['title'];
                        final String location = result['location'];
                        final int bedrooms = result['bedrooms'];
                        final int bathrooms = result['bathrooms'];
                        final int price = result['price'];
                        final String priceUnit = result['priceUnit'];
                        final bool isFavorite = result['isFavorite'];
                        final String created = result['created'];

                        return SizedBox();
                        // return PropertyCard(
                        //   imageUrl: imageUrl,
                        //   propertyType: propertyType,
                        //   roomType: roomType,
                        //   title: title,
                        //   location: location,
                        //   bedrooms: bedrooms,
                        //   bathrooms: bathrooms,
                        //   price: price,
                        //   priceUnit: priceUnit,
                        //   isFavorite: isFavorite,
                        //   created: created!,
                        // );
                      },
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 10),
                      itemCount: searchResult.length,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
