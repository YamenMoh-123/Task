class Item {
  final String title;
  final String rating;
  final String author;

  Item({required this.title, required this.rating, required this.author});

  factory Item.fromJson(Map<String, dynamic> json){
    return Item(
      title: json['title'],
      rating: json['rating'],
        author: json['author'],
    );
  }
}