import 'package:flutter/material.dart';
import 'package:sudame_todo_bloc/models/task.dart';
import 'package:sudame_todo_bloc/blocs/tasks_bloc.dart';
import 'package:sudame_todo_bloc/helpers/bloc_provider.dart';

class TaskList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TaskBloc _bloc = BlocProvider.of<TaskBloc>(context);

    return StreamBuilder(
      stream: _bloc.getTaskList,
      initialData: [null],
      builder: (BuildContext context, AsyncSnapshot<List<Task>> snap) {
        print(snap.data);
        return ListView.builder(
          itemCount: snap.data.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: TaskListItem(
                task: snap.data[index],
                bloc: _bloc,
                index: index,
              ),
            );
          },
        );
      },
    );
  }
}

class TaskListItem extends StatelessWidget {
  final Task _task;
  final TaskBloc _bloc;
  final int _index;

  TaskListItem({
    Key key,
    @required Task task,
    @required TaskBloc bloc,
    @required int index,
  })  : this._task = task,
        this._bloc = bloc,
        this._index = index,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Checkbox(
          value: _task.isCompleted,
          onChanged: (bool value) async {
            await _bloc.setTaskEditing.add(_index);
            _bloc.setTaskIsCompleted.add(value);
          },
        ),
        Column(
          children: <Widget>[
            Text(_task.title),
            Text(_task.description),
          ],
        ),
      ],
    );
  }
}
