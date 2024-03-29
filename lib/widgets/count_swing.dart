import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:front/model/Ingredient.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import '../model/IngredientModel.dart';

const storage = FlutterSecureStorage();

Future<http.Response> updateIngredient(int id, int count) async {
  var key = await storage.read(key: "jwt");

  return http.put(
    Uri.parse('http://localhost:5000/api/user_ingredients/'),
    headers: <String, String>{
      'Authorization': 'Bearer $key',
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{'Id': id, 'Quantity': count}),
  );
}

Widget CountSwing(Recipe ingredient, BuildContext context) {
  return Card(
    child: Padding(
      padding: const EdgeInsets.all(0.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          _decrementButton(ingredient, context),
          SizedBox(
            width: 58,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                '${ingredient.quantity}, ${ingredient.unit}',
                style: const TextStyle(fontSize: 18.0),
              ),
            ),
          ),

          _incrementButton(ingredient, context),
        ],
      ),
    ),
  );
}

Widget _incrementButton(Recipe ingredient, BuildContext context) {
  var ingredients = context.read<IngredientModel>();

  return SizedBox(
    width: 40,
    height: 45,
    child: IconButton(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      color: Colors.white,
      onPressed: () {
        var nq = ingredient.quantity + ingredient.step;
        updateIngredient(ingredient.ingr_id, nq);
        ingredients.updateItem(ingredient, nq);
      },
      icon: const Icon(
        Icons.add,
        color: Colors.black,
      ),
    ),
  );
}

Widget _decrementButton(Recipe ingredient, BuildContext context) {
  var ingredients = context.read<IngredientModel>();
  return SizedBox(
    width: 40,
    height: 45,
    child: IconButton(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
        color: Colors.white,
        onPressed: () {
          var nq = ingredient.quantity - ingredient.step;
          if (nq >= 0) {
            updateIngredient(ingredient.ingr_id, nq);
            ingredients.updateItem(
                ingredient, ingredient.quantity - ingredient.step);
          }
        },
        icon: const Icon(Icons.remove, color: Colors.black)),
  );
}
