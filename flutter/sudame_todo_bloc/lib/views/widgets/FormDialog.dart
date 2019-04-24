// flutter packages
import 'package:flutter/material.dart';

// 3rd party packages
import 'package:bloc_provider/bloc_provider.dart';
import 'package:flutter/services.dart';

// self packages
import 'package:sudame_todo_bloc/models/task.dart';
import 'package:sudame_todo_bloc/blocs/tasks_bloc.dart';

class FormDialog extends StatefulWidget {
  final Task _task;

  FormDialog({Task task}) : _task = task;

  static void showFormDialog(BuildContext context, {Task task}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return FormDialog(
          task: task,
        );
      },
    );
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _FormDialogState(task: _task);
  }
}

class _FormDialogState extends State<FormDialog> {
  _FormDialogState({this.task});

  final Task task;

  TextEditingController _titleEditingController;

  @override
  void initState() {
    _titleEditingController =
        new TextEditingController(text: task?.title ?? '');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TasksBloc _bloc = BlocProvider.of<TasksBloc>(context);

    return AlertDialog(
      title: Text(task == null ? '新規タスク' : 'タスクを更新'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('タイトル'),
          TextField(
            controller: _titleEditingController,
            textInputAction: TextInputAction.none,
          ),
        ],
      ),
      actions: <Widget>[
        FlatButton(
          child: Text(task == null ? '作成' : '更新'),
          onPressed: () {
            if (task == null) {
              _bloc.setTask.add(
                TaskEvent(
                  action: TaskEventAction.create,
                  task: Task(
                    title: _titleEditingController.text,
                  ),
                ),
              );
            } else {
              _bloc.setTask.add(
                TaskEvent(
                  action: TaskEventAction.update,
                  task: task.copyWith(
                    title: _titleEditingController.text,
                  ),
                ),
              );
            }
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
