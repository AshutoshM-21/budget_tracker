import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class CategoryEntity extends Equatable {
  final int? id; // nullable because DB assigns it
  final String name;
  final Color color;
  final bool isExpense; // true = expense, false = income

  const CategoryEntity({
    this.id,
    required this.name,
    required this.color,
    required this.isExpense,
  });

  @override
  List<Object?> get props => [id, name, isExpense];
}
