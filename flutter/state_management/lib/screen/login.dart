import 'package:flutter/material.dart';

import 'package:state_management/models/cart.dart';
import 'package:scoped_model/scoped_model.dart';

class MyLoginScreen extends StatelessWidget {
  void onLoginSubmit(BuildContext context) {
    var cart = ScopedModel.of<CartModel>(context);

    cart.clear();

    Navigator.pushReplacementNamed(context, '/catalog');
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 64),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Welcome',
                style: Theme.of(context).textTheme.display4,
              ),
              SizedBox(
                height: 24,
              ),
              _LoginTextField(
                hintText: 'Login',
              ),
              SizedBox(
                height: 12,
              ),
              _LoginTextField(
                hintText: 'Password',
                obscureText: true,
              ),
              SizedBox(
                height: 24,
              ),
              FlatButton(
                child: Text('ENTER'),
                onPressed: () => onLoginSubmit(context),
                color: Colors.yellow,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _LoginTextField extends StatelessWidget {
  final String hintText;
  final bool obscureText;

  _LoginTextField({Key key, @required this.hintText, this.obscureText = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration:
          InputDecoration(hintText: hintText, fillColor: Colors.black12),
      obscureText: obscureText,
    );
  }
}
