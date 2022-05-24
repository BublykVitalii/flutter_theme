import 'package:equatable/equatable.dart';

class Todos extends Equatable {
  final String? tasks;
  final int id;
  const Todos({
    required this.tasks,
    required this.id,
  });

  @override
  List<Object?> get props => [
        tasks,
        id,
      ];
}
