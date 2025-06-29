import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/utils.dart';
import 'package:livaplace_app/routes/app_routes.dart';

class PropertyCard extends StatelessWidget {
  final String imageUrl;
  final String propertyType;
  final String roomType;
  final String title;
  final String location;
  final int bedrooms;
  final int bathrooms;
  final int price;
  final String priceUnit;
  final bool isFavorite;
  final String created;
  final VoidCallback? onFavoriteToggle;

  const PropertyCard({
    super.key,
    required this.imageUrl,
    required this.propertyType,
    required this.roomType,
    required this.title,
    required this.location,
    required this.bedrooms,
    required this.bathrooms,
    required this.price,
    required this.priceUnit,
    required this.isFavorite,
    required this.created,
    this.onFavoriteToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        InkWell(
          onTap: () => Get.toNamed(AppRoutes.propertyDetails),
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
                    padding: const EdgeInsets.only(left: 15, right: 10),
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // property type and room type
                        Row(
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

                        const SizedBox(height: 8),

                        // title
                        Text(
                          title,
                          style: const TextStyle(fontSize: 14),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),

                        const SizedBox(height: 8),

                        // location
                        Row(
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

                        const SizedBox(height: 8),

                        // bedrooms and bathrooms
                        Row(
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
                              '$bathrooms ห้องนอน',
                              style: const TextStyle(fontSize: 12),
                            ),
                          ],
                        ),

                        const SizedBox(height: 8),

                        // price
                        Text(
                          '$price $priceUnit',
                          style: const TextStyle(fontSize: 16),
                        ),

                        const SizedBox(height: 8),

                        // created date
                        Row(
                          children: [
                            const Icon(
                              Icons.calendar_month_outlined,
                              color: Colors.blueGrey,
                              size: 20,
                            ),
                            const SizedBox(width: 3),
                            Text(
                              'ลงประกาศเมื่อ $created',
                              style: const TextStyle(fontSize: 10),
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
        ),
        Positioned(
          bottom: 5,
          right: 5,
          child: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.favorite,
              size: 22,
              color: isFavorite ? Colors.redAccent : Colors.grey,
            ),
          ),
        ),
      ],
    );
  }
}
