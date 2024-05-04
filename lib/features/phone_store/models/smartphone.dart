// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

class SmartPhone {
  final String imagePATH;
  final String name;
  final SmartPhoneCategory category;
  final int price;
  final String description;
  final double rating;
  final String model;
  List<ModelColor> modelColors;
  List<ModelMemory> modelMemories;
  List<String> warehouses;

  SmartPhone({
    required this.price,
    required this.imagePATH,
    required this.description,
    required this.rating,
    required this.name,
    required this.category,
    required this.model,
    required this.modelColors,
    required this.modelMemories,
    required this.warehouses,
  });
}

enum SmartPhoneCategory {
  iPhone,
  Samsung,
  Oppo,
  XiaoMi,
  OnePlus,
}

class ModelMemory {
  final int memory;
  final int additionalPrice;
  ModelMemory({required this.memory, required this.additionalPrice});
}

class ModelColor {
  final String imagePATH;
  final Color color;
  final String name;
  final int additionalPrice;
  ModelColor({
    required this.imagePATH,
    required this.color,
    required this.name,
    required this.additionalPrice,
  });
}
