// flutter packages
import 'package:flutter/material.dart';

// 3rd party packages
import 'package:bloc_provider/bloc_provider.dart';

// self packages
import 'package:sudame_todo_bloc/blocs/tasks_bloc.dart';
import 'package:sudame_todo_bloc/models/task.dart';
import 'package:sudame_todo_bloc/views/widgets/widgets.dart';

class TaskView extends StatelessWidget {
  final Task _task;
  TaskView({Task task}) : _task = task;

  @override
  Widget build(BuildContext context) {
    final TasksBloc _bloc = BlocProvider.of<TasksBloc>(context);
    return GestureDetector(
      onTap: () {
        print('TAPPED!');
      },
      onLongPress: () {
        FormDialog.showFormDialog(context, task: _task);
        print('LONG PRESSED!');
      },
      child: Padding(
        padding: const EdgeInsets.only(
            top: 8.0, bottom: 8.0, left: 12.0, right: 12.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.transparent,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Checkbox(
                value: _task.isCompleted,
                onChanged: (bool isCompleted) {
                  // チェックボックスが押されたらTaskを更新する
                  _bloc.setTask.add(
                    TaskEvent<bool>(
                      action: TaskEventAction.update,
                      task: _task.copyWith(
                        isCompleted: isCompleted,
                      ),
                    ),
                  );
                },
              ),
              SizedBox(
                width: 8.0,
              ),
              Text(
                _task.title,
                style: TextStyle(
                  color: _task.isCompleted ? Colors.black26 : Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                  decoration:
                      _task.isCompleted ? TextDecoration.lineThrough : null,
                ),
              ),
              Expanded(
                child: Container(),
              ),
              GestureDetector(
                onTap: () {
                  print('delete!');
                  _bloc.setTask.add(
                    TaskEvent(
                      action: TaskEventAction.delete,
                      task: _task,
                    ),
                  );
                },
                child: Icon(
                  Icons.delete_forever,
                  size: 30,
                  color: Colors.black26,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
