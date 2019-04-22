import 'package:flutter/material.dart';
import 'package:sudame_todo_bloc/helpers/bloc_provider.dart';
import 'package:sudame_todo_bloc/blocs/tasks_bloc.dart';
import 'task_list.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TaskBloc _bloc = BlocProvider.of<TaskBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('sudame ToDo BLoC'),
      ),
      body: TaskList(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          _bloc.setTaskEditing.add(null);
        },
      ),
    );
  }
}
