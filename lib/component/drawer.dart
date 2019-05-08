import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'theme.dart' as Theme;
import 'package:historias/pages/cart.dart';
import 'package:historias/authentication_bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DrawerWidget extends StatefulWidget {
  final String email;
  final String name;

  DrawerWidget({Key key, @required this.email, @required this.name}): super(key:key);

  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();
}
  
class _DrawerWidgetState extends State<DrawerWidget>  {
  int itemSelect = 0;
  
  Widget _listMenu() {
    return ListView(
      children: <Widget>[
        _avatar(),
        _tiles("INÍCIO", FontAwesomeIcons.home, 0, () {}),
        _tiles("MINHA CONTA", FontAwesomeIcons.userAlt, 1, () {
          itemSelect = 1;
        }),
        _tiles("CATEGORIAS", Icons.dashboard, 2, () {
          itemSelect = 2;
        }),
        _tiles("MINHAS COMPRAS", FontAwesomeIcons.shoppingCart, 3, () {
          itemSelect = 3;
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => new Cart()));
        }),
        Divider(),
        _tiles("CONFIGURAÇÕES", FontAwesomeIcons.cog, 4, () {
          itemSelect = 4;
        }),
        _tiles("SOBRE", FontAwesomeIcons.addressBook, 5, () {
          itemSelect = 5;
        }),
        _tiles("SAIR", FontAwesomeIcons.arrowCircleLeft, 6, () {
          itemSelect = 6;
          BlocProvider.of<AuthenticationBloc>(context).dispatch(LoggedOut());
            /*firebaseAuth.signOut().then((value){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login()));
            });*/
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
            "${widget.name}",
            style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.black54),
          ),
          Text("${widget.email}"),
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
