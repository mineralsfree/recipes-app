import 'package:flutter/material.dart';
import 'package:front/screens.dart';
import 'package:front/widgets/bottom_nav_bar.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../model/Recipe.dart';
import '../widgets/recipe_card.dart';

Future<List<Recipe>> fetchUserHistory() async {
  List<Recipe> recipes = [];
  var key = await storage.read(key: "jwt");
  final response = await http.get(
      Uri.parse('http://localhost:5000/api/user_history/'),
      headers: {"Authorization": 'Bearer $key'});
  if (response.statusCode == 200) {
    final jsonData = json.decode(response.body);
    for (var rec in jsonData) {
      recipes.add(Recipe.fromJson(rec));
    }
  } else {
    throw Exception('Failed to load user history');
  }
  return recipes;
}

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);
  static const routeName = '/history';

  @override
  State<StatefulWidget> createState() => _HistoryState();
}

class _HistoryState extends State<HistoryScreen> {
  late Future<List<Recipe>> _userHistory;

  @override
  void initState() {
    super.initState();
    _userHistory = fetchUserHistory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Your cooked recipes"),
      ),
      body: FutureBuilder<List<Recipe>>(
        future: _userHistory,
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
      bottomNavigationBar: const BottomNavBar(index: 1),
      extendBodyBehindAppBar: true,
    );
  }
}
