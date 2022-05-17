import 'dart:async';
import 'dart:developer';

import 'package:active_tourist_app/entity/place_entity.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:active_tourist_app/manager/service.dart';
import 'package:active_tourist_app/widgets/app_bar.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class FullContentPage extends StatefulWidget {
  int id;

  @override
  State<FullContentPage> createState() => _FullContentPageState(id);

  FullContentPage(this.id);
}

class _FullContentPageState extends State<FullContentPage> {
  _FullContentPageState(this.id);

  int id;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  ValueNotifier<String> _dropdownValue = ValueNotifier("");

  late GoogleMapController mapController;
  Completer<GoogleMapController> completer = Completer();

  void _onMapCreated(GoogleMapController controller, double lat, double lon,
      String placeName) {
    mapController = controller;
    completer.complete(mapController);
    final marker = Marker(
      markerId: MarkerId('place_name'),
      position: LatLng(lat, lon),
      // icon: BitmapDescriptor.,
      infoWindow: InfoWindow(
        title: placeName,
      ),
    );

    setState(() {
      markers[MarkerId('place_name')] = marker;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: TopBar("Подробнее", true, true)),
      body: ValueListenableBuilder<String>(
          valueListenable: _dropdownValue,
          builder: (BuildContext context, String value, Widget? child) {
            return StreamBuilder<PlaceEntity>(
                stream: Service().getPlace(id),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      physics: BouncingScrollPhysics(),
                        itemCount: (snapshot.data!.reviewList!.isEmpty ? 0 : snapshot.data!.reviewList!.length) + 1 ,
                        itemBuilder: (context, i){
                      if (i == 0){
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CarouselSlider.builder(
                              itemCount: snapshot.data!.images!.length,
                              itemBuilder: (BuildContext context, int itemIndex,
                                  int pageViewIndex) {
                                return Padding(
                                  padding: const EdgeInsets.only(top: 14),
                                  child: SizedBox(
                                      width: 420,
                                      child: FadeInImage.assetNetwork(
                                        imageErrorBuilder: (BuildContext context,
                                            Object exception,
                                            StackTrace? stackTrace) {
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
                              child: Wrap(children: [
                                Text(
                                  snapshot.data!.name,
                                  style: GoogleFonts.manrope(
                                      fontSize: 27, fontWeight: FontWeight.w700),
                                ),
                              ]),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                              child: DropdownButton<String>(
                                value: snapshot.data!.status,
                                icon: const Icon(Icons.arrow_drop_down),
                                elevation: 16,
                                style: const TextStyle(color: Colors.deepPurple),
                                underline: Container(
                                  height: 2,
                                  color: Colors.deepPurpleAccent,
                                ),
                                items: <String>[
                                  'Собираюсь посетить',
                                  'Посещено',
                                  'Не интересно'
                                ].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  Service().profilePlaceUpdate(id, value!);
                                  log(value.toString());
                                  setState(() {
                                    _dropdownValue.value = value.toString();
                                  });
                                },
                                hint: Text(
                                  "Добавить в список",
                                  style: GoogleFonts.manrope(),
                                ),
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
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(0, 10, 0, 20),
                                child: SizedBox(
                                  width: 350,
                                  height: 400,
                                  child: GoogleMap(
                                    mapType: MapType.terrain,
                                    onMapCreated: (controller) {
                                      _onMapCreated(
                                          controller, snapshot.data!.lat,
                                          snapshot.data!.lon,
                                          snapshot.data!.name);
                                    },
                                    initialCameraPosition: CameraPosition(
                                      target: LatLng(
                                          snapshot.data!.lat, snapshot.data!.lon),
                                      zoom: 14,
                                    ),
                                    markers: markers.values.toSet(),
                                  ),
                                ),
                              ),
                            ),

                          ],
                        );
                      }
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Card(
                          margin: const EdgeInsets.all(5),
                          color: const Color.fromRGBO(255, 251, 254, 1.0),
                          shape: RoundedRectangleBorder(
                              side: const BorderSide(color: Color.fromRGBO(121, 116, 126, 1)),
                              borderRadius: BorderRadius.circular(15)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RatingBar(
                                  itemSize: 20,
                                  initialRating: snapshot.data!.reviewList![i-1].likeScale!.toDouble(),
                                  ratingWidget: RatingWidget(
                                    full: Icon(Icons.star, size: 2,),
                                    half: Icon(Icons.star_half, size: 2,),
                                    empty: Icon(Icons.star_border, size: 2,),
                                  ), onRatingUpdate: (double value) {
                                    log(value.toString());
                                },
                                ),

                                Text(snapshot.data!.reviewList![i-1].commentary.toString(),
                                style: GoogleFonts.manrope(
                                  fontSize: 14,
                                ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }
                    );
                  } else {
                    return LinearProgressIndicator();
                  }
                });
          }
      ),
    );
  }
}
