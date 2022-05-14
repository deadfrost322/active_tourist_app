class ReviewEntity {
  int id;
  int likeScale;
  String commentary;
  String date;

  ReviewEntity(
      {required this.id,
      required this.likeScale,
      required this.commentary,
      required this.date});

  factory ReviewEntity.fromJson(Map<String, dynamic> json){
    return ReviewEntity(
      id: json["id"],
      likeScale: json["likeScale"],
      commentary: json["commentary"],
      date: json["date"]
    );
  }
}
