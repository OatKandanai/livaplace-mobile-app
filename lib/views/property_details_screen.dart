import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:get/route_manager.dart';
import 'package:get/state_manager.dart';
import 'package:livaplace_app/controllers/property_details_controller.dart';

class PropertyDetailsScreen extends GetView<PropertyDetailsController> {
  const PropertyDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> property = {
      "propertyType": "เช่า",
      "roomType": "คอนโด",
      "title": "คอนโดพร้อมเข้าอยู่ใจกลางเมือง",
      "location": "อโศก, กรุงเทพมหานคร",
      "bedrooms": 2,
      "bathrooms": 1,
      "area": 35,
      "floor": 7,
      "price": 25000,
      "priceUnit": "บาท / เดือน",
      "isFavorite": false,
      "images": [
        'https://images.unsplash.com/photo-1594873604892-b599f847e859?q=80&w=687&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
        'https://images.unsplash.com/photo-1704040686413-2c607dbd2f06?q=80&w=1740&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
        'https://images.unsplash.com/photo-1628744876497-eb30460be9f6?q=80&w=1740&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      ],
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
      "detail":
          "ห้องขนาด 35 ตร.ม. ชั้น 7 ตกแต่งครบพร้อมเฟอร์นิเจอร์และเครื่องใช้ไฟฟ้า เช่น แอร์ ทีวี ตู้เย็น ไมโครเวฟ เครื่องซักผ้า และเครื่องทำน้ำอุ่น ครัวแยกเป็นสัดส่วน มีระเบียงรับลม วิวโล่งไม่บัง ใกล้ BTS อโศก และ MRT สุขุมวิท เดินทางสะดวก พร้อมสิ่งอำนวยความสะดวกในโครงการ เช่น ฟิตเนส สระว่ายน้ำ และที่จอดรถ",
      "createdBy": "Lisa",
      "createdAt": "27/06/2025",
    };

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // IMAGE SECTION
              Stack(
                children: [
                  // image swiper
                  Container(
                    height: 300,
                    color: Colors.grey.shade200,
                    child: Swiper(
                      pagination: const SwiperPagination(),
                      itemCount: property['images'].length,
                      itemBuilder: (context, index) {
                        return CachedNetworkImage(
                          imageUrl: property['images'][index],
                          fit: BoxFit.fitHeight,
                          placeholder: (context, url) =>
                              const Center(child: CircularProgressIndicator()),
                          errorWidget: (context, url, error) =>
                              const Center(child: Icon(Icons.error)),
                        );
                      },
                    ),
                  ),

                  // back icon
                  Positioned(
                    top: 10,
                    left: 10,
                    child: IconButton(
                      onPressed: Get.back,
                      icon: const Icon(
                        Icons.arrow_back_outlined,
                        size: 30,
                        color: Colors.black,
                      ),
                    ),
                  ),

                  // favorite icon
                ],
              ),

              const SizedBox(height: 20),

              // DETAILS SECION
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // title
                    Text(
                      property['title'],
                      style: const TextStyle(fontSize: 20),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),

                    const SizedBox(height: 20),
                    const Text(
                      'ข้อมูลทรัพย์',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),

                    // property type label
                    _propertyInfoLabel(
                      icon: Icons.check,
                      iconColor: Colors.green,
                      label: 'ประเภท${property['propertyType']}',
                    ),

                    const SizedBox(height: 10),

                    // cost
                    _propertyInfoLabel(
                      icon: Icons.attach_money,
                      iconColor: const Color.fromARGB(255, 234, 224, 139),
                      label: '${property['price']} ${property['priceUnit']}',
                    ),

                    const SizedBox(height: 10),

                    // location
                    _propertyInfoLabel(
                      icon: Icons.location_on,
                      iconColor: Colors.blueAccent,
                      label: property['location'],
                    ),

                    const SizedBox(height: 10),

                    // created date
                    _propertyInfoLabel(
                      icon: Icons.calendar_month_outlined,
                      iconColor: Colors.blueGrey,
                      label: 'ลงประกาศเมื่อ ${property['createdAt']}',
                    ),

                    const SizedBox(height: 20),
                    const Text(
                      'รายละเอียดห้อง',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),

                    // area and floor number
                    Row(
                      children: [
                        Expanded(
                          child: _propertyInfoLabel(
                            icon: Icons.aspect_ratio,
                            iconColor: const Color.fromARGB(255, 65, 141, 104),
                            label: '${property['area']} ตร.ม.',
                          ),
                        ),
                        Expanded(
                          child: _propertyInfoLabel(
                            icon: Icons.layers,
                            iconColor: Colors.orange,
                            label: 'อยู่ชั้นที่ ${property['floor']}',
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 10),

                    // bedrooms and bathrooms
                    Row(
                      children: [
                        Expanded(
                          child: _propertyInfoLabel(
                            icon: Icons.bed_outlined,
                            iconColor: Colors.pinkAccent,
                            label: '${property['bedrooms']} ห้องนอน',
                          ),
                        ),
                        Expanded(
                          child: _propertyInfoLabel(
                            icon: Icons.bathtub_outlined,
                            iconColor: Colors.blueAccent,
                            label: '${property['bathrooms']} ห้องน้ำ',
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),
                    const Text(
                      'รายละเอียดเพิ่มเติม',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),

                    // property detail
                    Text(
                      property['detail'],
                      style: const TextStyle(fontSize: 16),
                    ),

                    const Divider(height: 40),

                    // owner profile
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 25,
                              child: ClipOval(
                                child: CachedNetworkImage(
                                  imageUrl:
                                      'https://c-cdnet.cdn.smule.com/rs-s77/arr/48/be/c185cad2-4f00-4e20-a966-69325ec36030.jpg',
                                  placeholder: (context, url) => const Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      const Center(child: Icon(Icons.error)),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  property['createdBy'],
                                  style: const TextStyle(fontSize: 16),
                                ),
                                Text(
                                  property['propertyType'] == 'เช่า'
                                      ? 'ผู้ให้เช่า'
                                      : 'ผู้ขาย',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Image.asset(
                            'assets/icon/line_icon_color.png',
                            width: 40,
                          ),
                        ),
                      ],
                    ),

                    const Divider(height: 40),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _propertyInfoLabel({
    required IconData icon,
    required Color iconColor,
    required String label,
  }) {
    return Row(
      children: [
        Icon(icon, size: 18, color: iconColor),
        const SizedBox(width: 10),
        Text(label, style: const TextStyle(fontSize: 16)),
      ],
    );
  }
}
