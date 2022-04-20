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

  ValueNotifier<String> search = ValueNotifier<String>("");

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
        child: StreamBuilder<List<PlaceEntity>>(
            stream: Service().getPlaceList(search.value),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ValueListenableBuilder<String>(
                    valueListenable: search,
                    builder:
                        (BuildContext context, String value, Widget? child) {
                      return ListView.builder(
                        physics: BouncingScrollPhysics(),
                        itemCount: snapshot.data!.length + 1,
                        itemBuilder: (context, i) {
                          if (i == 0) {
                            return Padding(
                              padding: const EdgeInsets.all(6),
                              child: TextFormField(
                                style: GoogleFonts.manrope(),
                                controller: searchController,
                                decoration: InputDecoration(
                                  suffixIcon: InkWell(
                                      onTap: () {
                                        setState(() {
                                          search.value = searchController.text;
                                        });
                                      },
                                      child: const Icon(
                                        Icons.search,
                                        color: Colors.black45,
                                      )),
                                  focusColor: Color(0xFF6200EE),
                                  hintText: 'Поиск',
                                  labelText: 'Поиск',
                                  border: const OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15))),
                                ),
                              ),
                            );
                          }
                          return ContentCard(
                            id: snapshot.data![i - 1].id!.toInt(),
                            title: snapshot.data![i - 1].name,
                            category: snapshot.data![i - 1].category,
                            isNews: false,
                          );
                        },
                      );
                    });
              } else {
                return LinearProgressIndicator();
              }
            }),
      ),
    );
  }
}
