class CategoryEntity {
  final int? id;
  final String name;
  final int color;
  final bool isExpense;

  CategoryEntity({
    this.id,
    required this.name,
    required this.color,
    required this.isExpense,
  });
}
