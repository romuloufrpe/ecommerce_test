import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:historias/component/theme.dart' as Theme;
import 'package:historias/ui/home.dart';
import 'package:carousel_pro/carousel_pro.dart';

class ProductDetails extends StatefulWidget {
  final product_detail_name;
  final product_detail_new_price;
  final product_detail_old_price;
  final product_detail_picture;
  final product_detail_desc;
  final product_detail_cat;
  final product_detail_brand;
  final String email;
  final String name;

  ProductDetails(
      {
      Key key,
      this.product_detail_name,
      this.product_detail_new_price,
      this.product_detail_old_price,
      this.product_detail_picture,
      this.product_detail_desc,
      this.product_detail_cat,
      this.product_detail_brand,
      @required this.name,
      @required this.email}) : super(key: key);

      

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        elevation: 0.1,
        backgroundColor: Theme.Colors.appBarColor,
        title: InkWell(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => new HomePage(name: widget.name ,email: widget.email,)));
          },
          child: Text("FastShop"),
        ),
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
      body: new ListView(
        children: <Widget>[
          new Container(
            height: 300.0,
            child: GridTile(
              child: new Container(
                decoration: new BoxDecoration(
                    borderRadius: new BorderRadius.only(
                      bottomLeft: new Radius.circular(100.0),
                      bottomRight: new Radius.circular(100.0),
                    ),
                    image: new DecorationImage(
                        // !ADICIONAR CARROSEL
                        image: new NetworkImage(
                            "${widget.product_detail_picture}"),
                        fit: BoxFit.fitHeight)),
              ),
              footer: new Container(
                color: Colors.white70,
                child: ListTile(
                  leading: new Text(widget.product_detail_name,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18.0)),
                  title: new Row(
                    children: <Widget>[
                      Expanded(
                          child: new Text(
                        "\R\$${widget.product_detail_new_price}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.red),
                      )),
                    ],
                  ),
                ),
              ),
            ),
          ),

// ==================== the frist buttons ================================
          Row(
            children: <Widget>[
              // ======== TAMANHO DO PRODUTO
              Expanded(
                child: MaterialButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return new AlertDialog(
                            title: new Text("Tamanho"),
                            content: new Text("Tamanhos Disponíveis"),
                            actions: <Widget>[
                              new MaterialButton(
                                onPressed: () {
                                  Navigator.of(context).pop(context);
                                },
                                child: new Text("fechar"),
                              )
                            ],
                          );
                        });
                  },
                  color: Colors.white,
                  textColor: Colors.grey,
                  elevation: 0.2,
                  child: Row(
                    children: <Widget>[
                      Expanded(child: new Text("Tamanho")),
                      Expanded(child: new Icon(Icons.arrow_drop_down)),
                    ],
                  ),
                ),
              ),
              // ========== COR DO PRODUTO
              Expanded(
                child: MaterialButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return new AlertDialog(
                            title: new Text("Cor"),
                            content: new Text("Cores Disponíveis"),
                            actions: <Widget>[
                              new MaterialButton(
                                onPressed: () {
                                  Navigator.of(context).pop(context);
                                },
                                child: new Text("fechar"),
                              )
                            ],
                          );
                        });
                  },
                  color: Colors.white,
                  textColor: Colors.grey,
                  elevation: 0.2,
                  child: Row(
                    children: <Widget>[
                      Expanded(child: new Text("Cor")),
                      Expanded(child: new Icon(Icons.arrow_drop_down)),
                    ],
                  ),
                ),
              ),

              // =========== QUANTIDADE
              /*
              Expanded(
                child: MaterialButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return new AlertDialog(
                            title: new Text("Tamanho"),
                            content: new Text("Tamanhos Disponíveis"),
                            actions: <Widget>[
                              new MaterialButton(
                                onPressed: () {
                                  Navigator.of(context).pop(context);
                                },
                                child: new Text("fechar"),
                              )
                            ],
                          );
                        });
                  },
                color: Colors.white,
                textColor: Colors.grey,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: new Text("Qnt")
                    ),
                    Expanded(
                      child: new Icon(Icons.arrow_drop_down)
                    ),
                  ],
                ),),
              ),*/
            ],
          ),

          // ==================== the second buttons ================================
          Row(
            children: <Widget>[
              // ======== TAMANHO DO PRODUTO
              Expanded(
                child: MaterialButton(
                    onPressed: () {},
                    color: Colors.red,
                    textColor: Colors.white,
                    elevation: 0.2,
                    child: new Text("Reserve agora")),
              ),

              new IconButton(
                icon: Icon(Icons.add_shopping_cart),
                onPressed: () {},
              ),

              new IconButton(
                icon: Icon(FontAwesomeIcons.heart),
                onPressed: () {},
              ),
              // =========== QUANTIDADE
              /*
              Expanded(
                child: MaterialButton(onPressed: () {},
                color: Colors.white,
                textColor: Colors.grey,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: new Text("Qnt")
                    ),
                    Expanded(
                      child: new Icon(Icons.arrow_drop_down)
                    ),
                  ],
                ),),
              ),*/
            ],
          ),
          Divider(
            color: Colors.black,
          ),
          new ListTile(
              title: new Text("Detalhes do Produto"),
              subtitle: new Text("${widget.product_detail_desc}")),
          Divider(color: Colors.black),
          new Row(
            children: <Widget>[
              Padding(
                  padding: const EdgeInsets.fromLTRB(12.0, 5.0, 5.0, 5.0),
                  child: new Text("Produto",
                      style: TextStyle(color: Colors.grey))),
              Padding(
                  padding: EdgeInsets.all(5.0),
                  child: new Text("${widget.product_detail_name}")),
            ],
          ),

          new Row(
            children: <Widget>[
              Padding(
                  padding: const EdgeInsets.fromLTRB(12.0, 5.0, 5.0, 5.0),
                  child: new Text("Produto brand",
                      style: TextStyle(color: Colors.grey))),

              // REMEMBER TO CREATE THE PRODUCT BRAND
              Padding(
                  padding: EdgeInsets.all(5.0),
                  child: new Text("${widget.product_detail_brand}")),
            ],
          ),
          // PRODUTOS SIMILARES SECTIONS

          Divider(
            color: Colors.black,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: new Text("Produtos Similares"),
          ),
        ],
      ),
    );
  }
}
