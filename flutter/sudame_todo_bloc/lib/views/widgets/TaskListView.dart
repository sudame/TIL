// flutter packages
import 'package:flutter/material.dart';

// 3rd party packages
import 'package:bloc_provider/bloc_provider.dart';

// self packages
import 'package:sudame_todo_bloc/blocs/tasks_bloc.dart';
import 'package:sudame_todo_bloc/models/task.dart';
import 'package:sudame_todo_bloc/views/widgets/widgets.dart';

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
            return Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    width: 2.0,
                    color: Theme.of(context).dividerColor,
                  ),
                ),
              ),
              child: TaskView(task: snap.data[index]),
            );
          },
        );
      },
    );
  }
}
