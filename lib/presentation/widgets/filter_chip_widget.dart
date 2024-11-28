import 'package:flutter/material.dart';

class FilterChipWidget extends StatelessWidget {
  final String label;
  final bool isSelected;

  const FilterChipWidget({required this.label, this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected
            ? Color(0xFFBE2C55).withOpacity(0.1)
            : Color(0xFFFCFCFD),
        border: Border.all(
            color: isSelected ? Color(0xFFBE2C55) : Color(0xFFD0D5DD)),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isSelected ? Color(0xFFBE2C55) : Color(0xFF475467),
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }
}
