import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'dart:async';
import 'dart:convert';
import '../model/Ingredient.dart';
import '../model/IngredientModel.dart';
import '../widgets/ingredient_card.dart';
import 'login_screen.dart';


Future<List<Ingredient>> fetchPossibleIngredients() async {
  var key = await storage.read(key: "jwt");

  List<Ingredient> ingredients = [];
  final response = await http.get(
      Uri.parse('http://localhost:5000/api/ingredients/?size=15&page=1'),
      headers: {"Authorization": 'Bearer $key'});
  if (response.statusCode == 200) {
    final jsonData = json.decode(response.body);
    for (var rec in jsonData) {
      ingredients.add(Ingredient.fromJson(rec));
    }
    return ingredients;
  } else {
    throw Exception('Failed to load recipes');
  }
}

class AddIngredientScreen extends StatefulWidget {
  const AddIngredientScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AddIngredientScreenState();
}

class _AddIngredientScreenState extends State<AddIngredientScreen> {
  late Future<List<Ingredient>> futureIngredients;

  @override
  void initState() {
    super.initState();
    futureIngredients = fetchPossibleIngredients();
  }

  @override
  Widget build(BuildContext context) {
    var ingredients = context.watch<IngredientModel>();
    return Scaffold(
        appBar: AppBar(
          title: const Text("Add ingredients to fridge"),
        ),
        body: Column(children: [
          Expanded(
            child: FutureBuilder(
                future: futureIngredients,
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    if (ingredients.items.isEmpty) {
                      ingredients.replaceAll(snapshot.data);
                    }
                    return ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: ingredients.items.length,
                        itemBuilder: (context, index) {
                          return IngredientCard(
                              ingredient: ingredients.items[index]);
                        });
                  } else if (snapshot.hasError) {
                    return Text(snapshot.error.toString());
                  }
                  return const CircularProgressIndicator();
                }),
          )
        ]));
  }
}
