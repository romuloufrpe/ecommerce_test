import 'package:flutter/material.dart';
import 'package:historias/component/drawer.dart';
import 'package:historias/ui/screen.dart';

class HomePage extends StatefulWidget {
  final String email;
  final String name;

  HomePage({Key key, @required this.email, @required this.name}): super(key:key);
  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  AnimationController controller;

  Animation animationTranslate;
  Animation animationSize;
  Animation animationSizeBorder;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: Duration(milliseconds: 800), vsync: this);

    animationTranslate = Tween(begin: 0.0, end: 300.0)
        .animate(CurvedAnimation(parent: controller, curve: Curves.easeOut));
    animationTranslate.addListener(() {
      setState(() {});
    });

    animationSize = Tween(begin: 1.0, end: 0.8)
        .animate(CurvedAnimation(parent: controller, curve: Curves.easeOut));
    animationTranslate.addListener(() {
      setState(() {});
    });

    animationSizeBorder = Tween(begin: 0.0, end: 10.0)
        .animate(CurvedAnimation(parent: controller, curve: Curves.easeOut));
    animationSizeBorder.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  _onTapMenu() {
    if (controller.value == 1) {
      controller.reverse();
    } else {
      controller.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        DrawerWidget(email: widget.email, name: widget.name,),
        Transform.scale(
          scale: animationSize.value,
          child: Container(
            transform: Matrix4.identity()
              ..translate(animationTranslate.value, 0.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(animationSizeBorder.value),
              child: ScreenWidget(onTap: _onTapMenu),
            ),
          ),
        )
      ],
    );
  }
}
