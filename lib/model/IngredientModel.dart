import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:front/model/Ingredient.dart';

class IngredientModel extends ChangeNotifier {
   List<Recipe> _list = [];

  UnmodifiableListView<Recipe> get items => UnmodifiableListView(_list);
  void add(Recipe ing) {
    _list.add(ing);
  }
  void removeAll() {
  _list.clear();
  }
  set items(List<Recipe> list){
    _list = list;
  }
  void replaceAll(List<Recipe> list) {
    removeAll();
    for (var ingredient in list) {
      add(ingredient);
    }
    notifyListeners();
  }

  void updateItem(Recipe ing, int count) {
    debugPrint(_list.toString());
    final index = _list.indexWhere((element) => element.ingr_id == ing.ingr_id);
    _list[index].changeQuantity(count);
    notifyListeners();

  }
}