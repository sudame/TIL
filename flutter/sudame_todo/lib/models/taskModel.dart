import 'dart:math';

import 'package:flutter/widgets.dart';

class TaskModel {
  final int id;
  final String title;
  final bool finished;

  TaskModel({
    @required String title,
    int id,
    bool finished,
  })  : title = title,
        finished = finished ?? false,
        id = id ??
            Random(DateTime.now().millisecondsSinceEpoch).nextInt(100000000);

  @override
  String toString() {
    return this.title;
  }
}
