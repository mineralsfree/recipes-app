import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:front/model/Ingredient.dart';

class IngredientModel extends ChangeNotifier {
  final List<Ingredient> _list = [];

  UnmodifiableListView<Ingredient> get items => UnmodifiableListView(_list);
  void add(Ingredient ing) {
    _list.add(ing);
  }
  void removeAll() {
  _list.clear();
  }
  void replaceAll(List<Ingredient> list) {

    for (var ingredient in list) {
      add(ingredient);
    }
    notifyListeners();
  }

  void updateItem(Ingredient ing, int count) {
    final index = _list.indexWhere((element) => element.ingr_id == ing.ingr_id);
    _list[index].changeQuantity(count);
    notifyListeners();

  }
}