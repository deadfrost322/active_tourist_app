import 'dart:developer';
import 'package:active_tourist_app/entity/news_entity.dart';
import 'package:active_tourist_app/entity/place_entity.dart';
import 'package:active_tourist_app/entity/profile_entity.dart';
import 'package:active_tourist_app/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Service {
  String token =
      "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNjUzNDAwODM0LCJqdGkiOiJkZGRlZjg2NDk1ZGI0NDYyYTgwYTkyN2FiN2RiNTNkMCIsInVzZXJfaWQiOjR9.1f55PaPyCMj9IsMvPG7yBPBrNuywJvQSwErToEEV37k";
  String url = 'http://26.249.56.39:8000/api/';

  void login(String username, String password, BuildContext context) async {
    String loginUrl = url + "login";
    var body = jsonEncode({"username": username, "password": password});
    var response = await http.post(Uri.parse(loginUrl),
        headers: {"Content-Type": "application/json"}, body: body);
    log(response.statusCode.toString());
    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      log(data["access"]);
    }
  }

  void registration(String username, String email, String password,
      BuildContext context) async {
    String registerUrl = url + "register";
    var body = jsonEncode(
        {"username": username, "email": email, "password": password});
    var response = await http.post(Uri.parse(registerUrl),
        headers: {"Content-Type": "application/json"}, body: body);
    log(response.statusCode.toString());
    if (response.statusCode == 201) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const LoginPage()));
    }
  }

  Stream<List<NewsEntity>> getNewsList() async* {
    String allNewsUrl = url + "news/all";
    var response = await http.get(
      Uri.parse(allNewsUrl),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      },
    );
    log(response.statusCode.toString());
    if (response.statusCode == 200) {
      List<dynamic> list = json.decode(utf8.decode(response.body.codeUnits));
      List<NewsEntity> news = List.generate(list.length, (i) {
        return NewsEntity.fromJsonShort(list[i]);
      });
      yield news;
    } else {
      throw "FAILED TO LOAD NEWS";
    }
  }

  Stream<NewsEntity> getNews(int id) async* {
    String newsUrl = url + "news/$id";
    var response = await http.get(
      Uri.parse(newsUrl),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      },
    );
    log(response.statusCode.toString());
    if (response.statusCode == 200) {
      var data = json.decode(utf8.decode(response.body.codeUnits));

      yield NewsEntity.fromJsonFull(data);
    } else {
      throw "FAILED TO LOAD NEWS";
    }
  }

  Future<List<PlaceEntity>> getPlaceList() async {
    String allPlaceUrl = url + "place/all";
    var response = await http.get(
      Uri.parse(allPlaceUrl),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      },
    );
    log(response.statusCode.toString());
    if (response.statusCode == 200) {
      List<dynamic> list = json.decode(utf8.decode(response.body.codeUnits));

      List<PlaceEntity> places = List<PlaceEntity>.generate(
          list.length, (i) => PlaceEntity.fromJsonShort(list[i]));

        return places;
      } else {
      throw "FAILED TO LOAD PLACES";
    }
  }

  Stream<PlaceEntity> getPlace(int id) async* {
    String placeUrl = url + "place/$id";
    var response = await http.get(
      Uri.parse(placeUrl),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      },
    );
    log(response.statusCode.toString());
    if (response.statusCode == 200) {
      var data = json.decode(utf8.decode(response.body.codeUnits));
      PlaceEntity place = PlaceEntity.fromJsonFull(data);
      String statusUrl = url + "profile_place/$id";
      var response2 = await http.get(
        Uri.parse(statusUrl),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token"
        },
      );
      if (response2.statusCode == 200) {
        var data2 = json.decode(utf8.decode(response2.body.codeUnits));
        if (data2['status'].toString().isNotEmpty &&
            (data2['status'] != "Нет статуса")) {
          place.status = data2['status'];
        }
        yield place;
      } else {
        yield place;
      }
    } else {
      throw "FAILED TO LOAD NEWS";
    }
  }

  Stream<ProfileEntity> getProfile() async* {
    String profileUrl = url + "profile/read";
    var response = await http.get(
      Uri.parse(profileUrl),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      },
    );
    log(response.statusCode.toString());
    if (response.statusCode == 200) {
      var data = json.decode(utf8.decode(response.body.codeUnits));
      ProfileEntity profile = ProfileEntity.fromJson(data);
      yield profile;
    } else {
      throw "FAILED TO LOAD PROFILE";
    }
  }

  Stream<List<PlaceEntity>> getFilteredPlaces(String filter) async* {
    String allPlaceUrl = url + "place/all";
    var response = await http.get(
      Uri.parse(allPlaceUrl),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      },
    );
    log(response.statusCode.toString());
    if (response.statusCode == 200) {
      List<dynamic> list = json.decode(utf8.decode(response.body.codeUnits));
      String profilePlaceUrl = url + "profile_place/all";
      var response2 = await http.get(
        Uri.parse(profilePlaceUrl),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token"
        },
      );
      if (response2.statusCode == 200) {
        List<dynamic> list2 =
            json.decode(utf8.decode(response2.body.codeUnits));
        List<PlaceEntity> result = [];

        if (filter == "") {
          for (int j = 0; j < list2.length; j++) {
            for (int i = 0; i < list.length; i++) {
              if ((list[i]['id'] == list2[j]['place']) &&
                  (list2[j]['status'] != "Не интересно") &&
                  (list2[j]['status'] != "Нет статуса")) {
                result.add(PlaceEntity.fromJsonShort(list[i]));
              }
            }
          }
        } else {
          for (int j = 0; j < list2.length; j++) {
            for (int i = 0; i < list.length; i++) {
              if (list[i]['id'] == list2[j]['place'] &&
                  list2[j]['status'] == filter) {
                result.add(PlaceEntity.fromJsonShort(list[i]));
              }
            }
          }
        }
        yield result;
      }
    } else {
      throw "FAILED TO LOAD PLACES";
    }
  }

  void profilePlaceUpdate(int id, String status) async {
    String profilePlaceUpdateUrl = url + "profile_place/update/$id";
    var body = jsonEncode({"status": status});
    var response = await http.patch(Uri.parse(profilePlaceUpdateUrl),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token"
        },
        body: body);
    log("u" + response.statusCode.toString());
    if (response.statusCode != 200) {
      String profilePlaceCreateUrl = url + "profile_place/create/$id";
      var body2 = jsonEncode({"status": status});
      var response2 = await http.post(Uri.parse(profilePlaceCreateUrl),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token"
          },
          body: body2);
      log("c" + response2.statusCode.toString());
    }
  }

  Stream<List<ProfileEntity>> getFriendsList() async* {
    String friendListUrl = url + "friendship/all";
    var response = await http.get(
      Uri.parse(friendListUrl),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      },
    );
    log(response.statusCode.toString());
    if (response.statusCode == 200) {
      List<dynamic> list = json.decode(utf8.decode(response.body.codeUnits));
      List<ProfileEntity> friends =
          List.generate(list.length, (i) => ProfileEntity.fromJson(list[i]));
      yield friends;
    } else {
      throw "FAILED TO LOAD FRIENDS";
    }
  }

  Stream<List<ProfileEntity>> getFriendsPlaces() async* {
    String friendPlacesUrl = url + "friendship/places";
    var response = await http.get(
      Uri.parse(friendPlacesUrl),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      },
    );
    log(response.statusCode.toString());
    if (response.statusCode == 200) {
      List<dynamic> list = json.decode(utf8.decode(response.body.codeUnits));
      log(list.toString());
      List<ProfileEntity> friendsPlaces =
          List.generate(list.length, (i) => ProfileEntity.fromJson(list[i]));
      yield friendsPlaces;
    } else {
      throw "FAILED TO LOAD FRIEND'S PLACES";
    }
  }

  void createFriendship(String code, int id) async{
    String friendshipUrl = url + 'friendship/create?code=$code';
    var response = await http.post(
      Uri.parse(friendshipUrl),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      },
    );
    log(response.statusCode.toString());
  }
}
