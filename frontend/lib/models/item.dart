class Item {
  final int id;
  String title;
  String rating;
  String itemType;
  Map<String, dynamic> details;


  Item({required this.id, required this.title, required this.rating,
    required this.itemType, required this.details});

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['id'],
      title: json['title'],
      rating: json['rating'].toString(),
      itemType: json['type'] ?? 'unknown',
      details: json['additional_details'] ?? {},
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'rating': rating,
      'type': itemType,
      'additional_details': details
    };
  }
}
