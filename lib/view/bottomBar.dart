import 'package:flutter/material.dart';
import 'package:weather/view/searchPage.dart';
import 'homePage.dart';

class BottomBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      height: 80,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF3E2D8F), Color(0xFF8E78C8)],
        ),
        boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.4),
              spreadRadius: 1,
              blurRadius: 8,
            )
      ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: Icon(Icons.home),
            color: Colors.white,
            iconSize: 35,
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => Homepage()));
            },
          ),
          IconButton(
            icon: Icon(Icons.search),
            color: Colors.white,
            iconSize: 35,
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => Searchpage()));
            },
          ),
        ],
      ),
    );
  }
}