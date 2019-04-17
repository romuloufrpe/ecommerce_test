import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'theme.dart' as Theme;
import 'package:historias/pages/cart.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:historias/pages/login.dart';
import 'package:firebase_database/firebase_database.dart';

class DrawerWidget extends StatefulWidget {
  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
//  String email = firebaseAuth.currentUser();
  int itemSelect = 0;
  

  Widget _listMenu() {
    return ListView(
      children: <Widget>[
        _avatar(),
        _tiles("INÍCIO", FontAwesomeIcons.home, 0, () {}),
        _tiles("MINHA CONTA", FontAwesomeIcons.userAlt, 1, () {}),
        _tiles("CATEGORIAS", Icons.dashboard, 2, () {}),
        _tiles("MINHAS COMPRAS", FontAwesomeIcons.shoppingCart, 3, () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => new Cart()));
        }),
        Divider(),
        _tiles("CONFIGURAÇÕES", FontAwesomeIcons.cog, 4, () {}),
        _tiles("SOBRE", FontAwesomeIcons.addressBook, 5, () {}),
        _tiles("SAIR", FontAwesomeIcons.arrowCircleLeft, 6, () {
            firebaseAuth.signOut().then((value){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login()));
            });
        }),
      ],
    );
  }

  Widget _tiles(String text, IconData icon, int item, Function onTap) {
    return ListTile(
      leading: Icon(icon),
      onTap: onTap,
      selected: item == itemSelect,
      title: Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _avatar() {
    return Padding(
      padding: EdgeInsets.all(18.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          CircleAvatar(
              backgroundColor: Colors.brown.shade800,
              //Atualaizar avatar de acordo com o cadastro
              backgroundImage: NetworkImage(
                  "https://cdn4.iconfinder.com/data/icons/user-avatar-flat-icons/512/User_Avatar-04-512.png")),
          Container(
            height: 12.0,
          ),
          Text(
            'Rômulo Ferreira',
            style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.black54),
          ),
          Text("romulo.ferreira.ufrpe@gmail.com"),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        color: Theme.Colors.backDrawerColor,
        child: _listMenu(),
      ),
    );
  }
}
