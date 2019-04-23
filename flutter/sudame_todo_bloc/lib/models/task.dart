import 'package:meta/meta.dart';

class Task {
  final String title;
  final bool isCompleted;
  final int id;

  Task({
    @required this.title = '',
    @required this.isCompleted = false,
    @required this.id = null,
  });

  Task copyWith({String title, bool isCompleted, int id}) {
    return new Task(
      title: title ?? this.title,
      isCompleted: isCompleted ?? this.isCompleted,
      id: id ?? this.id,
    );
  }

  @override
  bool operator ==(other) => this.id == other.id;

  @override
  int get hashCode => this.id;
}
