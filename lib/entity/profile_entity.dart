import 'dart:developer';
import 'package:active_tourist_app/entity/place_entity.dart';

class ProfileEntity {
  int id;
  String? lastName;
  String? firstName;
  String? image;
  String? friendCode;
  List<PlaceEntity>? places;
  ProfileEntity({required this.id, this.lastName, this.firstName, this.image, this.friendCode, this.places});

  factory ProfileEntity.fromJson(Map<String, dynamic>json){
    ProfileEntity profile = ProfileEntity(
        id: json['id'],
        lastName: json['last_name'],
        firstName: json['first_name'],
        image: json['image'],
        friendCode: json['friend_code'],
    );

    if(json.containsKey('places')){
      List list = json['places'];
      List<PlaceEntity> places = List.generate(list.length, (i) => PlaceEntity.fromJsonShort(list[i]['place']));
      for (int i = 0; i<places.length; i++){
        places[i].status = list[i]['status'];
      }
      profile.places = places;
    }
    return profile;
  }
}
