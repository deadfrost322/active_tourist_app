import 'dart:async';
import 'dart:developer';

import 'package:active_tourist_app/entity/news_entity.dart';
import 'package:active_tourist_app/widgets/app_bar.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../manager/service.dart';



class FullNewsPage extends StatelessWidget {
  FullNewsPage(this.id);

  int id;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: TopBar("Новость", true, true)),
      body: StreamBuilder<NewsEntity>(
        stream: Service().getNews(id),
        builder: (context, snapshot) {
          if(snapshot.hasData){
            log(snapshot.data!.images.toString());
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  CarouselSlider.builder(
                    itemCount: (snapshot.data!.images!.length),
                    itemBuilder:
                        (BuildContext context, int itemIndex, int pageViewIndex) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 14),
                        child:SizedBox(
                            width: 420,
                            child: FadeInImage.assetNetwork(
                              imageErrorBuilder: (BuildContext context,
                                  Object exception, StackTrace? stackTrace) {
                                return Image.asset(
                                    "assets/image/big_media.png",
                                    fit: BoxFit.scaleDown);
                              },
                              fit: BoxFit.scaleDown,
                              placeholderFit: BoxFit.scaleDown,
                              image: "http://26.249.56.39:8000" +
                                  (snapshot.data!.images![itemIndex]),
                              placeholder: "assets/image/big_media.png",
                            )),
                      );
                    },
                    options: CarouselOptions(
                      height: 260,
                      autoPlay: false,
                      enlargeCenterPage: true,
                      viewportFraction: 0.9,
                      aspectRatio: 2.0,
                      initialPage: 2,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 14, 20, 0),
                    child: Wrap(
                      children: [
                        Text(
                          snapshot.data!.title,
                          style: GoogleFonts.manrope(
                              fontSize: 27, fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 6, 20, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          snapshot.data!.category,
                          style: GoogleFonts.manrope(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Colors.black45),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 6, 20, 20),
                    child: Wrap(
                      children: [
                        Text(
                          snapshot.data!.content!,
                          style: GoogleFonts.manrope(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: const Color.fromRGBO(73, 69, 79, 1)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
         else{
           return LinearProgressIndicator();
          }
        }
      ),
    );
  }


}
