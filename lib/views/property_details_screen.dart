import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:livaplace_app/controllers/property_details_controller.dart';

class PropertyDetailsScreen extends GetView<PropertyDetailsController> {
  const PropertyDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  // IMAGE SECTION
                  Obx(() {
                    return controller.propertyDetails.isEmpty
                        ? const Center(child: CircularProgressIndicator())
                        : Container(
                            height: 300,
                            color: Colors.grey.shade200,
                            child: Swiper(
                              pagination: const SwiperPagination(),
                              itemCount:
                                  controller.propertyDetails['images'].length,
                              itemBuilder: (context, index) {
                                return CachedNetworkImage(
                                  imageUrl: controller
                                      .propertyDetails['images'][index],
                                  fit: BoxFit.fitHeight,
                                  placeholder: (context, url) => const Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      const Center(child: Icon(Icons.error)),
                                );
                              },
                            ),
                          );
                  }),

                  const SizedBox(height: 20),

                  // DETAILS SECION
                  Obx(() {
                    return controller.propertyDetails.isEmpty
                        ? const Center(child: CircularProgressIndicator())
                        : Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // title
                                Text(
                                  controller.propertyDetails['title'],
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
                                  label:
                                      'ประเภท${controller.propertyDetails['property_type']}',
                                ),

                                const SizedBox(height: 10),

                                // cost
                                _propertyInfoLabel(
                                  icon: Icons.attach_money,
                                  iconColor: const Color.fromARGB(
                                    255,
                                    234,
                                    224,
                                    139,
                                  ),
                                  label:
                                      '${controller.propertyDetails['price']} ${controller.propertyDetails['price_unit']}',
                                ),

                                const SizedBox(height: 10),

                                // location
                                _propertyInfoLabel(
                                  icon: Icons.location_on,
                                  iconColor: Colors.blueAccent,
                                  label: controller.propertyDetails['location'],
                                ),

                                const SizedBox(height: 10),

                                // created date
                                _propertyInfoLabel(
                                  icon: Icons.calendar_month_outlined,
                                  iconColor: Colors.blueGrey,
                                  label: DateFormat('dd/MM/yyyy').format(
                                    DateTime.parse(
                                      controller.propertyDetails['created_at'],
                                    ),
                                  ),
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
                                        iconColor: const Color.fromARGB(
                                          255,
                                          65,
                                          141,
                                          104,
                                        ),
                                        label:
                                            '${controller.propertyDetails['area']} ตร.ม.',
                                      ),
                                    ),
                                    Expanded(
                                      child: _propertyInfoLabel(
                                        icon: Icons.layers,
                                        iconColor: Colors.orange,
                                        label:
                                            'อยู่ชั้นที่ ${controller.propertyDetails['floor']}',
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
                                        label:
                                            '${controller.propertyDetails['bedrooms']} ห้องนอน',
                                      ),
                                    ),
                                    Expanded(
                                      child: _propertyInfoLabel(
                                        icon: Icons.bathtub_outlined,
                                        iconColor: Colors.blueAccent,
                                        label:
                                            '${controller.propertyDetails['bathrooms']} ห้องน้ำ',
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
                                  controller.propertyDetails['detail'],
                                  style: const TextStyle(fontSize: 16),
                                ),

                                const SizedBox(height: 20),

                                const Text(
                                  'สิ่งอำนวยความสะดวก',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                                const SizedBox(height: 10),

                                // facilities
                                Obx(() {
                                  final Map<String, dynamic> facilities =
                                      controller.propertyDetails['facilities'];

                                  // filter out false value
                                  final List<String> availableFacilities =
                                      facilities.entries
                                          .where((entry) => entry.value == true)
                                          .map((entry) => entry.key)
                                          .toList();

                                  return Wrap(
                                    spacing: 10,
                                    runSpacing: 10,
                                    children: availableFacilities.map((item) {
                                      String displayName =
                                          _getFacilityDisplayName(item);
                                      IconData facilityIcon = _getFacilityIcon(
                                        item,
                                      );

                                      return Chip(
                                        label: Text(
                                          displayName,
                                          style: const TextStyle(
                                            color: Colors.black,
                                          ),
                                        ),
                                        avatar: Icon(
                                          facilityIcon,
                                          size: 18,
                                          color: Colors.black,
                                        ),
                                        backgroundColor: Colors.white,
                                      );
                                    }).toList(),
                                  );
                                }),

                                const Divider(height: 40),

                                // owner profile
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Row(
                                        children: [
                                          Obx(
                                            () => CircleAvatar(
                                              radius: 25,
                                              child: ClipOval(
                                                child:
                                                    controller
                                                            .ownerDetails['profile_picture'] !=
                                                        null
                                                    ? CachedNetworkImage(
                                                        imageUrl: controller
                                                            .ownerDetails['profile_picture'],
                                                        placeholder:
                                                            (
                                                              context,
                                                              url,
                                                            ) => const Center(
                                                              child:
                                                                  CircularProgressIndicator(),
                                                            ),
                                                        errorWidget:
                                                            (
                                                              context,
                                                              url,
                                                              error,
                                                            ) => const Center(
                                                              child: Icon(
                                                                Icons.person,
                                                                size: 50,
                                                                color:
                                                                    Colors.grey,
                                                              ),
                                                            ),
                                                      )
                                                    : const Icon(
                                                        Icons.person,
                                                        size: 50,
                                                        color: Colors.grey,
                                                      ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          Expanded(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Obx(
                                                  () => Text(
                                                    '${controller.ownerDetails['first_name']} ${controller.ownerDetails['last_name']}',
                                                    style: const TextStyle(
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                ),
                                                Obx(
                                                  () => Text(
                                                    controller
                                                        .ownerDetails['phone'],
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      color:
                                                          Colors.grey.shade600,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            final String phoneNumber =
                                                controller
                                                    .ownerDetails['phone'];
                                            controller.makePhoneCall(
                                              phoneNumber,
                                            );
                                          },
                                          icon: const Icon(Icons.phone),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            final String lineId = controller
                                                .ownerDetails['line_id'];
                                            controller.contactViaLine(lineId);
                                          },
                                          icon: Image.asset(
                                            'assets/icon/line_icon_color.png',
                                            width: 40,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),

                                const Divider(height: 40),
                              ],
                            ),
                          );
                  }),
                ],
              ),
            ),

            // back button
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

            // save button
            Obx(
              () => Positioned(
                top: 10,
                right: 10,
                child: Container(
                  width: 40,
                  height: 40,
                  padding: const EdgeInsets.all(0),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade500,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    icon: Icon(
                      Icons.favorite,
                      size: 22,
                      color: controller.isSaved.value
                          ? Colors.redAccent
                          : Colors.white,
                    ),
                    onPressed: controller.saveProperty,
                  ),
                ),
              ),
            ),
          ],
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 18, color: iconColor),
        const SizedBox(width: 10),
        Text(label, style: const TextStyle(fontSize: 16)),
      ],
    );
  }

  String _getFacilityDisplayName(String key) {
    // translate facility name from english to thai
    switch (key) {
      case 'air_conditioner':
        return 'เครื่องปรับอากาศ';
      case 'balcony':
        return 'ระเบียง';
      case 'parking':
        return 'ที่จอดรถ';
      case 'pool':
        return 'สระว่ายน้ำ';
      case 'fitness':
        return 'ฟิตเนส';
      case 'pet_friendly':
        return 'เลี้ยงสัตว์ได้';
      case 'furniture':
        return 'เฟอร์นิเจอร์';
      case 'kitchen':
        return 'ครัว';
      case 'washing_machine':
        return 'เครื่องซักผ้า';
      case 'wifi':
        return 'WiFi';
      default:
        return key.replaceAll('_', ' ').capitalizeFirst!;
    }
  }

  IconData _getFacilityIcon(String key) {
    switch (key) {
      case 'air_conditioner':
        return Icons.ac_unit;
      case 'balcony':
        return Icons.balcony;
      case 'parking':
        return Icons.local_parking;
      case 'pool':
        return Icons.pool;
      case 'fitness':
        return Icons.fitness_center;
      case 'washing_machine':
        return Icons.local_laundry_service;
      case 'pet_friendly':
        return Icons.pets;
      case 'furniture':
        return Icons.chair;
      case 'kitchen':
        return Icons.soup_kitchen;
      case 'wifi':
        return Icons.wifi;
      default:
        return Icons.check_circle_outline;
    }
  }
}
