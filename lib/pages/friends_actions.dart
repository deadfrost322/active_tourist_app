import 'package:active_tourist_app/widgets/content_card.dart';
import 'package:flutter/material.dart';
import '../entity/profile_entity.dart';
import '../manager/service.dart';
import '../widgets/app_bar.dart';
import '../widgets/friend_card.dart';

class FriendsActionsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: TopBar("Действия друзей", true, true),
      ),
      body: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
          child: StreamBuilder<List<ProfileEntity>>(
              stream: Service().getFriendsPlaces(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, i) {
                      return Column(
                        children: [
                          FriendCard(
                            id: snapshot.data![i].id.toInt(),
                            title:
                                "${snapshot.data![i].firstName!} ${snapshot.data![i].lastName!}",
                            image: snapshot.data![i].image.toString(),
                          ),
                          ContentCard(
                            isNews: false,
                            category: snapshot.data![i].places![0].category.toString()
                                .toString(),
                            id: snapshot.data![i].places![0].id!.toInt(),
                            title: snapshot.data![i].places![0].name.toString(),
                          ),
                        ],
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
