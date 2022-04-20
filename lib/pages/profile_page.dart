import 'package:active_tourist_app/entity/profile_entity.dart';
import 'package:active_tourist_app/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../manager/service.dart';

class ProfilePage extends StatelessWidget {

  TextEditingController codeController = TextEditingController();

  late String? code;
  late int? id;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: TopBar("Аккаунт", true, false),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(38, 40, 48, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StreamBuilder<ProfileEntity>(
                stream: Service().getProfile(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    code = snapshot.data!.friendCode.toString();
                    id = snapshot.data!.id;
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircleAvatar(
                          minRadius: 50,
                          backgroundColor:
                              const Color.fromRGBO(103, 80, 164, 1),
                          foregroundImage: NetworkImage(
                              "http://26.249.56.39:8000" +
                                  snapshot.data!.image.toString()),
                          child: Text(
                            snapshot.data!.firstName.toString().split("")[0],
                            style: GoogleFonts.roboto(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          ),
                        ),
                        Column(
                          children: [
                            Wrap(
                              children: [
                                Text(
                                  "${snapshot.data!.firstName!}  ${snapshot.data!.lastName!}",
                                  style: GoogleFonts.manrope(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black),
                                )
                              ],
                            ),
                          ],
                        ),
                      ],
                    );
                  } else {
                    return LinearProgressIndicator();
                  }
                }),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          minimumSize: const Size(147, 59),
                          primary: Colors.white,
                          side: const BorderSide(
                              color: Color.fromRGBO(121, 116, 126, 1))),
                        onPressed: () => showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: const Text('Код для друзей'),

                            content: Text('Ваш код: ${code}'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () => Navigator.pop(context, 'OK'),
                                child: const Text('OK'),
                              ),
                            ],
                          ),
                        ),
                      child: Text(
                        "Показать код",
                        style: GoogleFonts.manrope(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: const Color.fromRGBO(103, 80, 164, 1)),
                      )),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          minimumSize: const Size(147, 59),
                          primary: const Color.fromRGBO(103, 80, 164, 1),
                          side: const BorderSide(
                              color: Color.fromRGBO(121, 116, 126, 1))),
                      onPressed: () => showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: const Text('Добавить друга'),

                          content: TextFormField(
                            style: GoogleFonts.manrope(),
                            controller: codeController,
                            decoration: const InputDecoration(
                              focusColor: Color(0xFF6200EE),
                              hintText: 'Код друга',
                              labelText: 'Код друга',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(15))),
                            ),
                          ),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.pop(context, 'Отмена'),
                              child: const Text('Отмена'),
                            ),
                            TextButton(
                              onPressed: () {
                                Service().createFriendship(codeController.text, id!);
                                Navigator.pop(context, 'OK');
                              },
                              child: const Text('Добавить'),
                            ),
                          ],
                        ),
                      ),
                      child: Text(
                        "Добавить друга",
                        style: GoogleFonts.manrope(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
