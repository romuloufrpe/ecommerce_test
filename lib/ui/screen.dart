import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:historias/component/theme.dart' as Theme;
import 'package:historias/component/carosel.dart';
import 'package:historias/component/horizontal_listView.dart';
import 'package:historias/component/products.dart';
import 'package:historias/pages/cart.dart';

class ScreenWidget extends StatefulWidget {
  final Function onTap;

  const ScreenWidget({Key key, this.onTap}) : super(key: key);

  @override
  _DrawerWidgetState createState() => new _DrawerWidgetState();
}

class _DrawerWidgetState extends State<ScreenWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.1,
        backgroundColor: Theme.Colors.appBarColor,
        title: Text("Shopping"),
        leading: GestureDetector(
          onTap: widget.onTap,
          child: Icon((FontAwesomeIcons.bars)),
        ),
        actions: <Widget>[
          new IconButton(
            icon: Icon(
              FontAwesomeIcons.search,
              color: Colors.white,
            ),
            onPressed: () {},
          ),
          new IconButton(
            icon: Icon(
              FontAwesomeIcons.shoppingBasket,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => new Cart()));
            },
          ),
        ],
      ),
      body: new Column(
        children: <Widget>[
          CaroselPage,
/*
          new Padding(
            padding: const EdgeInsets.all(8.0),
            child: new Text("Categorias"),
          ),

          //Horizontal List
          HorizontalList(),
*/
          new Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              alignment: Alignment.centerLeft,
              child: new Text("Recentes",
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0)),
            ),
          ),
          Flexible(child: Products()),
        ],
      ),
    );
  }
}
