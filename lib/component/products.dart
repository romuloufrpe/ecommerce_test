import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:historias/pages/product_details.dart';

class Products extends StatefulWidget {
  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  Firestore firestore = Firestore.instance;

  String productImages = "productImages";
  String productTitle = "productTitle";
  String productDesc = "productDesc";
  String productPrice = "productPrice";
  String productCat = "productCat";
  String productBrand = "productBrand";
  String productSize = "productSize";

  @override
  Widget build(BuildContext context) {
    return new StreamBuilder(
        stream: firestore.collection('product').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return new Center(
                child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                        Theme.of(context).primaryColor)));
          } else {
            final int dataCount = snapshot.data.documents.length;
            print("data count $dataCount");
            if (dataCount == 0) {
              noDatafound();
            } else {
              return new GridView.builder(
                gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, childAspectRatio: 0.85),
                itemCount: dataCount,
                itemBuilder: (context, index) {
                  final DocumentSnapshot document =
                      snapshot.data.documents[index];
                  return buildProducts(context, index, document);
                },
              );
            }
          }
        });
  }

  Widget noDatafound() {
    return new Container(
      child: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Icon(
              Icons.find_in_page,
              color: Colors.black45,
              size: 80.0,
            ),
            new Text(
              "Nenhum produto encontrado",
              style: new TextStyle(color: Colors.black45, fontSize: 20.0),
            ),
            new SizedBox(
              height: 10.0,
            ),
            new Text(
              "Por favor cheque sua conexão",
              style: new TextStyle(color: Colors.red, fontSize: 14.0),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildProducts(
      BuildContext context, int index, DocumentSnapshot document) {
    List productImage = document[productImages] as List;
    return new GestureDetector(
      onTap: () {
        Navigator.of(context).push(new MaterialPageRoute(
            builder: (context) => new ProductDetails(
                  product_detail_picture: productImage[0],
                  product_detail_name: document[productTitle],
                  product_detail_new_price: document[productPrice],
                  product_detail_desc: document[productDesc],
                  product_detail_cat: document[productCat],
                  product_detail_brand: document[productBrand],
                  //product_detail_size: document[productSize],
                )));
      },
      child: new Card(
        child: Stack(
          alignment: FractionalOffset.topLeft,
          children: <Widget>[
            new Stack(
              alignment: FractionalOffset.bottomCenter,
              children: <Widget>[
                new Container(
                  decoration: new BoxDecoration(
                      image: new DecorationImage(
                          fit: BoxFit.fitWidth,
                          image: new NetworkImage(productImage[0]))),
                ),
                new Container(
                  height: 50.0,
                  width: 200.0,
                  color: Colors.black.withAlpha(100),
                  child: new Column(children: <Widget>[
                    new Text(
                      "${document["productTitle"]}...",
                      style: new TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 18.0,
                          color: Colors.white),
                    ),
                    new Text(
                      "\R\$${document["productPrice"]}",
                      style: new TextStyle(
                          color: Colors.red[500], fontWeight: FontWeight.w700),
                    ),
                  ]),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
