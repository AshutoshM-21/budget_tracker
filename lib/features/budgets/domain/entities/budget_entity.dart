import 'package:equatable/equatable.dart';

class BudgetEntity extends Equatable {
   final int? id;
  final int categoryId;
  final double limitAmount;
  final double spentAmount; // will update from DB queries

  const BudgetEntity({
    this.id,
    required this.categoryId,
    required this.limitAmount,
    required this.spentAmount,
  });

  @override
  List<Object?> get props => [id, categoryId, limitAmount, spentAmount];  
} 
