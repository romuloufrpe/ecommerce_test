import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:historias/pages/product_details.dart';

class HorizontalList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.0,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          Category(
            image_location: 'assets/cat/t_shirt.png',
            image_capiton: 'shirt',
          ),
          Category(
            image_location: 'assets/cat/Jeans-icon.png',
            image_capiton: 'jeans',
          ),
          Category(
            image_location: 'assets/cat/formal.png',
            image_capiton: 'formal',
          ),
          Category(
            image_location: 'assets/cat/shoe.png',
            image_capiton: 'shoe',
          ),
          Category(
            image_location: 'assets/cat/dress.png',
            image_capiton: 'dress',
          ),
          Category(
            image_location: 'assets/cat/accessories.png',
            image_capiton: 'accessories',
          ),
        ],
      ),
    );
  }
}

class Category extends StatelessWidget {
  final String image_location;
  final String image_capiton;

  Category({this.image_location, this.image_capiton});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: InkWell(
        onTap: () {},
        child: Container(
          width: 100.0,
          child: ListTile(
            title: Image.asset(
              image_location,
              width: 100.0,
              height: 80.0,
            ),
            subtitle: Container(
              alignment: Alignment.topCenter,
              child: Text(image_capiton),
            ),
          ),
        ),
      ),
    );
  }
}
