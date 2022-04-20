import 'dart:developer';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';

import '../pages/news_page.dart';



class CardButton extends StatelessWidget {
  CardButton(
      {Key? key,
      required this.height,
      required this.width,
      required this.text,
      required this.route})
      : super(key: key);

  final String route;

  final double height;
  final double width;
  final String text;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: setRoute(route, context),
        child: Text(
          text,
          style: GoogleFonts.manrope(color: Colors.black),
        ),
        style: ButtonStyle(
            fixedSize: MaterialStateProperty.all<Size>(Size(width, height)),
            backgroundColor: MaterialStateProperty.all<Color>(
                const Color.fromRGBO(255, 251, 254, 1)),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                    side: const BorderSide(
                        color: Color.fromRGBO(121, 116, 126, 1))))));
  }

  setRoute(String route, BuildContext context) {
    switch (route) {
      case "1":
        SchedulerBinding.instance!.addPostFrameCallback((_) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => NewsPage()));
        });
        //toNews(context);
        log("1");
        break;
      case "2":
        //toRecommendation(context);
        log("2");
        break;
      case "3":
        //toFriendsActions(context);
        log("3");
        break;
      case "4":
        //toFriendsPlans(context);
        log("4");
        break;
      case "5":
        //toPlans(context);
        log("5");
        break;
      default:
        break;
    }
  }

  toNews(BuildContext context) {
    SchedulerBinding.instance!.addPostFrameCallback((_) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => NewsPage()));
    });
    log("1");
  }

  toRecommendation(BuildContext context) {
    SchedulerBinding.instance!.addPostFrameCallback((_) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => NewsPage()));
    });
    log("2");
  }

  toFriendsActions(BuildContext context) {
    SchedulerBinding.instance!.addPostFrameCallback((_) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => NewsPage()));
    });
    log("3");
  }

  toFriendsPlans(BuildContext context) {
    SchedulerBinding.instance!.addPostFrameCallback((_) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => NewsPage()));
    });
    log("4");
  }

  toPlans(BuildContext context) {
    SchedulerBinding.instance!.addPostFrameCallback((_) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => NewsPage()));
    });
    log("5");
  }
}
