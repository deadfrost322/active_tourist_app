import 'dart:developer';

class PlaceEntity {
  int? id;
  String name;
  String category;
  double lat;
  double lon;
  List<String>? images;
  String? status;

  PlaceEntity(
      {this.id,
      required this.name,
      required this.category,
      required this.lat,
      required this.lon,
      this.images,
      this.status});

  factory PlaceEntity.fromJsonShort(Map<String, dynamic> json) {
    return PlaceEntity(
        id: json['id'],
        name: json['name'],
        category: json['category'],
        lat: double.parse(json['lat']),
        lon: double.parse(json['lon']));
  }

  factory PlaceEntity.fromJsonFull(Map<String, dynamic> json) {
    PlaceEntity place = PlaceEntity(
        name: json['name'],
        category: json['category'],
        lat: double.parse(json['lat']),
        lon: double.parse(json['lon']),
        images: [],);
    List<String> images;
    List list = json['images'];
    if(list.isNotEmpty){
      images = List.generate(list.length, (i) => list[i]['image']);
      place.images = images;
    }
    else{
      place.images!.add( "/null");
    }
    return place;
  }
}

