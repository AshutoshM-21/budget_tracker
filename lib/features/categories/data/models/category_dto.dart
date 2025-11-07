import 'package:budget_tracker/services/db/drift/app_database.dart';
import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import '../../domain/entities/category_entity.dart';

class CategoryDto {
  final int? id;
  final String name;
  final int color;
  final bool isExpense;

  CategoryDto({
    this.id,
    required this.name,
    required this.color,
    required this.isExpense,
  });

  // Entity → DTO
  factory CategoryDto.fromEntity(CategoryEntity entity) {
    return CategoryDto(
      id: entity.id,
      name: entity.name,
      color: entity.color.value,
      isExpense: entity.isExpense,
    );
  }

  // Row → DTO
  factory CategoryDto.fromRow(CategoriesTableData row) {
    return CategoryDto(
      id: row.id,
      name: row.name,
      color: row.color,
      isExpense: row.isExpense,
    );
  }

  // DTO → Drift Companion
  CategoriesTableCompanion toCompanion() {
    return CategoriesTableCompanion(
      id: id == null ? const Value.absent() : Value(id!),
      name: Value(name),
      color: Value(color),
      isExpense: Value(isExpense),
    );
  }

  // DTO → Entity
  CategoryEntity toEntity() {
    return CategoryEntity(
      id: id,
      name: name,
     color: Color(color), 
      isExpense: isExpense,
    );
  }
}
