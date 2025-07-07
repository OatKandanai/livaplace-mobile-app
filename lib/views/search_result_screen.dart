import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:livaplace_app/routes/app_routes.dart';
import 'package:livaplace_app/views/property_card.dart';

class SearchResultScreen extends StatelessWidget {
  const SearchResultScreen({super.key});

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
                  // TextField(
                  //   readOnly: true,
                  //   autofocus: false,
                  //   decoration: InputDecoration(
                  //     hint: const Text('ค้นหา'),
                  //     prefixIcon: GestureDetector(
                  //       onTap: () => Get.offAllNamed(AppRoutes.home),
                  //       child: const Icon(Icons.arrow_back_ios, size: 30),
                  //     ),
                  //     filled: true,
                  //     fillColor: Colors.grey.shade200,
                  //     border: OutlineInputBorder(
                  //       borderSide: BorderSide.none,
                  //       borderRadius: BorderRadius.circular(50),
                  //     ),
                  //   ),
                  //   onTap: () {
                  //     Get.toNamed(AppRoutes.searchFilters);
                  //   },
                  // ),

                  // const SizedBox(height: 10),
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
                        // TextSpan(
                        //   text: '(${searchResult.length})',
                        //   style: const TextStyle(
                        //     fontSize: 20,
                        //     fontWeight: FontWeight.bold,
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),

                  // card
                  // Expanded(
                  //   child: ListView.separated(
                  //     itemBuilder: (context, index) {
                  //       final Map<String, dynamic> result = searchResult[index];
                  //       final String imageUrl = result['image'];
                  //       final String propertyType = result['propertyType'];
                  //       final String roomType = result['roomType'];
                  //       final String title = result['title'];
                  //       final String location = result['location'];
                  //       final int bedrooms = result['bedrooms'];
                  //       final int bathrooms = result['bathrooms'];
                  //       final int price = result['price'];
                  //       final String priceUnit = result['priceUnit'];
                  //       final bool isFavorite = result['isFavorite'];
                  //       final String created = result['created'];

                  //       return SizedBox();
                  //       return PropertyCard(
                  //         imageUrl: imageUrl,
                  //         propertyType: propertyType,
                  //         roomType: roomType,
                  //         title: title,
                  //         location: location,
                  //         bedrooms: bedrooms,
                  //         bathrooms: bathrooms,
                  //         price: price,
                  //         priceUnit: priceUnit,
                  //         isFavorite: isFavorite,
                  //         created: created!,
                  //       );
                  //     },
                  //     separatorBuilder: (context, index) =>
                  //         const SizedBox(height: 10),
                  //     itemCount: searchResult.length,
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
