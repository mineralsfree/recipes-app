import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:front/model/Recipe.dart';
import 'package:front/widgets/bottom_nav_bar.dart';
import 'package:front/widgets/image_container.dart';
import 'package:http/http.dart' as http;

Future<List<Recipe>> fetchRecipe() async {
  List<Recipe> recipes = [];
  final response = await http.get(Uri.parse('http://localhost:5000/api/recipes/?size=10&page=1'));
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
      bottomNavigationBar: const BottomNavBar(index: 1),
      body: Center(
        child: FutureBuilder<List<Recipe>>(
          future: futureRecipe,
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return Container(
                  child: ListView.builder(
                      itemCount: snapshot.data.length,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (BuildContext context, int index) {
                        return RecipeCard(recipe: snapshot.data[index]);
                      }));
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

class RecipeCard extends StatelessWidget {
  @override
  const RecipeCard({Key? key, required this.recipe}) : super(key: key);

  final Recipe recipe;

  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, RecipesScreen.routeName);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ImageContainer(
              height: 350,
                width: MediaQuery.of(context).size.width,
                imageUrl: "http://localhost:5000/imgs/default.png"),
            const SizedBox(
              height: 10,
            ),
            Text(
              maxLines: 2,
              recipe.name,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(fontWeight: FontWeight.bold, height: 1.5),
            ),
          ],
        ),
      ),
    );
  }
}
