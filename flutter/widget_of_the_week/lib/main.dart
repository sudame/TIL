import 'package:flutter/material.dart';
import 'package:widget_of_the_week/views/homepage.dart';
import 'package:widget_of_the_week/views/my_widgets.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/': (context) => HomePage(),
        '/SafeArea': (context) => MySafeArea(),
        '/Expanded': (context) => ExpandedExample(),
      },
    );
  }
}
