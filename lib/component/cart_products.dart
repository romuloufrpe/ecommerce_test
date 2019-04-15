import 'package:flutter/material.dart';
import 'package:historias/component/theme.dart' as Theme;

import 'package:historias/component/carosel.dart';

class Cart_products extends StatefulWidget {
  @override
  _Cart_productsState createState() => _Cart_productsState();
}

class _Cart_productsState extends State<Cart_products> {
  var Products_on_the_cart = [
    {
      "name": "Blazer",
      "picture": "assets/products/blazer.jpg",
      "price": 85,
      "size": "M",
      "color": "Black",
      "quantity": 1
    },
    {
      "name": "Jeans Branco",
      "picture": "assets/products/jeans-01.jpg",
      "price": 85,
      "size": "M",
      "color": "Black",
      "quantity": 1
    },
    {
      "name": "Jeans Azul",
      "picture": "assets/products/jeans-02.jpg",
      "price": 85,
      "size": "M",
      "color": "Black",
      "quantity": 1
    },
    
    
    
  ];

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
        itemCount: Products_on_the_cart.length,
        itemBuilder: (context, index) {
          return Single_cart_product(
            cart_prod_name: Products_on_the_cart[index]["name"],
            cart_prod_color: Products_on_the_cart[index]["color"],
            cart_prod_qty: Products_on_the_cart[index]["quantity"],
            cart_prod_size: Products_on_the_cart[index]["size"],
            cart_prod_price: Products_on_the_cart[index]["price"],
            cart_prod_picture: Products_on_the_cart[index]["picture"],
          );
        });
  }
}

class Single_cart_product extends StatelessWidget {
  final cart_prod_name;
  final cart_prod_picture;
  final cart_prod_price;
  final cart_prod_size;
  final cart_prod_color;
  final cart_prod_qty;

  Single_cart_product(
      {this.cart_prod_name,
      this.cart_prod_picture,
      this.cart_prod_price,
      this.cart_prod_size,
      this.cart_prod_color,
      this.cart_prod_qty});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
//      ============ leading section =============
        leading: Image.asset(
          cart_prod_picture,
          width: 60.0,
          height: 60.0,
        ),
//   ================== title section ============
        title: new Text(cart_prod_name),
// ==================== subtitle section =========
        subtitle: new Column(
          children: <Widget>[
//            ROW INSIDE THE COLUM
            new Row(
              children: <Widget>[
//          =============== this section of fro the product size
                Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: new Text("Tamanho:"),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: new Text(cart_prod_size,
                      style: TextStyle(color: Theme.Colors.appBarColor)),
                ),
//          ================ this section of for the product color
               Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: new Text("Cor:"),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: new Text(cart_prod_color,
                      style: TextStyle(color: Theme.Colors.appBarColor)),
                ),
              ],
            ),

//           ============ this section is for the product price =============
            new Container(
              alignment: Alignment.topLeft,
              child: new Text(
                "\R\$${cart_prod_price}",
                style: TextStyle(
                    color: Theme.Colors.appBarColor,
                    fontSize: 17.0,
                    fontWeight: FontWeight.bold
                ),
              ),
            ),
          ],
        ),
        trailing: new Column(
          children: <Widget>[
            new IconButton(
              icon: Icon(Icons.arrow_drop_up),
              onPressed: () {},
            ),
            new Text("$cart_prod_qty"),
            new IconButton(
              icon: Icon(Icons.arrow_drop_down),
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }
}
