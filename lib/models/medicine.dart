import 'dart:ffi';

class Medicine {
  final int id;
  final String name;
  final String quantity;
  final String image;
  final String rate;
  final String price;
  final String discountedPrice;
  int items;
  final String description;

  Medicine(
      {required this.id,
      required this.name,
      required this.quantity,
      required this.image,
      required this.rate,
      required this.price,
      required this.discountedPrice,
      required this.items,
      required this.description});

  factory Medicine.fromJson(Map<String, dynamic> json) {
    return Medicine(
        id: json['id'],
        name: json['name'],
        quantity: json['quantity'],
        image: json['image'],
        rate: json['rate'],
        price: json['price'],
        discountedPrice: json['discountedPrice'],
        items: json['items'],
        description: json['description']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['quantity'] = quantity;
    data['image'] = image;
    data['rate'] = rate;
    data['price'] = price;
    data['discountedPrice'] = discountedPrice;
    data['items'] = items;
    data['description'] = description;
    return data;
  }
}
