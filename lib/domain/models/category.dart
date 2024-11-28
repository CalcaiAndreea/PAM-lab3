class Category {
  final String label;
  final bool isSelected;

  Category({
    required this.label,
    required this.isSelected,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      label: json['label'],
      isSelected: json['isSelected'],
    );
  }
}
