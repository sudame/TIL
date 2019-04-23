import 'package:meta/meta.dart';

class Task {
  final String title;
  final bool isCompleted;
  final int id;

  Task({
    @required this.title,
    @required this.isCompleted,
    @required this.id,
  });

  Task copyWith({String title, bool isCompleted}) {
    return new Task(
      title: title ?? this.title,
      isCompleted: isCompleted ?? this.isCompleted,
      id: this.id,
    );
  }
}
