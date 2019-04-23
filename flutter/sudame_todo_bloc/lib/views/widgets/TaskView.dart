import 'package:flutter/material.dart';
import 'package:sudame_todo_bloc/blocs/tasks_bloc.dart';
import 'package:sudame_todo_bloc/models/task.dart';
import 'package:bloc_provider/bloc_provider.dart';

class TaskView extends StatelessWidget {
  final Task _task;
  TaskView({Task task}) : _task = task;

  @override
  Widget build(BuildContext context) {
    final TasksBloc _bloc = BlocProvider.of<TasksBloc>(context);
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
      child: Row(
        children: <Widget>[
          Checkbox(
            value: _task.isCompleted,
            onChanged: (bool newVal) {
              _bloc.setTaskEditing.add(_task.id);
              _bloc.setTaskIsCompleted.add(newVal);
            },
          ),
          SizedBox(
            width: 8.0,
          ),
          Text(
            _task.title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              decoration: _task.isCompleted ? TextDecoration.lineThrough : null,
            ),
          ),
        ],
      ),
    );
  }
}
