import 'package:active_tourist_app/entity/place_entity.dart';
import 'package:active_tourist_app/manager/service.dart';
import 'package:active_tourist_app/pages/friends_actions.dart';
import 'package:active_tourist_app/widgets/app_bar.dart';
import 'package:active_tourist_app/widgets/content_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'friend_list_page.dart';
import 'news_page.dart';


class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: TopBar("Главная", false, true)),
        body: StreamBuilder<List<PlaceEntity>>(
            stream: Service().getFilteredPlaces("Посещено"),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: snapshot.data!.length + 1,
                    itemBuilder: (BuildContext context, int i) {
                      if (i == 0) {
                        return Padding(
                          padding: const EdgeInsets.all(20),
                          child: Wrap(
                            runSpacing: 20,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween,
                                children: [
                                  ElevatedButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context, MaterialPageRoute(
                                            builder: (context) => NewsPage()));
                                      },
                                      child: Text(
                                        "Новости",
                                        style: GoogleFonts.manrope(
                                            color: Colors.black),
                                      ),
                                      style: ButtonStyle(
                                          fixedSize: MaterialStateProperty.all<
                                              Size>(Size(145, 130)),
                                          backgroundColor: MaterialStateProperty
                                              .all<Color>(
                                              const Color.fromRGBO(
                                                  255, 251, 254, 1)),
                                          shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                                  borderRadius: BorderRadius
                                                      .circular(15),
                                                  side: const BorderSide(
                                                      color: Color.fromRGBO(
                                                          121, 116, 126,
                                                          1)))))),
                                  ElevatedButton(
                                      onPressed: () {
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    FriendsListPage()));
                                      },
                                      child: Text(
                                        "Друзья",
                                        style: GoogleFonts.manrope(
                                            color: Colors.black),
                                      ),
                                      style: ButtonStyle(
                                          fixedSize: MaterialStateProperty.all<
                                              Size>(Size(150, 130)),
                                          backgroundColor: MaterialStateProperty
                                              .all<Color>(
                                              const Color.fromRGBO(
                                                  255, 251, 254, 1)),
                                          shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                                  borderRadius: BorderRadius
                                                      .circular(15),
                                                  side: const BorderSide(
                                                      color: Color.fromRGBO(
                                                          121, 116, 126,
                                                          1)))))),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween,
                                children: [
                                  ElevatedButton(
                                      onPressed: () {
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    FriendsActionsPage()));
                                      },
                                      child: Text(
                                        "Действия друезй",
                                        style: GoogleFonts.manrope(
                                            color: Colors.black),
                                      ),
                                      style: ButtonStyle(
                                          fixedSize: MaterialStateProperty.all<
                                              Size>(Size(352, 108)),
                                          backgroundColor: MaterialStateProperty
                                              .all<Color>(
                                              const Color.fromRGBO(
                                                  255, 251, 254, 1)),
                                          shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                                  borderRadius: BorderRadius
                                                      .circular(15),
                                                  side: const BorderSide(
                                                      color: Color.fromRGBO(
                                                          121, 116, 126,
                                                          1)))))),
                                ],
                              ),
                              Text("Последние действя", style: GoogleFonts
                                  .manrope()),
                            ],
                          ),
                        );
                      }
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: ContentCard(
                          isNews: false,
                          category: snapshot.data![i - 1].category,
                          title: snapshot.data![i - 1].name,
                          id: snapshot.data![i - 1].id!.toInt(),
                        ),
                      );
                    });
              }
              else {
                return const Padding(
                  padding: EdgeInsets.all(16),
                  child: LinearProgressIndicator(),
                );
              }
            }
        ));
  }
}
