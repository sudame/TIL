import 'package:flutter/material.dart';
import 'package:sudame_todo_bloc/blocs/tasks_bloc.dart';
import 'package:sudame_todo_bloc/views/widgets/widgets.dart';

import 'package:bloc_provider/bloc_provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TasksBloc _bloc = BlocProvider.of<TasksBloc>(context);

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
          _bloc.setTaskEditing.add(-1);
          _bloc.setTaskTitle.add(DateTime.now().toString());
        },
      ),
    );
  }
}
