import 'package:flutter/foundation.dart';

class Recipe {
  final int ingr_id;
  final String name;
  int quantity;
  final String img_url;
  final double fat;
  final double sug;
  final double carbs;
  final double pro;
  final String unit;
  final String date;
  final int step;
  final int weight_per_unit;
  final int? quantity_increased_by;

  Recipe({
    required this.ingr_id,
    required this.name,
    this.img_url =
        'https://i.imgur.com/ERZ6kqR_d.webp?maxwidth=760&fidelity=grand',
    required this.fat,
    required this.sug,
    required this.carbs,
    required this.pro,
    required this.unit,
    required this.step,
    required this.date,
    required this.weight_per_unit,
    this.quantity_increased_by,
    this.quantity = 0,
  });

  void changeQuantity(int q) {
    quantity = q;
  }

  // static List<Ingredient> ingredients = [
  //   Ingredient(
  //       ingr_id: 1,
  //       name: 'apple',
  //       fat: 0,
  //       sug: 19,
  //       carbs: 25,
  //       img_url:
  //       'https://i.imgur.com/ERZ6kqR_d.webp?maxwidth=760&fidelity=grand',
  //       step: 100,
  //       date: '2022-12-17',
  //       unit: "g"),
  // ];
  factory Recipe.fromJson(Map<String, dynamic> json) {
    if (json['unit'] == 'unit') {
      json['unit'] = "pcs";
    }

    return Recipe(
        ingr_id: json['ingr_id'],
        date: json['date'] ?? "",
        quantity: json['quantity']?.toInt() ?? 0,
        name: json['name'] ?? "",
        img_url: json['img_url'] ?? 'http://localhost:5000/imgs/default.png',
        fat: json['fat'],
        sug: json['sug'],
        carbs: json['sod'],
        pro: json['pro'],
        unit: json['unit'] ?? "g",
        weight_per_unit: json['weight_per_unit'],
        step: json['step'].toInt(),
        quantity_increased_by: json['quantity_increased_by']);
  }
}
