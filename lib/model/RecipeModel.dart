import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:front/model/Recipe.dart';

class IngredientModel extends ChangeNotifier {
  final List<Recipe> _list = [];

  UnmodifiableListView<Recipe> get items => UnmodifiableListView(_list);

  void add(Recipe ing) {
    _list.add(ing);
  }

  void removeAll() {
    _list.clear();
  }

  void replaceAll(List<Recipe> list) {
    removeAll();
    debugPrint(_list.toString());
    for (var recipe in list) {
      add(recipe);
    }
    notifyListeners();
  }
}
