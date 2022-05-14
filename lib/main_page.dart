import 'package:active_tourist_app/pages/home_page.dart';
import 'package:active_tourist_app/pages/list_page.dart';
import 'package:active_tourist_app/pages/search_page.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int pageIndex = 0;
  PageController pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      bottomNavigationBar: NavigationBar(
        selectedIndex: pageIndex,
        onDestinationSelected: (index) {
          setState(() {
            pageIndex = index;
            pageController.animateToPage(pageIndex,
                duration: const Duration(milliseconds: 300),
                curve: Curves.fastOutSlowIn);
          });
        },

        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            label: 'Главная',
          ),
          NavigationDestination(
            icon: Icon(Icons.location_on_outlined),
            label: 'Места',
          ),
          NavigationDestination(
            icon: Icon(Icons.format_list_bulleted),
            label: 'Списки',
          ),
        ],
      ),
      body: PageView(
        physics: BouncingScrollPhysics(),
        onPageChanged: (index) {
          setState(() {
            pageIndex = index;
          });
        },
        controller: pageController,
        children: [
          HomePage(),
          SearchPage(),
          ListPage()
        ],
      ),
    );
  }
}
