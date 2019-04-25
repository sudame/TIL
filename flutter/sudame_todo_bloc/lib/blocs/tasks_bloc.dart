// dart lang
import 'dart:async';

// 3rd party packages
import 'package:bloc_provider/bloc_provider.dart';
import 'package:rxdart/subjects.dart';

// self packages
import 'package:sudame_todo_bloc/models/task.dart';
import 'package:sudame_todo_bloc/repositories/task_io.dart';

// CRUDアクションの設定(Readは無し)
enum TaskEventAction {
  create,
  update,
  delete,
}

// TaskをC(R)UDする指示を出すイベントクラス
class TaskEvent<T> {
  final TaskEventAction action;
  final Task task;

  TaskEvent({this.action, this.task});
}

// BLoC本体
class TasksBloc implements Bloc {
  // Task I/O
  // SQLiteとのやり取り
  final TaskRepository tr = new TaskRepository();

  // 入力Streamの制御
  final StreamController<TaskEvent> _inputController = StreamController();

  // 出力Streamの制御
  final BehaviorSubject<List<Task>> _outputController =
      BehaviorSubject.seeded([]);

  // 入力Stream
  Sink<TaskEvent> get setTask => _inputController.sink;

  // 出力Stream
  Stream<List<Task>> get getTaskList => _outputController.stream;

  void _initBloc() async {
    _outputController.add(await tr.tasks);
  }

  // Taskを新規で作る
  void _createTask({Task task}) async {
    await tr.insertTask(Task(
      title: task.title ?? '',
      isCompleted: task.isCompleted ?? false,
      id: null,
    ));
  }

  // Taskの更新
  void _update(Task task) async {
    await tr.updateTask(task);
  }

  // Taskの削除
  void _delete(Task task) async {
    await tr.deleteTask(task);
  }

  // 入力Streamのリスナ
  void _taskEventListener(TaskEvent e) async {
    if (e.action == TaskEventAction.create) {
      // createアクションだった場合
      _createTask(task: e.task);
    } else if (e.action == TaskEventAction.update) {
      // updateアクションだった場合
      _update(e.task);
    } else if (e.action == TaskEventAction.delete) {
      // deleteアクションだった場合
      _delete(e.task);
    }
    // Taskのリスト更新後、出力Streamに流し込む
    _outputController.add(await tr.tasks);
  }

  // コンストラクタ
  TasksBloc() {
    // 入力Streamをリッスンしてリスナを登録
    _inputController.stream.listen(_taskEventListener);

    // 初期化
    _initBloc();
  }

  // ステートが破棄された場合、Streamを閉じて破棄する
  @override
  void dispose() async {
    await _inputController.close();
    await _outputController.close();
  }
}
