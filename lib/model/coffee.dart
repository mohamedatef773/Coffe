class Coffee {
  int id;
  String title;
  String subTitle;
  String description;
  String image;
  int quantity;
  int price;
  String category;

  Coffee({
    required this.id,
    required this.title,
    required this.subTitle,
    required this.description,
    required this.image,
    required this.quantity,
    required this.price,
    required this.category,
  });

  factory Coffee.fromMap(Map<String, dynamic> map) {
    return Coffee(
      id: map["id"],
      title: map["title"],
      subTitle: map["subTitle"],
      description: map["description"],
      image: map["image"],
      quantity: map["quantity"],
      price: map["price"],
      category: map["category"],
    );
  }
}
