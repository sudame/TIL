import 'dart:async';

import 'package:sudame_todo_bloc/helpers/base_bloc.dart';

import 'package:rxdart/subjects.dart';
import 'package:sudame_todo_bloc/models/task.dart';

class TaskBloc implements BaseBloc {
  // State
  List<Task> _taskList = [];
  int _editingTask = 0;

  // output controller(s)
  final BehaviorSubject<List<Task>> _taskListSubject =
      BehaviorSubject.seeded([]);

  // input controller(s)
  final StreamController<int> _setEditingController = StreamController();
  final StreamController<String> _setTitleController = StreamController();
  final StreamController<String> _setDescriptionController = StreamController();
  final StreamController<bool> _setIsCompletedController = StreamController();

  // output stream
  Stream<List<Task>> get getTaskList => _taskListSubject.stream;

  // input stream
  Sink<int> get setTaskEditing => _setEditingController.sink;
  Sink<String> get setTaskTitle => _setTitleController.sink;
  Sink<String> get setTaskDescription => _setDescriptionController.sink;
  Sink<bool> get setTaskIsCompleted => _setIsCompletedController.sink;

  void _setEditing(int taskId) {
    taskId = taskId ?? _taskList.length;
    this._editingTask = taskId;
    print('[EDITING TASK] $_editingTask');
    print('_taskList.length == ${_taskList.length}');
    if (_taskList.length <= _editingTask || (_taskList[_editingTask] == null)) {
      _taskList.add(
        new Task(
          id: _editingTask,
          title: '',
          description: '',
        ),
      );
    }

    _taskListSubject.add(_taskList);
  }

  void _setTitle(String title) {
    _taskList[_editingTask].title = title;

    _taskListSubject.add(_taskList);
  }

  void _setDescription(String description) {
    _taskList[_editingTask].description = description;

    _taskListSubject.add(_taskList);
  }

  void _setIsCompleted(bool isCompleted) {
    _taskList[_editingTask].isCompleted = isCompleted;

    _taskListSubject.add(_taskList);
  }

  TaskBloc() {
    _setEditingController.stream.listen((int taskId) {
      _setEditing(taskId);
    });

    _setTitleController.stream.listen((String title) {
      _setTitle(title);
    });

    _setDescriptionController.stream.listen((String description) {
      _setDescription(description);
    });

    _setIsCompletedController.stream.listen((bool isCompleted) {
      _setIsCompleted(isCompleted);
    });
  }

  // when disposed
  @override
  void dispose() async {
    _taskListSubject.close();
    _setEditingController.close();
    _setTitleController.close();
    _setDescriptionController.close();
    _setIsCompletedController.close();
  }
}
