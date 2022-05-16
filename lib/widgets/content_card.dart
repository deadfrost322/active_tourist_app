import 'package:active_tourist_app/pages/full_content_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../pages/full_news_page.dart';

class ContentCard extends StatelessWidget {
  ContentCard({required this.id, required this.title, required this.category, this.image, required this.isNews});

  int id;
  String title;
  String category;
  String? image;
  bool isNews;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        isNews == true
            ? Navigator.push(context,
                MaterialPageRoute(builder: (context) => FullNewsPage(id)))
            : Navigator.push(context,
                MaterialPageRoute(builder: (context) => FullContentPage(id)));
      },
      child: Card(
        color: const Color.fromRGBO(255, 251, 254, 1.0),
        shape: RoundedRectangleBorder(
            side: const BorderSide(color: Color.fromRGBO(121, 116, 126, 1)),
            borderRadius: BorderRadius.circular(15)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title:
                  Wrap(children: [Text(title, style: GoogleFonts.manrope())]),
              subtitle: Text(category, style: GoogleFonts.manrope()),
              trailing: Visibility(
                visible: isNews,
                child: ConstrainedBox(
                    constraints: BoxConstraints(maxHeight: 80, maxWidth: 80),
                    child: FadeInImage.assetNetwork(
                      height: 80,
                      width: 80,
                      fit: BoxFit.scaleDown,
                      placeholderFit: BoxFit.scaleDown,
                      image: "http://26.249.56.39:8000$image",
                      placeholder: "assets/image/media.png",
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
