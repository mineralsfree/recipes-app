import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:front/main.dart';
import 'package:front/model/Recipe.dart';
import 'package:front/widgets/bottom_nav_bar.dart';
import 'package:front/widgets/image_container.dart';
import 'package:http/http.dart' as http;
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../api/remote_api.dart';
import '../widgets/recipe_card.dart';

Future<List<Recipe>> fetchRecipe(BuildContext context) async {
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
  } else if (response.statusCode == 401) {
    await storage.delete(key: "jwt");
    PersistentNavBarNavigator.pushNewScreen(
      context,
      screen: MyApp(),
      withNavBar: false,
    );

    return [];
  } else {
    throw Exception('Failed to load recipes');
  }
}

class RecipesScreen extends StatefulWidget {
  const RecipesScreen({Key? key}) : super(key: key);

  // static const routeName = '/recipes';

  @override
  State<StatefulWidget> createState() => _RecipesScreenState();
}

class _RecipesScreenState extends State<RecipesScreen> {
  late Future<List<Recipe>> futureRecipe;
  static const _pageSize = 20;
  final PagingController<int, Recipe> _pagingController =
      PagingController(firstPageKey: 1);

  Future<void> _fetchPage(int pageKey) async {
    var key = await storage.read(key: "jwt");

    try {
      final newItems =
          await RemoteApi.getRecipesRecommendation(key, pageKey, _pageSize);
      final isLastPage = newItems.length < _pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + newItems.length;
        _pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      if (error is UnauthorizedException){
        await storage.delete(key: "jwt");
        PersistentNavBarNavigator.pushNewScreen(
          context,
          screen: MyApp(),
          withNavBar: false,
        );
      }
      return;
      _pagingController.error = error;
    }
  }

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
    // futureRecipe = fetchRecipe(context);
  }
  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Recipes recommendation"),
      ),
      body: Center(
        child: PagedListView<int, Recipe>(
          pagingController: _pagingController,
          builderDelegate: PagedChildBuilderDelegate<Recipe>(
            itemBuilder: (context, item, index) => RecipeCard(
              recipe: item,
            ),
          ),
        ),

      ),
    );
  }
}
