class Schedule {
  final String name;
  final String designation;
  final String image;
  final String date;
  final String time;
  final String status;

  Schedule(
      {required this.name,
      required this.designation,
      required this.image,
      required this.date,
      required this.time,
      required this.status});

  factory Schedule.fromJson(Map<String, dynamic> json) {
    return Schedule(
      name: json['name'],
      designation: json['designation'],
      image: json['image'],
      date: json['date'],
      time: json['time'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'designation': designation,
        'image': image,
        'date': date,
        'time': time,
        'status': status
      };
}
