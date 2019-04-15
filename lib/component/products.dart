import 'package:flutter/material.dart';
import 'package:historias/pages/product_details.dart';

class Products extends StatefulWidget {
  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
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
    {
      "name": "Tenis",
      "picture": "assets/products/tenisbalada4.jpg",
      "old_price": 120,
      "price": 85
    },
    {
      "name": "Tshirt Batman",
      "picture": "assets/products/tshirt-01.jpg",
      "old_price": 120,
      "price": 85
    },
    {
      "name": "Tshirt",
      "picture": "assets/products/tshirt-02.jpg",
      "old_price": 120,
      "price": 85
    },
    {
      "name": "Tshirt Branca",
      "picture": "assets/products/tshirt-03.jpg",
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
            padding: const EdgeInsets.all(4.0),
            child: Single_prod(
              prod_name: product_list[index]['name'],
              prod_picture: product_list[index]['picture'],
              prod_price: product_list[index]['price'],
              prod_price_old: product_list[index]['old_price'],
            ),
          );
        });
  }
}

class Single_prod extends StatelessWidget {
  final prod_name;
  final prod_picture;
  final prod_price_old;
  final prod_price;

  Single_prod(
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
