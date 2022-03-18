import 'package:flutter/material.dart';

class Categorie extends StatefulWidget {
  const Categorie({
    Key? key,
  }) : super(key: key);

  @override
  State<Categorie> createState() => _CategorieState();
}

class _CategorieState extends State<Categorie> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /* appBar: AppBar(
        centerTitle: true,
        title: Text('bonjour'),
      ), */
      body: Container(
          child: Row(
        children: <Widget>[
          Card(
            //elevation: 3.0,
            child: Container(
              height: 40,
              width: 40,
              child: Image.asset('assets/images/vrai.jpg'),
            ),
          )
          //Image.asset('assets/images/vrai.jpg'),
          //Image.asset('assets/images/vrai.jpg'),
        ],
      )),
    );
  }
}
