class Todo {
  final bool complete;
  final String id;
  final String note;
  final String title;
  final bool isMain;

  const Todo(
    this.title,
    this.id, {
    this.complete = false,
    this.note = '',
    required this.isMain,
  });

  Todo copyWith({
    bool? complete,
    String? id,
    String? note,
    String? title,
    bool? isMain,
  }) {
    return Todo(
      title ?? this.title,
      id ?? this.id,
      complete: complete ?? this.complete,
      note: note ?? this.note,
      isMain: isMain ?? this.isMain,
    );
  }

  @override
  int get hashCode =>
      complete.hashCode ^
      title.hashCode ^
      note.hashCode ^
      id.hashCode ^
      isMain.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Todo &&
          runtimeType == other.runtimeType &&
          complete == other.complete &&
          title == other.title &&
          note == other.note &&
          id == other.id &&
          isMain == other.isMain;

  @override
  String toString() {
    return 'Todo { complete: $complete, title: $title, note: $note, id: $id ,isMain: $isMain,}';
  }

  List<Object?> get props => [
        complete,
        id,
        note,
        title,
        isMain,
      ];
}
