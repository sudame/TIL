import 'package:flutter/material.dart';

class ExpandedExample extends StatelessWidget {
  ExpandedExample({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _NotExpandedItem(),
          _ExpandedItem(
            flex: 1,
          ),
          _NotExpandedItem(),
          _ExpandedItem(
            flex: 2,
          ),
          _NotExpandedItem(),
        ],
      ),
    );
  }
}

class _NotExpandedItem extends StatelessWidget {
  _NotExpandedItem({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100.0,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black26,
        ),
        child: Center(
          child: Text(
            'This item has fixed height 100.0',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}

class _ExpandedItem extends StatelessWidget {
  final int flex;

  _ExpandedItem({Key key, @required this.flex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blueAccent,
        ),
        child: Center(
          child: Text(
            'This item is Expanded with flex: $flex',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
