import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:get/route_manager.dart';
import 'package:get/state_manager.dart';
import 'package:intl/intl.dart';
import 'package:livaplace_app/controllers/property_details_controller.dart';

class PropertyDetailsScreen extends GetView<PropertyDetailsController> {
  const PropertyDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // IMAGE SECTION
              Stack(
                children: [
                  // image swiper
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
                              label: '12/1/2025',
                            ),
                            /* DateFormat('dd/MM/yyyy').format(
                                controller.propertyDetails['created_at'],
                              )*/
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
                                          placeholder: (context, url) =>
                                              const Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              ),
                                          errorWidget: (context, url, error) =>
                                              const Center(
                                                child: Icon(Icons.error),
                                              ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'owner name',
                                          style: const TextStyle(fontSize: 16),
                                        ),
                                        Text(
                                          controller.propertyDetails['property_type'] ==
                                                  'เช่า'
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
                      );
              }),
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
