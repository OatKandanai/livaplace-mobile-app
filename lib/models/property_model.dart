class PropertyModel {
  final String propertyId;
  final String propertyType;
  final String roomType;
  final String title;
  final String location;
  final int bedrooms;
  final int bathrooms;
  final int area;
  final int floor;
  final int price;
  final String priceUnit;
  final List<String> images;
  final List<String> facilities;
  final String detail;
  final String ownerId;
  final DateTime? createdAt;
  final bool isApproved;

  PropertyModel({
    required this.propertyId,
    required this.propertyType,
    required this.roomType,
    required this.title,
    required this.location,
    required this.bedrooms,
    required this.bathrooms,
    required this.area,
    required this.floor,
    required this.price,
    required this.priceUnit,
    required this.images,
    required this.facilities,
    required this.detail,
    required this.ownerId,
    required this.createdAt,
    required this.isApproved,
  });

  factory PropertyModel.fromMap(Map<String, dynamic> data) {
    return PropertyModel(
      propertyId: data['id'] as String? ?? '-1',
      propertyType: data['property_type'] as String? ?? 'Unknown',
      roomType: data['room_type'] as String? ?? 'Unknown',
      title: data['title'] as String? ?? 'No Title',
      location: data['location'] as String? ?? 'Unknown Location',
      bedrooms: (data['bedrooms'] as num?)?.toInt() ?? 0,
      bathrooms: (data['bathrooms'] as num?)?.toInt() ?? 0,
      area: (data['area'] as num?)?.toInt() ?? 0,
      floor: (data['floor'] as num?)?.toInt() ?? 0,
      price: (data['price'] as num?)?.toInt() ?? 0,
      priceUnit: data['price_unit'] as String? ?? '',
      images: List<String>.from(data['images'] ?? []),
      facilities:
          (data['facilities'] as Map<String, dynamic>?)?.entries
              .where((e) => e.value == true)
              .map((e) => e.key)
              .toList() ??
          [],
      detail: data['detail'] as String? ?? '',
      ownerId: data['owner_id'] as String? ?? '',
      createdAt: DateTime.tryParse(
        data['created_at'] as String? ?? DateTime.now().toIso8601String(),
      ),
      isApproved: data['is_approved'] as bool? ?? false,
    );
  }
}
