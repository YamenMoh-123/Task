class Item {
  final int id;
  final String title;
  final String rating;
  final String author;

  Item({required this.id, required this.title, required this.rating, required this.author});

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['id'],
      title: json['title'],
      rating: json['rating'],
      author: json['author'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'rating': rating,
      'author': author,
    };
  }
}
