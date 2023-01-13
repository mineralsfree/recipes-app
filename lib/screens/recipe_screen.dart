import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:front/widgets/unordered_list.dart';

import '../model/Recipe.dart';
import '../widgets/image_container.dart';
import '../widgets/nutrition_progress_bar.dart';
import 'package:http/http.dart' as http;

import 'login_screen.dart';

Future<http.Response> postCooked(int id, bool cooked) async {
  var key = await storage.read(key: "jwt");
  if (cooked){
    return http.post(
      Uri.parse('http://localhost:5000/api/user_history/'),
      headers: <String, String>{
        'Authorization': 'Bearer $key',
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{'Id': id}),
    );
  } else {
    return http.delete(
      Uri.parse('http://localhost:5000/api/user_history/'),
      headers: <String, String>{
        'Authorization': 'Bearer $key',
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{'Id': id}),
    );
  }

}

class RecipeScreen extends StatefulWidget {
  final Recipe recipe;

  const RecipeScreen({super.key, required this.recipe});

  @override
  State<StatefulWidget> createState() => _RecipeScreenState();
}

class _RecipeScreenState extends State<RecipeScreen> {
  bool inCocked = false;
  late Recipe recipe;

  @override
  void initState() {
    super.initState();
    recipe = widget.recipe;
    inCocked = recipe.in_history;
  }

  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.blue;
    }
    return Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          // backgroundColor: Colors.transparent,
          // leading: IconButton(
          //   onPressed: () {},
          //   icon: const Icon(Icons.menu, color: Colors.white),
          // ),
          title: const Text("Recipe")),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ImageContainer(
                height: 350,
                width: MediaQuery.of(context).size.width,
                imageUrl: recipe.img_url),
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
                                label: "sugars"),
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
                  Text(recipe.instructions),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: CheckboxListTile(
                      title: const Text("Cocked"),

                      checkColor: Colors.white,
                      // fillColor: MaterialStateProperty.resolveWith(getColor),
                      controlAffinity: ListTileControlAffinity.leading,
                      //  <-- leading Checkbox

                      value: inCocked,
                      onChanged: (bool? value) async {
                        await postCooked(recipe.recipeId, value!);
                        setState(() {
                          inCocked = value!;
                        });
                      },
                    ),
                  )
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
