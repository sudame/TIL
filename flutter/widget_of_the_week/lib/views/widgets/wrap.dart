import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:widget_of_the_week/helpers/home_fab.dart';

List<Widget> _items() {
  List<Widget> _result = [];
  for (int i = 0; i < 10; i++) {
    _result.add(
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: RaisedButton(
          onPressed: () {},
          child: Text(
            i.toString(),
          ),
        ),
      ),
    );
  }
  return _result;
}

class WrapExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _EnableWrap(),
            SizedBox(),
            _DisableWrap(),
          ],
        ),
      ),
      floatingActionButton: BackFAB(),
    );
  }
}

class _EnableWrap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text('Wrap'),
          SizedBox(
            height: 8.0,
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(),
            ),
            child: Wrap(
              children: _items(),
            ),
          ),
        ],
      ),
    );
  }
}

class _DisableWrap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text('Wrap'),
          SizedBox(
            height: 8.0,
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(),
            ),
            child: Row(
              children: _items(),
            ),
          ),
        ],
      ),
    );
  }
}
