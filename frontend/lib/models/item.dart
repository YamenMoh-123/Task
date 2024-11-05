class Item {
  final int id;
  String title;
  String itemType;
  Map<String, dynamic> details;
  double rating;
  String progress;
  bool favourite;
  Map<String, dynamic> optionalDetails;

  Item({
    required this.id,
    required this.title,
    required this.itemType,
    required this.details,
    required this.rating,
    required this.progress,
    required this.favourite,
    required this.optionalDetails,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['item_id'],
      title: json['title'],
      itemType: json['item_type'],
      details: json['additional_details'] ?? {},
      rating: json['rating'] ?? 0.0,
      progress: json['progress'] ?? "not started",
      favourite: json['favourite'] ?? false,
      optionalDetails: json['optional_details'] ?? {},
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'item_id': id,
      'title': title,
      'item_type': itemType,
      'additional_details': details,
      'rating': rating,
      'progress': progress,
      'favourite': favourite,
      'optional_details': optionalDetails,
    };
  }

  void updateWith(Map<String, dynamic> json) {
    title = json['title'] ?? title;
    itemType = json['item_type'] ?? itemType;
    details = json['additional_details'] ?? details;
    rating = json['rating'] ?? rating;
    progress = json['progress'] ?? progress;
    favourite = json['favourite'] ?? favourite;
    optionalDetails = json['optional_details'] ?? optionalDetails;
  }



}
