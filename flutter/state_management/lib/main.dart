import 'package:flutter/material.dart';
import 'package:state_management/models/cart.dart';
import 'package:state_management/screen/cart.dart';
import 'package:state_management/screen/catalog.dart';
import 'package:state_management/screen/login.dart';
import 'package:scoped_model/scoped_model.dart';

void main() {
  final cart = CartModel();

  runApp(ScopedModel<CartModel>(
    model: cart,
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
        textTheme: TextTheme(
          display4: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 24,
            color: Colors.black,
          ),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => MyLoginScreen(),
        '/catalog': (context) => MyCatalog(),
        '/cart': (context) => MyCart(),
      },
    );
  }
}
