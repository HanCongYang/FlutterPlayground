import 'dart:async';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _count = 0;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(

      body: new RefreshIndicator(
        child: new ListView(
          children: _getItems(),
        ),
        onRefresh: _handleRefresh,
      ),
    );
  }

  List<Widget> _getItems() {
    var items = <Widget>[];
    for (int i = _count; i < _count + 4; i++) {
      var item = new Column(
        children: <Widget>[
          new Image(image: new AssetImage('xcassets/cat.jpg'), width: 100, height:  1050),
          new ListTile(
            title: new Text("Item $i"),
          ),
          new Divider(
            height: 2.0,
          )
        ],
      );

      items.add(item);
    }
    return items;
  }

  Future<Null> _handleRefresh() async {
    await new Future.delayed(new Duration(seconds: 3));

    setState(() {
      _count += 5;
    });

    return null;
  }
}