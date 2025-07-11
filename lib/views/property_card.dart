import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:livaplace_app/routes/app_routes.dart';

class PropertyCard extends StatelessWidget {
  final String propertyId;
  final String imageUrl;
  final String propertyType;
  final String roomType;
  final String title;
  final String location;
  final int bedrooms;
  final int bathrooms;
  final int price;
  final String priceUnit;
  final DateTime created;

  const PropertyCard({
    super.key,
    required this.propertyId,
    required this.imageUrl,
    required this.propertyType,
    required this.roomType,
    required this.title,
    required this.location,
    required this.bedrooms,
    required this.bathrooms,
    required this.price,
    required this.priceUnit,
    required this.created,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        InkWell(
          onTap: () =>
              Get.toNamed(AppRoutes.propertyDetails, arguments: propertyId),
          child: Card(
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
                    placeholder: (context, url) =>
                        const Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) =>
                        const Center(child: Icon(Icons.error)),
                  ),
                ),

                // information
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // title
                        Text(
                          title,
                          style: const TextStyle(fontSize: 15),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                        ),

                        const SizedBox(height: 10),

                        // property type and room type
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // property type
                            const Icon(
                              Icons.check,
                              size: 20,
                              color: Colors.green,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              'ประเภท$propertyType,',
                              style: const TextStyle(fontSize: 12),
                            ),

                            const SizedBox(width: 10),

                            // room type
                            const Icon(
                              Icons.home_work,
                              size: 18,
                              color: Colors.blueAccent,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              roomType,
                              style: const TextStyle(fontSize: 12),
                            ),
                          ],
                        ),

                        const SizedBox(height: 10),

                        // location
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.location_on,
                              size: 20,
                              color: Colors.blueAccent,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              location,
                              style: const TextStyle(fontSize: 12),
                            ),
                          ],
                        ),

                        const SizedBox(height: 10),

                        // bedrooms and bathrooms
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.bed_outlined, size: 20),
                            const SizedBox(width: 3),
                            Text(
                              '$bedrooms ห้องนอน',
                              style: const TextStyle(fontSize: 12),
                            ),
                            const SizedBox(width: 10),
                            const Icon(Icons.bathtub_outlined, size: 20),
                            const SizedBox(width: 3),
                            Text(
                              '$bathrooms ห้องน้ำ',
                              style: const TextStyle(fontSize: 12),
                            ),
                          ],
                        ),

                        const SizedBox(height: 10),

                        // created date
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.calendar_month_outlined,
                              color: Colors.blueGrey,
                              size: 20,
                            ),
                            const SizedBox(width: 3),
                            Text(
                              'ลงประกาศเมื่อ ${DateFormat('dd/MM/yyyy').format(created)}',
                              style: const TextStyle(fontSize: 12),
                            ),
                          ],
                        ),

                        const SizedBox(height: 10),

                        // price
                        Text(
                          '$price $priceUnit',
                          style: const TextStyle(fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        // Positioned(
        //   left: 0,
        //   bottom: 0,
        //   child: IconButton(
        //     onPressed: () {},
        //     icon: Icon(
        //       Icons.favorite,
        //       size: 22,
        //       color: isFavorite ? Colors.redAccent : Colors.grey,
        //     ),
        //   ),
        // ),
      ],
    );
  }
}
