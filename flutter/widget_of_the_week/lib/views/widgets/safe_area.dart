import 'package:flutter/material.dart';
import 'package:widget_of_the_week/helpers/home_fab.dart';

class MySafeArea extends StatefulWidget {
  MySafeArea({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MySafeAreaState();
  }
}

class _MySafeAreaState extends State<MySafeArea> {
  bool isEnabled = true;

  void _toggleEnable(bool newValue) {
    setState(() {
      this.isEnabled = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Stack(
        children: [
          isEnabled ? _EnableSafeArea() : _DisableSafeArea(),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(
                  height: 8.0,
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text('toggle SafeArea'),
                    Switch(
                      value: isEnabled,
                      onChanged: _toggleEnable,
                      activeColor: Colors.red,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: BackFAB(),
    );
  }
}

class _EnableSafeArea extends StatelessWidget {
  _EnableSafeArea({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        alignment: Alignment.topCenter,
        child: Text(
          'safe!',
          style: TextStyle(fontSize: 50),
        ),
        decoration: BoxDecoration(
          color: Colors.green,
          border: Border.all(
            color: Colors.red,
            width: 3.0,
          ),
        ),
      ),
    );
  }
}

class _DisableSafeArea extends StatelessWidget {
  _DisableSafeArea({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      child: Text(
        'unsafe!',
        style: TextStyle(fontSize: 50),
      ),
      decoration: BoxDecoration(
        color: Colors.green,
        border: Border.all(
          color: Colors.red,
          width: 3.0,
        ),
      ),
    );
  }
}
