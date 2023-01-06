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
      headers: {"Authorization": 'Bearer $key'}
  );
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

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static const routeName = '/';

  @override
  State<StatefulWidget> createState() => _HomeScreenState();

}
class _HomeScreenState extends State<HomeScreen>{
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
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.menu, color: Colors.white),
        ),
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
          return CircularProgressIndicator();
        },
      ),
      bottomNavigationBar: const BottomNavBar(index: 0),
      extendBodyBehindAppBar: true,
    );
  }

}
