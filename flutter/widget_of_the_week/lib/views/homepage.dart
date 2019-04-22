import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Widget of the Week'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Wrap(
          spacing: 8.0,
          children: [
            RaisedButton(
              child: Text('SafeArea'),
              onPressed: () {
                Navigator.pushNamed(context, '/SafeArea');
              },
            ),
            RaisedButton(
              child: Text('Expanded'),
              onPressed: () => {},
            ),
          ],
        ),
      ),
    );
  }
}
