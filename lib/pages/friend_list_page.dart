import 'dart:developer';

import 'package:active_tourist_app/manager/service.dart';
import 'package:flutter/material.dart';

import '../entity/profile_entity.dart';
import '../widgets/app_bar.dart';
import '../widgets/friend_card.dart';

class FriendsListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: TopBar("Друзья", true, true),
      ),
      body: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
          child: StreamBuilder<List<ProfileEntity>>(
              stream: Service().getFriendsList(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, i) {
                      return FriendCard(
                        id: snapshot.data![i].id.toInt(),
                        title:
                            "${snapshot.data![i].firstName.toString()} ${snapshot.data![i].lastName.toString()}",
                        image: snapshot.data![i].image.toString(),
                      );
                    },
                  );
                } else {
                  return LinearProgressIndicator();
                }
              })),
    );
  }
}
