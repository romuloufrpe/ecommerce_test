import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';

Widget CaroselProduct = new Container(
  height: 200.0,
  child: new Carousel(
    boxFit: BoxFit.cover,
    images: [
      new NetworkImage(
          'https://www.elhombre.com.br/wp-content/uploads/2016/10/1-MM-1.jpg'),
      AssetImage('assets/img/c2.jpeg'),
      AssetImage('assets/img/c4.jpg'),
      AssetImage('assets/img/c5.jpg'),
    ],
    animationCurve: Curves.fastOutSlowIn,
    animationDuration: Duration(milliseconds: 1000),
    dotSize: 4.0,
    indicatorBgPadding: 4.0,
    dotBgColor: Colors.transparent,
  ),
);
