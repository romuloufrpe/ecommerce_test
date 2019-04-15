import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:historias/component/theme.dart' as Theme;
import 'package:historias/ui/home.dart';

class ProductDetails extends StatefulWidget {
  final product_detail_name;
  final product_detail_new_price;
  final product_detail_old_price;
  final product_detail_picture;

  ProductDetails(
      {this.product_detail_name,
      this.product_detail_new_price,
      this.product_detail_old_price,
      this.product_detail_picture});

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
                MaterialPageRoute(builder: (context) => new HomePage()));
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
                color: Colors.white,
                child: Image.asset(widget.product_detail_picture),
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
                        "\R\$${widget.product_detail_old_price}",
                        style: TextStyle(
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough),
                      )),
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
            subtitle: new Text(
                "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting"),
          ),
          Divider(color: Colors.black),
          new Row(
            children: <Widget>[
              Padding(
                  padding: const EdgeInsets.fromLTRB(12.0, 5.0, 5.0, 5.0),
                  child: new Text("Produto",
                      style: TextStyle(color: Colors.grey))),
              Padding(
                  padding: EdgeInsets.all(5.0),
                  child: new Text(widget.product_detail_name)),
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
                  padding: EdgeInsets.all(5.0), child: new Text("Brando X")),
            ],
          ),

          new Row(
            children: <Widget>[
              Padding(
                  padding: const EdgeInsets.fromLTRB(12.0, 5.0, 5.0, 5.0),
                  child: new Text("Condição do Produto",
                      style: TextStyle(color: Colors.grey))),

              // REMEMBER TO CREATE THE PRODUCT BRAND
              Padding(padding: EdgeInsets.all(5.0), child: new Text("Novo")),
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
          Container(
            height: 360.0,
            child: Similar_products(),
          )
        ],
      ),
    );
  }
}

class Similar_products extends StatefulWidget {
  @override
  _Similar_productsState createState() => _Similar_productsState();
}

class _Similar_productsState extends State<Similar_products> {
  var product_list = [
    {
      "name": "Blazer",
      "picture": "assets/products/blazer.jpg",
      "old_price": 120,
      "price": 85
    },
    {
      "name": "Jeans Branco",
      "picture": "assets/products/jeans-01.jpg",
      "old_price": 120,
      "price": 85
    },
    {
      "name": "Jeans azul",
      "picture": "assets/products/jeans-02.jpg",
      "old_price": 120,
      "price": 85
    },
    {
      "name": "Tenis Adidas",
      "picture": "assets/products/tenisbalada3.jpg",
      "old_price": 120,
      "price": 85
    },
  ];
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: product_list.length,
        gridDelegate:
            new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: EdgeInsets.all(4.0),
            child: Similar_single_prod(
              prod_name: product_list[index]['name'],
              prod_picture: product_list[index]['picture'],
              prod_price: product_list[index]['price'],
              prod_price_old: product_list[index]['old_price'],
            ),
          );
        });
  }
}

class Similar_single_prod extends StatelessWidget {
  final prod_name;
  final prod_picture;
  final prod_price_old;
  final prod_price;

  Similar_single_prod(
      {this.prod_name,
      this.prod_picture,
      this.prod_price,
      this.prod_price_old});
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Hero(
        tag: new Text("hero 1"),
        child: Material(
          child: InkWell(
            // NAVEGAÇÃO PARA DETALHES NO PRODUTO
            onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                //valores dos produtos passado para detalhes
                builder: (context) => new ProductDetails(
                      product_detail_name: prod_name,
                      product_detail_new_price: prod_price,
                      product_detail_old_price: prod_price_old,
                      product_detail_picture: prod_picture,
                    ))),
            // FIM DA NAVEGAÇÃO DETALHES DO PRODUTOS
            child: GridTile(
              footer: Container(
                  color: Colors.white70,
                  child: new Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          prod_name,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16.0),
                        ),
                      ),
                      new Text(
                        "\R\$$prod_price",
                        style: TextStyle(
                            color: Colors.red, fontWeight: FontWeight.bold),
                      )
                    ],
                  )),
              child: Image.asset(
                prod_picture,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
