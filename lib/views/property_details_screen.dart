import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';

class PropertyDetailsScreen extends StatelessWidget {
  const PropertyDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> images = [
      'https://images.unsplash.com/photo-1594873604892-b599f847e859?q=80&w=687&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      'https://images.unsplash.com/photo-1704040686413-2c607dbd2f06?q=80&w=1740&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      'https://images.unsplash.com/photo-1628744876497-eb30460be9f6?q=80&w=1740&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    ];

    Map<String, dynamic> property = {
      "propertyType": "เช่า",
      "roomType": "คอนโด",
      "title":
          "คอนโดพร้อมเข้าอยู่ใจกลางเมืองงงงงงงงงงงงงงงงงงงงงงงงงงงงงงงงงงงง",
      "location": "อโศก, กรุงเทพมหานคร",
      "bedrooms": 2,
      "bathrooms": 1,
      "area": 35,
      "floor": 7,
      "price": 25000,
      "priceUnit": "บาท / เดือน",
      "isFavorite": false,
      "image":
          'https://images.unsplash.com/photo-1719884630688-45ca69d68870?q=80&w=1740&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      "facilities": [
        {
          "ฟิตเนส": true,
          "ครัว": true,
          "ที่จอดรถ": true,
          "wifi": true,
          "เลี้ยงสัตว์ได้": true,
          "สระว่ายน้ำ": true,
          "เฟอร์นิเจอร์": true,
          "เครื่องปรับอากาศ": true,
          "เครื่องซักผ้า": true,
          "ระเบียง": true,
        },
      ],
      "details":
          "ตกแต่งครบ พร้อมเฟอร์นิเจอร์และเครื่องใช้ไฟฟ้า (แอร์, ทีวี, ตู้เย็น, ไมโครเวฟ)",
      "created_by": "lisa",
      "created_at": "27/06/2025",
    };

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Container(
                height: 300,
                color: Colors.grey.shade200,
                child: Swiper(
                  pagination: const SwiperPagination(),
                  control: const SwiperControl(size: 30),
                  itemCount: images.length,
                  itemBuilder: (context, index) {
                    return CachedNetworkImage(
                      imageUrl: images[index],
                      placeholder: (context, url) =>
                          const Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) =>
                          const Center(child: Icon(Icons.error)),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
