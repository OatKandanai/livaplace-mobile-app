class PropertyModel {
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
      propertyType: data['propertyType'] as String? ?? 'Unknown',
      roomType: data['roomType'] as String? ?? 'Unknown',
      title: data['title'] as String? ?? 'No Title',
      location: data['location'] as String? ?? 'Unknown Location',
      bedrooms: (data['bedrooms'] as num?)?.toInt() ?? 0,
      bathrooms: (data['bathrooms'] as num?)?.toInt() ?? 0,
      area: (data['area'] as num?)?.toInt() ?? 0,
      floor: (data['floor'] as num?)?.toInt() ?? 0,
      price: (data['price'] as num?)?.toInt() ?? 0,
      priceUnit: data['priceUnit'] as String ?? '',
      images: List<String>.from(data['images'] ?? []),
      facilities: List<String>.from(data['facilities'] ?? []),
      detail: detail,
      ownerId: ownerId,
      createdAt: createdAt,
      isApproved: isApproved,
    );
  }
}
