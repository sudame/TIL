import 'package:flutter/material.dart';

class TaskView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
      child: Row(
        children: <Widget>[
          Checkbox(
            value: false,
            onChanged: (bool newVal) {},
          ),
          SizedBox(
            width: 8.0,
          ),
          Text(
            'ToDo Item',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
