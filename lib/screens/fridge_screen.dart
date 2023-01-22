import 'package:flutter/material.dart';
import 'package:front/model/Ingredient.dart';
import 'package:front/screens.dart';
import 'dart:async';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../model/IngredientModel.dart';
import '../widgets/ingredient_card.dart';

Future<List<Recipe>> fetchIngredients() async {
  List<Recipe> ingredients = [];
  var key = await storage.read(key: "jwt");
  final response = await http.get(
      Uri.parse('http://localhost:5000/api/user_ingredients'),
      headers: {"Authorization": 'Bearer $key'});
  if (response.statusCode == 200) {
    final jsonData = json.decode(response.body);
    for (var rec in jsonData) {
      ingredients.add(Recipe.fromJson(rec));
    }
    return ingredients;
  } else {
    throw Exception('Failed to load recipes');
  }
}

class FridgeScreen extends StatefulWidget {
  final String jwt;

  const FridgeScreen({Key? key, this.jwt = ''}) : super(key: key);

  static const routeName = '/fridge';

  @override
  State<StatefulWidget> createState() => _FridgeScreenState();
}

class _FridgeScreenState extends State<FridgeScreen> {
  late Future<List<Recipe>> futureIngredients;

  @override
  void initState() {
    super.initState();
    futureIngredients = fetchIngredients();
  }

  @override
  Widget build(BuildContext context) {
    var ingredients = context.watch<IngredientModel>();
    return Scaffold(
        body: Column(children: [
          Expanded(
            child: FutureBuilder(
                future: futureIngredients,
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    ingredients.items = snapshot.data;

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
                  return const Center();
                }),
          )
        ]));
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     Navigator.push(
      //         context,
      //         MaterialPageRoute(
      //           builder: (context) => const AddIngredientScreen(),
      //         )).then((_) {
      //           setState(() {
      //             futureIngredients = fetchIngredients();
      //           });
      //     });
      //   },
      //   backgroundColor: Colors.red[500],
      //   child: const Text('Add'),
      // ),
  }
}
