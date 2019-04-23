import 'dart:collection';

import 'package:sudame_todo_bloc/models/task.dart';
import 'package:meta/meta.dart';

class TaskList {
  final int maxID;
  final UnmodifiableListView<Task> taskList;
  final int editingTaskId;

  TaskList({
    @required this.maxID,
    @required this.editingTaskId,
    @required this.taskList,
  });

  int getTaskIndex() {
    final int index = taskList.indexWhere((Task t) {
      return t.id == editingTaskId;
    });

    if (index >= 0) return index;
  }

  UnmodifiableListView _addTask(Task task) {
    List<Task> _taskList = this.taskList.cast();
    _taskList.add(task);
    return UnmodifiableListView(_taskList);
  }

  TaskList setEditing(int id) {
    return new TaskList(
      maxID: this.maxID,
      editingTaskId: id,
      taskList: this.taskList,
    );
  }

  TaskList update(Task t) {
    if (t.id < 0) {
      final _task = t.copyWith(id: this.maxID + 1);
      return new TaskList(
        maxID: maxID + 1,
        taskList: _addTask(_task),
        editingTaskId: 0,
      );
    }
  }

  Task operator [](int index) {
    return taskList[index];
  }
}
