import 'dart:developer';

import 'package:active_tourist_app/entity/review_entity.dart';

class PlaceEntity {
  int? id;
  String name;
  String category;
  double lat;
  double lon;
  List<String>? images;
  String? status;
  List<ReviewEntity>? reviewList;

  PlaceEntity(
      {this.id,
      required this.name,
      required this.category,
      required this.lat,
      required this.lon,
      this.images,
      this.status,
        this.reviewList
      });

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
        images: [],
        reviewList: []
    );
    List<String> images;
    List list = json['images'];
    if(list.isNotEmpty){
      images = List.generate(list.length, (i) => list[i]['image']);
      place.images = images;
    }
    else{
      place.images!.add( "/null");
    }
    List<ReviewEntity> reviews;
    list = json["review"];
    if(list.isNotEmpty){
      reviews = List.generate(list.length, (i) => ReviewEntity.fromJson(list[i]));
      place.reviewList = reviews;
    }
    log(place.reviewList![0].commentary);
    return place;
  }
}

