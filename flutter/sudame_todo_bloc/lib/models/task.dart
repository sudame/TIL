class Task {
  final String title;
  final bool isCompleted;
  final int id;

  Task({
    this.title = '',
    this.isCompleted = false,
    this.id,
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
