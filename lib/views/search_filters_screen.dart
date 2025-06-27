import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:livaplace_app/controllers/search_filters_controller.dart';

class SearchFiltersScreen extends StatelessWidget {
  SearchFiltersScreen({super.key});

  final SearchFiltersController controller = Get.put(SearchFiltersController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: FocusScope.of(context).unfocus,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Form(
                  child: Column(
                    children: [
                      // Search bar
                      TextFormField(
                        autofocus: false,
                        decoration: InputDecoration(
                          hint: const Text('ค้นหา'),
                          prefixIcon: GestureDetector(
                            onTap: Get.back,
                            child: const Icon(Icons.arrow_back_ios, size: 30),
                          ),
                          filled: true,
                          fillColor: Colors.grey.shade200,
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              width: 1,
                              color: Colors.black,
                            ),
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      // type title
                      const Text(
                        'ประเภท',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 20),

                      // type selection
                      Obx(
                        () => Wrap(
                          spacing: 20,
                          runSpacing: 10,
                          children: controller.types.map((type) {
                            return ChoiceChip(
                              showCheckmark: false,
                              label: Text(type),
                              labelStyle: TextStyle(
                                color: controller.selectedType.value == type
                                    ? Colors.white
                                    : Colors.black,
                              ),
                              elevation: 10,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              backgroundColor:
                                  Colors.grey.shade200, // unactive bg color
                              selectedColor: Colors.black, // active bg color
                              selected: controller.selectedType.value == type,
                              onSelected: (_) {
                                controller.selectedType.value = type;
                              },
                            );
                          }).toList(),
                        ),
                      ),

                      const SizedBox(height: 20),

                      // facilities title
                      const Text(
                        'สิ่งอำนวยความสะดวก',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 20),

                      // facilities selection
                      Obx(
                        () => Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          children: controller.facilities.map((facility) {
                            final bool isSelected = controller
                                .selectedFacilities
                                .contains(facility);

                            return FilterChip(
                              showCheckmark: false,
                              label: Text(facility),
                              labelStyle: TextStyle(
                                color: isSelected ? Colors.white : Colors.black,
                              ),
                              elevation: 10,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              backgroundColor:
                                  Colors.grey.shade200, // unactive bg color
                              selectedColor: Colors.black, // active bg color
                              selected: isSelected,
                              onSelected: (bool selected) {
                                if (selected) {
                                  controller.selectedFacilities.add(facility);
                                } else {
                                  controller.selectedFacilities.remove(
                                    facility,
                                  );
                                }
                              },
                            );
                          }).toList(),
                        ),
                      ),

                      const SizedBox(height: 20),

                      // bedroom and bathroom title
                      const Text(
                        'ห้องนอนและห้องน้ำ',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 20),

                      // bedroom qty control
                      buildCounterRow(
                        label: 'ห้องนอน',
                        counter: controller.bedroomCount,
                        onIncrease: () =>
                            controller.handleBedroomCount(type: 'increase'),
                        onDecrease: () =>
                            controller.handleBedroomCount(type: 'decrease'),
                      ),

                      const SizedBox(height: 10),

                      // bathroom qty control
                      buildCounterRow(
                        label: 'ห้องน้ำ',
                        counter: controller.bathroomCount,
                        onIncrease: () =>
                            controller.handleBathroomCount(type: 'increase'),
                        onDecrease: () =>
                            controller.handleBathroomCount(type: 'decrease'),
                      ),

                      const SizedBox(height: 40),

                      // Footer buttons (reset, search)
                      Row(
                        children: [
                          Expanded(
                            child: TextButton(
                              onPressed: () {},
                              child: const Text(
                                'ล้างการค้นหา',
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ),
                          const SizedBox(width: 15),
                          Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black,
                                elevation: 10,
                              ),
                              onPressed: () {},
                              child: const Text(
                                'ค้นหา',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildCounterRow({
    required String label,
    required RxInt counter,
    required VoidCallback onIncrease,
    required VoidCallback onDecrease,
  }) {
    return Obx(
      () => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                icon: const Icon(Icons.remove_circle_outline, size: 34),
                onPressed: onDecrease,
              ),
              const SizedBox(width: 10),
              Text(counter.value.toString()),
              const SizedBox(width: 10),
              IconButton(
                icon: const Icon(Icons.add_circle_outline, size: 34),
                onPressed: onIncrease,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
