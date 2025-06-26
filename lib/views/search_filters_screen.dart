import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchFiltersScreen extends StatefulWidget {
  const SearchFiltersScreen({super.key});

  @override
  State<SearchFiltersScreen> createState() => _SearchFiltersScreenState();
}

class _SearchFiltersScreenState extends State<SearchFiltersScreen> {
  List<String> types = ['ทุกประเภท', 'คอนโด', 'หอพัก'];
  String selectedType = 'คอนโด';
  List<String> facilities = [
    'ฟิตเนส',
    'ครัว',
    'ที่จอดรถ',
    'WiFi',
    'เลี้ยงสัตว์ได้',
    'สระว่ายน้ำ',
    'เฟอร์นิเจอร์',
    'เครื่องปรับอากาศ',
    'เครื่องซักผ้า',
    'ระเบียง',
  ];
  Set<String> selectedFacilities = {};
  int bedroomCount = 1;
  int bathroomCount = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SingleChildScrollView(
                child: Form(
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: InputDecoration(
                          hint: const Text('ค้นหา'),
                          prefixIcon: GestureDetector(
                            onTap: Get.back,
                            child: const Icon(Icons.arrow_back_ios),
                          ),
                          filled: true,
                          fillColor: Colors.grey.shade200,
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 1,
                              color: Colors.black,
                            ),
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'ประเภท',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Wrap(
                        spacing: 20,
                        runSpacing: 20,
                        children: types.map((type) {
                          return ChoiceChip(
                            showCheckmark: false,
                            label: Text(type),
                            labelStyle: TextStyle(
                              color: selectedType == type
                                  ? Colors.white
                                  : Colors.black,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            backgroundColor:
                                Colors.grey.shade200, // unactive bg color
                            selectedColor: Colors.black, // active bg color
                            selected: selectedType == type,
                            onSelected: (bool selected) {
                              setState(() {
                                selectedType = type;
                              });
                            },
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'สิ่งอำนวยความสะดวก',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: facilities.map((facility) {
                          return FilterChip(
                            showCheckmark: false,
                            label: Text(facility),
                            labelStyle: TextStyle(
                              color: selectedFacilities.contains(facility)
                                  ? Colors.white
                                  : Colors.black,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            backgroundColor:
                                Colors.grey.shade200, // unactive bg color
                            selectedColor: Colors.black, // active bg color
                            selected: selectedFacilities.contains(facility),
                            onSelected: (bool selected) {
                              setState(() {
                                if (selected) {
                                  selectedFacilities.add(facility);
                                } else {
                                  selectedFacilities.remove(facility);
                                }
                              });
                            },
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'ห้องนอนและห้องน้ำ',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('ห้องนอน'),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              IconButton(
                                icon: const Icon(
                                  Icons.remove_circle_outline,
                                  size: 34,
                                ),
                                onPressed: () {
                                  setState(() {
                                    bedroomCount--;
                                  });
                                },
                              ),
                              const SizedBox(width: 10),
                              Text(bedroomCount.toString()),
                              const SizedBox(width: 10),
                              IconButton(
                                icon: const Icon(
                                  Icons.add_circle_outline,
                                  size: 34,
                                ),
                                onPressed: () {
                                  bedroomCount++;
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('ห้องน้ำ'),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              IconButton(
                                icon: const Icon(
                                  Icons.remove_circle_outline,
                                  size: 34,
                                ),
                                onPressed: () {
                                  setState(() {
                                    bathroomCount--;
                                  });
                                },
                              ),
                              const SizedBox(width: 10),
                              Text(bathroomCount.toString()),
                              const SizedBox(width: 10),
                              IconButton(
                                icon: const Icon(
                                  Icons.add_circle_outline,
                                  size: 34,
                                ),
                                onPressed: () {
                                  bathroomCount++;
                                },
                              ),
                            ],
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
    );
  }
}
