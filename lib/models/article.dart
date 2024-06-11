class Article {
  final int id;
  final String title;
  final String tag;
  final String time;
  final String timeToRead;
  final String imageUrl;
  bool isSaved;

  Article(
      {required this.id,
      required this.title,
      required this.tag,
      required this.time,
      required this.timeToRead,
      required this.imageUrl,
      required this.isSaved});

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
        id: json['id'],
        title: json['title'],
        tag: json['tag'],
        time: json['time'],
        timeToRead: json['timeToRead'],
        imageUrl: json['imageUrl'],
        isSaved: json['isSaved'] == 1 ? true : false);
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'tag': tag,
        'time': time,
        'timeToRead': timeToRead,
        'imageUrl': imageUrl,
        'isSaved': isSaved
      };
}
