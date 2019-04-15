import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:historias/component/theme.dart' as Theme;
import 'package:historias/component/cart_products.dart';

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.1,
        backgroundColor: Theme.Colors.appBarColor,
        centerTitle: true,
        title: Text("Carrinho"),
        actions: <Widget>[
          new IconButton(
            icon: Icon(
              FontAwesomeIcons.search,
              color: Colors.white,
            ),
            onPressed: () {},
          ),
        ],
      ),

      body: new Cart_products(),



      bottomNavigationBar: new Container(
        color: Colors.white,
        child: Row(
          children: <Widget>[
            Expanded(
                child: ListTile(
              title: new Text("Total:"),
              subtitle: new Text("\R\$230"),
            )),
            Expanded(
              child: new MaterialButton(
                onPressed: () {},
                child: new Text("Finalizar",
                    style: TextStyle(color: Colors.white)),
                color: Colors.red,
              ),
            )
          ],
        ),
      ),
    );
  }
}
