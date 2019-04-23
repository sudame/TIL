import 'dart:async';

import 'package:bloc_provider/bloc_provider.dart';

import 'package:rxdart/subjects.dart';
import 'package:sudame_todo_bloc/models/task.dart';

// when update task list,
// 1. set task that will be updated with setTaskEditing stream.
// 2. set title or isCompleted with set{title,isCompleted} stream.

class TasksBloc implements Bloc {
  // task list
  static List<Task> _taskList = [];
  // index of editing task
  static int _editingId = 0;

  // input stream controller
  final StreamController<int> _editingController = StreamController();
  final StreamController<String> _titleController = StreamController();
  final StreamController<bool> _isCompletedController = StreamController();

  // output stream controller
  final BehaviorSubject<List<Task>> _outputController =
      BehaviorSubject.seeded(_taskList);

  // input stream
  Sink<int> get setTaskEditing => _editingController.sink;
  Sink<String> get setTaskTitle => _titleController.sink;
  Sink<bool> get setTaskIsCompleted => _isCompletedController.sink;

  // output stream
  Stream<List<Task>> get getTaskList => _outputController.stream;

  // constructor
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

  // local functions
  void _setEditing(int id) async {
    await new Future.delayed(new Duration(seconds: 3));

    // when create new task, set id = -1.
    if (id < 0) {
      _editingId = _createTask();
    } else {
      _editingId = id;
    }
  }

  void _setTitle(String title) {
    _taskList[_editingId] = _taskList[_editingId].copyWith(
      title: title,
    );
    _outputController.add(_taskList);
  }

  void _setIsCompleted(bool isCompleted) {
    _taskList[_editingId] = _taskList[_editingId].copyWith(
      isCompleted: isCompleted,
    );
    _outputController.add(_taskList);
  }

  int _createTask() {
    final int _id = _taskList.length;
    _taskList.add(new Task(
      title: '',
      isCompleted: false,
      id: _id,
    ));
    return _id;
  }

  @override
  void dispose() async {
    await _editingController.close();
    await _titleController.close();
    await _isCompletedController.close();
    await _outputController.close();
  }
}
