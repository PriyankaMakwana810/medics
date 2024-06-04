class Medicine {
  final String name;
  final String quantity;
  final String image;
  final String rate;
  final String price;
  final String discountedPrice;
  final String description;

  Medicine(
      {required this.name,
      required this.quantity,
      required this.image,
      required this.rate,
      required this.price,
      required this.discountedPrice,
      required this.description});

  factory Medicine.fromJson(Map<String, dynamic> json) {
    return Medicine(
        name: json['name'],
        quantity: json['quantity'],
        image: json['image'],
        rate: json['rate'],
        price: json['price'],
        discountedPrice: json['discountedPrice'],
        description: json['description']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['quantity'] = quantity;
    data['image'] = image;
    data['rate'] = rate;
    data['price'] = price;
    data['discountedPrice'] = discountedPrice;
    data['description'] = description;
    return data;
  }
}
