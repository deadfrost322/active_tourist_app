import 'dart:developer';

import 'package:active_tourist_app/entity/place_entity.dart';
import 'package:active_tourist_app/manager/service.dart';
import 'package:active_tourist_app/widgets/app_bar.dart';
import 'package:active_tourist_app/widgets/content_card.dart';
import 'package:flutter/material.dart';

class ListPage extends StatefulWidget {

  @override
  State<ListPage> createState() => ListPageState();
}

class ListPageState extends State<ListPage> {

  ValueNotifier<String> filter = ValueNotifier<String>("");

  TextEditingController searchController = TextEditingController();

  setFilter(){
    if(isSelected[0] == true){
      setState(() {
        filter.value = "Собираюсь посетить";
      });
    }
    if(isSelected[1] == true){
      setState(() {
        filter.value = "Посещено";
      });
    }
  }

  List<bool> isSelected = List.generate(2, (_) => false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: TopBar("Списки", false, true),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
        child: ValueListenableBuilder<String>(
          valueListenable: filter,
            builder: (BuildContext context, String value, Widget? child) {
            return StreamBuilder<List<PlaceEntity>>(
                stream: Service().getFilteredPlaces(filter.value),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: snapshot.data!.length+1,
                      itemBuilder: (context, i) {
                        if(i==0){
                          return Center(
                            child: ToggleButtons(
                              children: const <Widget>[
                                Text("Собираюсь посетить"),
                                Text("Посещено")
                              ],
                              borderRadius: const BorderRadius.all(Radius.circular(15)),
                              onPressed: (int index) {
                                setState(() {
                                  for (int buttonIndex = 0; buttonIndex < isSelected.length; buttonIndex++) {
                                    if (buttonIndex == index) {
                                      isSelected[buttonIndex] = !isSelected[buttonIndex];
                                    } else {
                                      isSelected[buttonIndex] = false;
                                    }
                                  }
                                });
                                setFilter();
                                log(filter.value);
                              },
                              isSelected: isSelected,
                            ),
                          );
                        }
                        else{
                          return ContentCard(id: snapshot.data![i-1].id!.toInt(),
                            title: snapshot.data![i-1].name,
                            category: snapshot.data![i-1].category,
                            isNews: false,);
                        }
                      },
                    );
                  }
                  else {
                    return const LinearProgressIndicator();
                  }
                }
            );
          }
        ),
      ),
    );
  }
}
