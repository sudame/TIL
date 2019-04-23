import 'package:flutter/material.dart';
import 'TaskView.dart';

const tasks = ['hoge'];

class TaskList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (BuildContext context, int index) {
        return TaskView();
      },
    );
  }
}
