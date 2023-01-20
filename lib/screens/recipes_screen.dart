import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:front/model/Recipe.dart';
import 'package:front/widgets/bottom_nav_bar.dart';
import 'package:front/widgets/image_container.dart';
import 'package:http/http.dart' as http;

import '../widgets/recipe_card.dart';
import 'login_screen.dart';

Future<List<Recipe>> fetchRecipe() async {
  List<Recipe> recipes = [];
  var key = await storage.read(key: "jwt");
  final response = await http.get(
      Uri.parse('http://localhost:5000/api/recipes/recommend?size=15&page=1'),
      headers: {"Authorization": 'Bearer $key'});
  if (response.statusCode == 200) {
    final jsonData = json.decode(response.body);
    for (var rec in jsonData) {
      recipes.add(Recipe.fromJson(rec));
    }
    return recipes;
  } else {
    throw Exception('Failed to load recipes');
  }
}

class RecipesScreen extends StatefulWidget {
  const RecipesScreen({Key? key}) : super(key: key);
  static const routeName = '/recipes';

  @override
  State<StatefulWidget> createState() => _RecipesScreenState();
}

class _RecipesScreenState extends State<RecipesScreen> {
  late Future<List<Recipe>> futureRecipe;

  @override
  void initState() {
    super.initState();
    futureRecipe = fetchRecipe();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text("Recipes recommendation screen"),
        ),
      bottomNavigationBar: const BottomNavBar(index: 2),
      body: Center(
        child: FutureBuilder<List<Recipe>>(
          future: futureRecipe,
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  scrollDirection: Axis.vertical,

                  itemBuilder: (BuildContext context, int index) {
                    return RecipeCard(recipe: snapshot.data[index]);
                  });
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}


