class Article {
  final String title;
  final String tag;
  final String time;
  final String timeToRead;
  final String imageUrl;
  final bool isSaved;

  Article(
      {required this.title,
      required this.tag,
      required this.time,
      required this.timeToRead,
      required this.imageUrl,
      required this.isSaved});

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
        title: json['title'],
        tag: json['tag'],
        time: json['time'],
        timeToRead: json['timeToRead'],
        imageUrl: json['imageUrl'],
        isSaved: json['isSaved']);
  }

  Map<String, dynamic> toJson() => {
        'title': title,
        'tag': tag,
        'time': time,
        'timeToRead': timeToRead,
        'imageUrl': imageUrl,
        'isSaved': isSaved
      };
}
