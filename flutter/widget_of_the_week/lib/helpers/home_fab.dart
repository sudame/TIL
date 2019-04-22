import 'package:flutter/material.dart';

class BackFAB extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.home),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
  }
}
