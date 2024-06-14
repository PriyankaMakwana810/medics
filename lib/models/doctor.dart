class Doctor {
  final String name;
  final String designation;
  final String image;
  final String rate;
  final String distance;
  final String userId;

  Doctor(
      {required this.name,
      required this.designation,
      required this.image,
      required this.rate,
      required this.distance,
      required this.userId});

  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
        name: json['name'],
        designation: json['designation'],
        image: json['image'],
        rate: json['rate'],
        distance: json['distance'],
        userId: json['userId'],
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'designation': designation,
        'image': image,
        'rate': rate,
        'distance': distance,
        'userId': userId,

      };
}
