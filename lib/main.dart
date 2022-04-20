import 'package:active_tourist_app/main_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        title: 'Active Tourist App',
        theme: ThemeData(
            backgroundColor: Colors.white,
            useMaterial3: true,
            appBarTheme: AppBarTheme(
              elevation: 1,
                centerTitle: true,
                iconTheme: const IconThemeData(color: Colors.black),
                backgroundColor: const Color.fromRGBO(255, 251, 254, 1),
                titleTextStyle: GoogleFonts.manrope(
                  fontSize: 22,
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                )),
            bottomNavigationBarTheme: const BottomNavigationBarThemeData(
              backgroundColor: Color.fromRGBO(243, 237, 247, 1),
              selectedItemColor: Colors.black,
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ))),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50))),
            )),
        home: MainPage());
  }
}

