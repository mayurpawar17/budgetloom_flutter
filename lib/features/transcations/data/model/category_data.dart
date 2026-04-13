import 'package:flutter/material.dart';

class CategoryData {
  final IconData icon;
  final Color color;

  CategoryData({required this.icon, required this.color});
}

class CategoryMapper {
  static CategoryData getDetail(String? category) {
    // Normalize string to handle case sensitivity from API
    switch (category?.toLowerCase() ?? 'other') {
      case 'food':
      case 'groceries':
        return CategoryData(
          icon: Icons.restaurant,
          color: const Color(0xFFECECFF),
        );
      case 'travel':
      case 'transport':
        return CategoryData(
          icon: Icons.directions_car,
          color: const Color(0xFFFFE0E0),
        );
      case 'shopping':
        return CategoryData(
          icon: Icons.shopping_bag,
          color: const Color(0xFFE0F7FF),
        );
      case 'bills':
      case 'housing':
        return CategoryData(icon: Icons.home, color: const Color(0xFFFFF4E0));
      case 'entertainment':
      case 'subscriptions':
        return CategoryData(icon: Icons.movie, color: const Color(0xFFF3E5F5));
      case 'health':
      case 'personal care':
        return CategoryData(
          icon: Icons.medical_services,
          color: const Color(0xFFE8F5E9),
        );
      case 'education':
        return CategoryData(icon: Icons.school, color: const Color(0xFFFFFDE7));
      case 'insurance':
      case 'debt':
        return CategoryData(
          icon: Icons.security,
          color: const Color(0xFFFFEBEE),
        );
      case 'gift':
        return CategoryData(icon: Icons.redeem, color: const Color(0xFFFCE4EC));
      case 'savings':
        return CategoryData(
          icon: Icons.savings,
          color: const Color(0xFFE0F2F1),
        );
      default:
        return CategoryData(
          icon: Icons.category,
          color: const Color(0xFFF5F5F5),
        );
    }
  }
}
