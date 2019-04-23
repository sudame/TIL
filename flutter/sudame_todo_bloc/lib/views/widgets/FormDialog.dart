// flutter packages
import 'package:flutter/material.dart';

// 3rd party packages
import 'package:bloc_provider/bloc_provider.dart';

// self packages
import 'package:sudame_todo_bloc/models/task.dart';
import 'package:sudame_todo_bloc/blocs/tasks_bloc.dart';

class FormDialog extends StatelessWidget {
  static void showFormDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => FormDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController _titleEditingController =
        new TextEditingController();
    TasksBloc _bloc = BlocProvider.of<TasksBloc>(context);

    return AlertDialog(
      title: Text('新規タスク'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('タイトル'),
          TextField(
            controller: _titleEditingController,
          ),
        ],
      ),
      actions: <Widget>[
        FlatButton(
          child: Text('作成'),
          onPressed: () {
            _bloc.setTask.add(
              TaskEvent(
                action: TaskEventAction.create,
                task: Task(
                  title: _titleEditingController.value.text,
                ),
              ),
            );
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
