import 'package:flutter/material.dart';
import 'package:front/model/Ingredient.dart';

Widget CountSwing(List<Ingredient> ing, int itemIndex) {
  return Card(

    child: Padding(
      padding: const EdgeInsets.all(0.0),
      child: SizedBox(
        width: 120,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _decrementButton(ing, itemIndex),
            Text(
              '${ing[itemIndex].count}',
              style: const TextStyle(fontSize: 18.0),
            ),
            _incrementButton(ing, itemIndex),
          ],
        ),
      ),
    ),
  );
}

Widget _incrementButton(List<Ingredient> ing, int index) {
  return FloatingActionButton(
    backgroundColor: Colors.white,
    mini: true,
    heroTag: 'inc_button',
    onPressed: () {
      ing[index].count++;
    },
    child: const Icon(Icons.add, color: Colors.black87),
  );
}

Widget _decrementButton(List<Ingredient> ing, int index) {
  return FloatingActionButton(
      onPressed: () {
        ing[index].count--;
      },
      heroTag: 'dec_button',
      mini: true,
      backgroundColor: Colors.white,
      child: const Icon(Icons.remove,
          color: Colors.black));
}
