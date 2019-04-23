// flutter packages
import 'package:flutter/material.dart';

// self packages
import 'package:sudame_todo_bloc/views/widgets/widgets.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ToDo BLoC',
        ),
      ),
      body: Center(
        child: TaskListView(),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          FormDialog.showFormDialog(context);
        },
      ),
    );
  }
}
