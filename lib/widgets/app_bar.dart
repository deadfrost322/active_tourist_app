import 'package:flutter/material.dart';

import '../pages/profile_page.dart';

class TopBar extends StatelessWidget {
  TopBar(this.title, this.showBackAction, this.showAccountButton );
  final String title;
  final bool showBackAction;
  final bool showAccountButton;

  @override
  Widget build(BuildContext context) {
    return AppBar(

      leading: Visibility(
        visible: showBackAction,
        child: IconButton(
          icon: const Icon(Icons.arrow_back_outlined),
          onPressed: () {Navigator.pop(context);},
        ),
      ),
      actions: [
        Visibility(
          visible: showAccountButton,
          child: IconButton(
            icon: const Icon(Icons.account_circle_outlined),
            onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfilePage()));},
          ),
        ),
      ],
      title: Text(title),
    );
  }
  
}
