import 'dart:developer';

import 'package:active_tourist_app/manager/service.dart';
import 'package:active_tourist_app/widgets/app_bar.dart';
import 'package:active_tourist_app/widgets/content_card.dart';
import 'package:flutter/material.dart';

import '../entity/news_entity.dart';

class NewsPage extends StatefulWidget {
  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: TopBar("Новости", true, true),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
        child: StreamBuilder<List<NewsEntity>>(
            stream: Service().getNewsList(),
            builder: (context, snapshot) {
              log(snapshot.hasData.toString());
              if (snapshot.hasData) {
                return ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, i) {
                    return ContentCard(
                      id: snapshot.data![i].id,
                      title: snapshot.data![i].title,
                      category: snapshot.data![i].category,
                      image: snapshot.data![i].image.toString(),
                      isNews: true,
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
