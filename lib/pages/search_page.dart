import 'package:active_tourist_app/entity/place_entity.dart';
import 'package:active_tourist_app/manager/service.dart';
import 'package:active_tourist_app/widgets/app_bar.dart';
import 'package:active_tourist_app/widgets/content_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => SearchPageState();
}

class SearchPageState extends State<SearchPage> {
  TextEditingController searchController = TextEditingController();

  String search = "";
  //ValueNotifier<String> search = ValueNotifier<String>("");
  List<PlaceEntity> placesRow = [];
  List<PlaceEntity> places = [];

  searchInPlaces(String search, List<PlaceEntity> list) {
    List<PlaceEntity> places = [];
    if (search != "") {
      for (int i = 0; i < list.length; i++) {
        if (list[i].name.toLowerCase().contains(search.toLowerCase()) ||
            (list[i].category.toLowerCase().contains(search.toLowerCase()))) {
          places.add(list[i]);
        }
      }
      return places;
    } else {
      return list;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: TopBar("Места", false, true),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
        child: FutureBuilder<List<PlaceEntity>>(
            future: Service().getPlaceList(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                placesRow = snapshot.data!.toList();
                places = searchInPlaces(search, placesRow);
                return ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: places.length + 1,
                  itemBuilder: (context, i) {
                    if (i == 0) {
                      return Padding(
                        padding: const EdgeInsets.all(6),
                        child: TextField(
                          onChanged: (val) {
                            setState(() {
                              search = searchController.text;
                            });
                          },
                          style: GoogleFonts.manrope(),
                          controller: searchController,
                          decoration: InputDecoration(
                            suffixIcon: InkWell(
                                onTap: () {
                                  setState(() {
                                    search = "";
                                    searchController.text = "";
                                  });
                                },
                                child: const Icon(
                                  Icons.clear,
                                  color: Colors.black45,
                                )),
                            focusColor: const Color(0xFF6200EE),
                            hintText: 'Поиск',
                            labelText: 'Поиск',
                            border: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                          ),
                        ),
                      );
                    }
                    return ContentCard(
                      id: places[i - 1].id!.toInt(),
                      title: places[i - 1].name,
                      category: places[i - 1].category,
                      isNews: false,
                    );
                  },
                );
              } else {
                return LinearProgressIndicator();
              }
            }),
      ),
    );
  }
}
