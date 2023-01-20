import 'package:flutter/material.dart';
import 'package:front/screens.dart';
import 'package:front/widgets/bottom_nav_bar.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../model/Recipe.dart';
import '../widgets/recipe_card.dart';

Future<List<Recipe>> fetchUserFavorites() async {
  List<Recipe> recipes = [];
  var key = await storage.read(key: "jwt");
  final response = await http.get(
      Uri.parse('http://localhost:5000/api/user_favorites/'),
      headers: {"Authorization": 'Bearer $key'});
  if (response.statusCode == 200) {
    final jsonData = json.decode(response.body);
    for (var rec in jsonData) {
      recipes.add(Recipe.fromJson(rec));
    }
  } else {
    throw Exception('Failed to load user Favorites');
  }
  return recipes;
}

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({Key? key}) : super(key: key);
  static const routeName = '/favorites';

  @override
  State<StatefulWidget> createState() => _FavoritesState();
}

class _FavoritesState extends State<FavoritesScreen> {
  late Future<List<Recipe>> _userFavorites;

  @override
  void initState() {
    super.initState();
    _userFavorites = fetchUserFavorites();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text("Your favorite recipes"),
        ),
      body: FutureBuilder<List<Recipe>>(
        future: _userFavorites,
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                return RecipeCard(recipe: snapshot.data[index]);
              },
            );
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return const CircularProgressIndicator();
        },
      ),
      bottomNavigationBar: const BottomNavBar(index: 0),
      extendBodyBehindAppBar: true,
    );
  }
}
