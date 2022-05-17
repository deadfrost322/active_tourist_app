class ReviewEntity {
  int? id;
  int? likeScale;
  String? commentary;
  String? date;

  ReviewEntity(
      { this.id,
       this.likeScale,
       this.commentary,
       this.date});

  factory ReviewEntity.fromJson(Map<String, dynamic> json){
    return ReviewEntity(
      id: json["id"],
      likeScale: json["likeScale"],
      commentary: json["commentary"],
      date: json["date"]
    );
  }
}
