import 'package:flutter/material.dart';
import 'package:sudame_todo/bloc/todoBloc.dart';
import 'package:sudame_todo/models/taskModel.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() => runApp(
      ToDoBlocProvider(
        child: MyApp(),
        bloc: ToDoBloc(),
      ),
    );

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class ToDoBlocProvider extends InheritedWidget {
  final ToDoBloc bloc;

  ToDoBlocProvider({Key key, @required Widget child, @required this.bloc})
      : super(key: key, child: child);

  static ToDoBloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(ToDoBlocProvider)
            as ToDoBlocProvider)
        .bloc;
  }

  @override
  bool updateShouldNotify(ToDoBlocProvider oldWidget) {
    return bloc != oldWidget.bloc;
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key key}) : super(key: key);

  final DateFormat format = new DateFormat.Hms();

  Widget _streamBuilder(BuildContext context, AsyncSnapshot snapshot) {
    return new ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        return TaskItem(task: snapshot.data[index]);
      },
      itemCount: snapshot.data.length,
    );
  }

  void showMyDialog<T>({BuildContext context, Widget child}) {
    showDialog<T>(
      context: context,
      builder: (BuildContext context) => child,
    ).then<void>((T value) {
      if (value != null) {
        print('show dialog');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final ToDoBloc _bloc = ToDoBlocProvider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('sudame ToDo'),
      ),
      body: StreamBuilder(
        stream: _bloc.tasks,
        builder: _streamBuilder,
      ),
      floatingActionButton: FloatingActionButton(
//        onPressed: () {
//          _bloc.addTask
//              .add(new TaskModel(title: format.format(DateTime.now())));
//        },
        onPressed: () {
          showMyDialog(
            context: context,
            child: FormDialog(),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class TaskItem extends StatelessWidget {
  final TaskModel task;

  TaskItem({@required TaskModel this.task, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ToDoBloc _bloc = ToDoBlocProvider.of(context);

    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Theme.of(context).dividerColor,
          ),
        ),
      ),
      child: Row(
        children: <Widget>[
          Checkbox(
            value: task.finished,
            onChanged: (bool value) {
              _bloc.taskOp.add(TaskOperate(
                  operate: Operate.update,
                  task: new TaskModel(
                    title: task.title,
                    id: task.id,
                    finished: value,
                  )));
            },
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                '[${task.id}] ${task.title}',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text('description'),
            ],
          )
        ],
      ),
    );
  }
}

class FormDialog extends StatefulWidget {
  FormDialog({Key key, @required this.task}) : super(key: key);

  final TaskModel task;

  @override
  State createState() => _FormDialogState(task: task);
}

class _FormDialogState extends State<FormDialog> {
  TaskModel task;

  _FormDialogState({this.task});
  final TextEditingController _titleController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    final ToDoBloc _bloc = ToDoBlocProvider.of(context);

    return AlertDialog(
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height * 0.3,
        child: ListView(
          children: <Widget>[
            Text('hoge'),
            Form(
              child: TextField(
                controller: _titleController,
                onChanged: (String text) {
                  print("editing: $text");
                },
              ),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        FlatButton(
            child: Text('保存'),
            onPressed: () {
              print(_titleController.value.text);
              _bloc.taskOp.add(TaskOperate(
                  operate: Operate.create,
                  task: TaskModel(title: _titleController.value.text)));
              Navigator.of(context).pop();
            }),
      ],
    );
  }
}
