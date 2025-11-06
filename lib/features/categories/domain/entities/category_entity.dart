import 'package:equatable/equatable.dart';

class CategoryEntity extends Equatable {
  final int? id; // nullable because DB assigns it
  final String name;
  final String icon;
  final bool isExpense; // true = expense, false = income

  const CategoryEntity({
    this.id,
    required this.name,
    required this.icon,
    required this.isExpense,
  });

  @override
  List<Object?> get props => [id, name, icon, isExpense];
}
