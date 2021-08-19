class Item {
  final id;
  final title;
  final price;
  final description;
  final category;
  final image;

  Item(
      {required this.id,
      required this.title,
      required this.price,
      required this.description,
      required this.category,
      required this.image});

  factory Item.fromjson(Map<dynamic, dynamic> data) {
    return new Item(
        id: data["id"],
        title: data["title"],
        price: data["price"],
        description: data["description"],
        category: data["category"],
        image: data["image"]);
  }
}
