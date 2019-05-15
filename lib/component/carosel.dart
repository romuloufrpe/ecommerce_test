import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';

Widget CaroselPage = new Container(
  height: 200.0,
  child: new Carousel(
    boxFit: BoxFit.cover,
    images: [
      AssetImage('assets/img/c2.jpeg'),
      AssetImage('assets/img/c4.jpg'),
      AssetImage('assets/img/c5.jpg'),
    ],
    autoplay: false,
    animationCurve: Curves.fastOutSlowIn,
    animationDuration: Duration(milliseconds: 1000),
    dotSize: 4.0,
    indicatorBgPadding: 4.0,
    dotBgColor: Colors.transparent,
  ),
);
