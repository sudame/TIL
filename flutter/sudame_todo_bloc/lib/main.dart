import 'package:flutter/material.dart';
import 'package:sudame_todo_bloc/blocs/tasks_bloc.dart';
import 'package:sudame_todo_bloc/views/homepage.dart';
import 'package:sudame_todo_bloc/helpers/bloc_provider.dart';

void main() => runApp(
      BlocProvider<TaskBloc>(
        bloc: TaskBloc(),
        child: MyApp(),
      ),
    );

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}
