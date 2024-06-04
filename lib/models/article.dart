class Article {
  final String title;
  final String tag;
  final String time;
  final String timeToRead;
  final String imageUrl;

  Article(
      {required this.title,
      required this.tag,
      required this.time,
      required this.timeToRead,
      required this.imageUrl});

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      title: json['title'],
      tag: json['tag'],
      time: json['time'],
      timeToRead: json['timeToRead'],
      imageUrl: json['imageUrl'],
    );
  }

  Map<String, dynamic> toJson() => {
        'title': title,
        'tag': tag,
        'time': time,
        'timeToRead': timeToRead,
        'imageUrl': imageUrl,
      };
}
