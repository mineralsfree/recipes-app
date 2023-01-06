import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:front/widgets/unordered_list.dart';

import '../model/Recipe.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/image_container.dart';
import '../widgets/nutrition_progress_bar.dart';

class RecipeScreen extends StatelessWidget {
  final Recipe recipe;

  const RecipeScreen({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
          // backgroundColor: Colors.transparent,
          // leading: IconButton(
          //   onPressed: () {},
          //   icon: const Icon(Icons.menu, color: Colors.white),
          // ),
        title: const Text("Recipe")
          ),
      body: SingleChildScrollView(
        child: Column(

          children: [
            ImageContainer(
                height: 350,
                width: MediaQuery.of(context).size.width,
                imageUrl: "http://localhost:5000/imgs/default.png"),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Text(recipe.name),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(child: UnorderedList(recipe.ingrReadable)),
                      Expanded(
                        child: Column(
                          children: [
                            Nutrition(
                                value: recipe.fat,
                                background: Colors.grey[100]!,
                                progressColor: Colors.black54,
                                label: "fat"),
                            Nutrition(
                                value: recipe.sugars,
                                background: Colors.grey[100]!,
                                progressColor: Colors.black54,
                                label: "fat"),
                            // Nutrition(ingredient.carbs, Colors.grey[100]!,
                            //     Colors.black54, "carbs"),
                            Nutrition(
                                value: recipe.protein,
                                background: Colors.grey[100]!,
                                progressColor: Colors.black54,
                                label: "protein"),
                          ],
                        ),
                      )
                    ],
                  ),
                  Text(recipe.instructions)
                ],
              ),
            ),
          ],
        ),
      ),
      // bottomNavigationBar: const BottomNavBar(index: 0),
      // extendBodyBehindAppBar: true,
    );
  }
}
