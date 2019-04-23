import 'package:flutter/material.dart';
import 'package:sudame_todo_bloc/blocs/tasks_bloc.dart';
import 'package:sudame_todo_bloc/views/screens/homepage.dart';
import 'package:bloc_provider/bloc_provider.dart';

void main() => runApp(
      BlocProvider<TasksBloc>(
        creator: (_context, _bag) => TasksBloc(),
        child: MyApp(),
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
      home: HomePage(),
    );
  }
}
