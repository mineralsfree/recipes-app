import 'package:flutter/foundation.dart';

class Ingredient {
  final int ingr_id;
  final String name;
  int quantity;
  final String img_url;
  final double fat;
  final double sug;
  final double carbs;
  final String unit;
  final String date;
  final int step;

  Ingredient({
    required this.ingr_id,
    required this.name,
    this.img_url =
        'https://i.imgur.com/ERZ6kqR_d.webp?maxwidth=760&fidelity=grand',
    required this.fat,
    required this.sug,
    required this.carbs,
    required this.unit,
    required this.step,
    required this.date,
    this.quantity = 0,
  });
  void changeQuantity(int q){
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
  factory Ingredient.fromJson(Map<String, dynamic> json) {
    debugPrint(json.toString());
    return Ingredient(
      ingr_id: json['ingr_id'],
      date: json['date'] ?? "",
      quantity: json['quantity'].toInt() ?? 0,
      name: json['name'] ?? "",
      img_url: json['img_url'] ?? 'https://i.imgur.com/ERZ6kqR_d.webp?maxwidth=760&fidelity=grand',
      fat: json['fat'],
      sug: json['sug'],
      carbs: json['sod'],
      unit: json['unit'] ?? "g",
      step: json['step'].toInt(),
    );
  }
}
