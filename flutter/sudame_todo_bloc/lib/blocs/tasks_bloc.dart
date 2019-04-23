import 'dart:async';
import 'dart:collection';

import 'package:rxdart/subjects.dart';
import 'package:sudame_todo_bloc/models/task.dart';
import 'package:sudame_todo_bloc/models/taskList.dart';

class TasksBloc {
  static TaskList _taskList = new TaskList(
      editingTaskId: 0, taskList: UnmodifiableListView([]), maxID: 0);

  // input stream controller
  final StreamController<int> _editingController = StreamController();
  final StreamController<String> _titleController = StreamController();
  final StreamController<bool> _isCompletedController = StreamController();

  // output stream controller
  final BehaviorSubject<TaskList> _outputController =
      BehaviorSubject.seeded(_taskList);

  Sink<int> get setTaskEditing => _editingController.sink;
  Sink<String> get setTaskTitle => _titleController.sink;
  Sink<bool> get setTaskIsCompleted => _isCompletedController.sink;

  Stream<TaskList> get getTaskList => _outputController.stream;

  TasksBloc() {
    _editingController.stream.listen((int id) {
      _setEditing(id);
    });
    _titleController.stream.listen((String title) {
      _setTitle(title);
    });
    _isCompletedController.stream.listen((bool isCompleted) {
      _setIsCompleted(isCompleted);
    });
  }

  void _setEditing(int id) {
    _taskList = _taskList.setEditing(id);
  }

  void _setTitle(String title) {
    final int index = _taskList.getTaskIndex();
    final Task _task = _taskList[index].copyWith(title: title);
    _taskList = _taskList.update(_task);
    _outputController.add(_taskList);
  }

  void _setIsCompleted(bool isCompleted) {
    final int index = _taskList.getTaskIndex();
    final Task _task = _taskList[index].copyWith(isCompleted: isCompleted);
    _taskList = _taskList.update(_task);
    _outputController.add(_taskList);
  }
}
