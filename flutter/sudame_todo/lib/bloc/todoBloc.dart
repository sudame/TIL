import 'dart:async';
import 'dart:collection';

import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sudame_todo/models/taskModel.dart';

enum Operate { create, remove, update }

class TaskOperate {
  final Operate operate;
  final TaskModel task;

  TaskOperate({@required this.operate, @required this.task});
}

class ToDoBloc {
  // initial task list
  static List<TaskModel> _tasks = [];

  ToDoBloc() {
    _taskController.stream.listen(_operate);
  }

  // input controllers
  final StreamController<TaskOperate> _taskController = StreamController();

  // output controllers
  final BehaviorSubject<List<TaskModel>> _taskSubject =
      BehaviorSubject.seeded([]);

  // input signal
  Sink<TaskOperate> get taskOp => _taskController.sink;

  // output stream
  Stream<List<TaskModel>> get tasks => _taskSubject.stream;

  void _operate(TaskOperate taskOperate) {
    final Operate _op = taskOperate.operate;
    final TaskModel _task = taskOperate.task;

    switch (_op) {
      case Operate.create:
        _create(_task);
        break;
      case Operate.update:
        _update(_task);
        break;
      case Operate.remove:
//        _remove();
        break;
      default:
        break;
    }
  }

  void _create(TaskModel task) {
    _tasks.add(task);

    _taskSubject.add(_tasks);
  }

  void _update(TaskModel task) {
    final int _id = task.id;

    final int _index = _tasks.indexWhere((el) => el.id == _id);

    _tasks.replaceRange(_index, _index + 1, [task]);

    _taskSubject.add(_tasks);
  }
}
