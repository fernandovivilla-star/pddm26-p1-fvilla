import 'package:flutter/material.dart';

class FloralProduct {
  const FloralProduct({
    required this.name,
    required this.category,
    required this.price,
    required this.description,
    required this.color,
    required this.flower,
  });

  final String name;
  final String category;
  final double price;
  final String description;
  final Color color;
  final IconData flower;
}
