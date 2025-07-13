import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:livaplace_app/controllers/search_result_controller.dart';
import 'package:livaplace_app/views/property_card.dart';

class SearchResultScreen extends GetView<SearchResultController> {
  const SearchResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: FocusScope.of(context).unfocus,
      child: Scaffold(
        appBar: AppBar(
          title: Obx(
            () => RichText(
              text: TextSpan(
                style: GoogleFonts.mitr(color: Colors.black),
                children: <TextSpan>[
                  const TextSpan(
                    text: 'ผลการค้นหา',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const TextSpan(text: '\u00A0\u00A0'),
                  TextSpan(
                    text: '(${controller.searchResults.length})',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: controller.searchResults.isEmpty
                ? const Text(
                    'ไม่พบผลลัพธ์ที่ค้นหา',
                    style: TextStyle(fontSize: 20),
                  )
                : Expanded(
                    child: ListView.separated(
                      itemBuilder: (context, index) {
                        final result = controller.searchResults[index];
                        final String id = result.propertyId;
                        final String imageUrl = result.images[0];
                        final String propertyType = result.propertyType;
                        final String roomType = result.roomType;
                        final String title = result.title;
                        final String location = result.location;
                        final int bedrooms = result.bedrooms;
                        final int bathrooms = result.bathrooms;
                        final int price = result.price;
                        final String priceUnit = result.priceUnit;
                        final DateTime? created = DateTime.tryParse(
                          '${result.createdAt}',
                        );

                        return PropertyCard(
                          propertyId: id,
                          imageUrl: imageUrl,
                          propertyType: propertyType,
                          roomType: roomType,
                          title: title,
                          location: location,
                          bedrooms: bedrooms,
                          bathrooms: bathrooms,
                          price: price,
                          priceUnit: priceUnit,
                          created: created!,
                        );
                      },
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 10),
                      itemCount: controller.searchResults.length,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
