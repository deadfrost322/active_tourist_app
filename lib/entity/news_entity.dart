import 'dart:developer';

class NewsEntity {
  int id;
  String title;
  String? content;
  String category;
  String? image;
  List<String>? images;

  NewsEntity({required this.id,
    required this.title,
    this.content,
    required this.category,
    this.image,
    this.images});

  factory NewsEntity.fromJsonShort(Map<String, dynamic> json) {
    log(json.toString());
    NewsEntity news = NewsEntity(
      id: json['id'],
      title: json['title'],
      content: json['content'],
      category: json['category'],
      image: json['image'],
    );
    log(news.id.toString());
    return news;
  }

  factory NewsEntity.fromJsonFull(Map<String, dynamic> json) {
    NewsEntity news = NewsEntity(
        id: json['id'],
        title: json['title'],
        content: json['content'],
        category: json['category'],
        image: json['image'],
        images: []);
    List<String> images;

    List list = json['images'];
    if(list.isNotEmpty){
      images = List.generate(list.length, (i) => list[i]['image']);
      news.images = images;
    }
    news.images!.add(news.image ?? "пусто");
    return news;
  }
}
