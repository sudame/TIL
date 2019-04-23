import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:sudame_todo_bloc/blocs/tasks_bloc.dart';
import 'TaskView.dart';
import 'package:sudame_todo_bloc/models/task.dart';
import 'package:bloc_provider/bloc_provider.dart';

const tasks = ['hoge'];

class TaskListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _bloc = BlocProvider.of<TasksBloc>(context);

    return StreamBuilder(
      stream: _bloc.getTaskList,
      builder: (BuildContext context, AsyncSnapshot<List<Task>> snap) {
        return ListView.builder(
          itemCount: snap.data?.length ?? 0,
          itemBuilder: (BuildContext context, int index) {
            return TaskView(task: snap.data[index]);
          },
        );
      },
    );
  }
}
