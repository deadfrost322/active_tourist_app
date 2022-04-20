import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FriendCard extends StatelessWidget {
  FriendCard({required this.id, required this.title, this.image});

  int id;
  String title;
  String? image;

  @override
  Widget build(BuildContext context) {
    return Card(

      color: const Color.fromRGBO(255, 251, 254, 1),
      shape: RoundedRectangleBorder(
          side: const BorderSide(color: Color.fromRGBO(121, 116, 126, 1)),
          borderRadius: BorderRadius.circular(15)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: CircleAvatar(
              maxRadius: 20,
              minRadius: 20,
              backgroundColor: const Color.fromRGBO(103, 80, 164, 1),
              foregroundImage:
                  NetworkImage("http://26.249.56.39:8000" + image.toString(),scale: 10),
              child: Text(
                title.toString().split("")[0],
                style: GoogleFonts.roboto(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
              ),
            ),
            title: Wrap(children: [Text(title, style: GoogleFonts.manrope())]),
          ),
        ],
      ),
    );
  }
}
