import 'package:flutter/material.dart';
import '../theme.dart';

class ProductCategories extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const ProductCategories({
    Key key,
    this.title,
    this.isSelected = false,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 10,
        ),
        margin: const EdgeInsets.only(right: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: isSelected ? primaryColor : bgColor5,
        ),
        child: Text(
          title,
          style: primarytextStyle.copyWith(
            fontSize: 13,
            fontWeight: medium,
            color: isSelected ? Colors.white : primarytextColor,
          ),
        ),
      ),
    );
  }
}
