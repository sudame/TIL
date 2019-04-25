class Task {
  final String title;
  final bool isCompleted;
  final int id;

  Task({
    this.title = '',
    this.isCompleted = false,
    this.id,
  });

  // 新しいTaskを作るときに呼び出す
  // Taskのインスタンスを更新するのではなく、新しいインスタンスを立てる
  Task copyWith({String title, bool isCompleted, int id}) {
    return new Task(
      title: title ?? this.title,
      isCompleted: isCompleted ?? this.isCompleted,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'iscompleted': isCompleted,
      'id': id,
    };
  }

  static Task fromMap(Map<String, dynamic> map) {
    return Task(
      title: map['title'],
      isCompleted: map['iscompleted'] == 1,
      id: map['id'],
    );
  }

  // idが同じであれば同じTaskであるとみなす
  // ==演算子の上書き
  @override
  bool operator ==(other) => this.id == other.id;

  // 同一オブジェクトであるとみなすためにはhashCodeを同一にする必要がある
  // ここではhashCodeをTaskのidにすることで解決
  @override
  int get hashCode => this.id;
}
