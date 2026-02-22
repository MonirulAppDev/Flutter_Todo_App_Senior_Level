import 'package:equatable/equatable.dart';

class TodoEntity extends Equatable {
  final int id;
  final String title;
  final String description;
  final DateTime date;
  final bool isCompleted;
  final String category;
  final int colorCode;

  const TodoEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.isCompleted,
    required this.category,
    required this.colorCode,
  });

  @override
  List<Object?> get props => [
    id,
    title,
    description,
    date,
    isCompleted,
    category,
    colorCode,
  ];

  TodoEntity copyWith({
    int? id,
    String? title,
    String? description,
    DateTime? date,
    bool? isCompleted,
    String? category,
    int? colorCode,
  }) {
    return TodoEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      date: date ?? this.date,
      isCompleted: isCompleted ?? this.isCompleted,
      category: category ?? this.category,
      colorCode: colorCode ?? this.colorCode,
    );
  }
}
