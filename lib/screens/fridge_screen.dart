import 'package:flutter/material.dart';
import 'package:front/model/Ingredient.dart';
import 'package:front/screens.dart';
import 'dart:async';

import 'package:http/http.dart' as http;
import 'dart:convert';

import '../widgets/bottom_nav_bar.dart';
import '../widgets/ingredient_card.dart';

Future<List<Ingredient>> fetchIngredients() async {
  List<Ingredient> ingredients = [];
  var key = await storage.read(key: "jwt");

  final response = await http.get(
      Uri.parse('http://localhost:5000/api/user_ingredients'),
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

class FridgeScreen extends StatefulWidget {
  final String jwt;

  const FridgeScreen({Key? key, this.jwt = ''}) : super(key: key);

  static const routeName = '/fridge';

  @override
  State<StatefulWidget> createState() => _FridgeScreenState();
}

class _FridgeScreenState extends State<FridgeScreen> {
  late Future<List<Ingredient>> futureIngredients;

  @override
  void initState() {
    super.initState();
    futureIngredients = fetchIngredients();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const BottomNavBar(index: 2),
      body: Center(
          child: FutureBuilder<List<Ingredient>>(
            future: futureIngredients,
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return Container(
                  child: ListView.builder(
                      itemCount: snapshot.data.length,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (BuildContext context, int index) {
                        return IngredientCard(ingredient: snapshot.data[index]);
                      }),
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              return const CircularProgressIndicator();
            },
          )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AddIngredientScreen(),
              )).then((_) {
                setState(() {
                  futureIngredients = fetchIngredients();
                });
          });
        },
        child: Text('Add'),
        backgroundColor: Colors.red[500],
      ),
    );
  }
}
