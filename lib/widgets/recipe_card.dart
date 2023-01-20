import 'package:flutter/material.dart';
import 'package:front/constants/size_constants.dart';
import 'package:front/model/Recipe.dart';
import 'package:front/screens/recipe_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import "package:front/screens/login_screen.dart";

Future<http.Response> postFavorites(int id, bool fav) async {
  var key = await storage.read(key: "jwt");
  if (fav) {
    return http.post(
      Uri.parse('http://localhost:5000/api/user_favorites/'),
      headers: <String, String>{
        'Authorization': 'Bearer $key',
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{'Id': id}),
    );
  } else {
    return http.delete(
      Uri.parse('http://localhost:5000/api/user_favorites/'),
      headers: <String, String>{
        'Authorization': 'Bearer $key',
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{'Id': id}),
    );
  }
}

class RecipeCard extends StatefulWidget {
  final Recipe recipe;

  const RecipeCard({super.key, required this.recipe});

  @override
  State<StatefulWidget> createState() => _RecipeCardState();
}

class _RecipeCardState extends State<RecipeCard> {
  bool inFav = false; //add
  late Recipe recipe;

  @override
  void initState() {
    super.initState();
    recipe = widget.recipe;
    inFav = widget.recipe.in_favorites;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RecipeScreen(recipe: recipe),
                ));
          },
          child: Card(
            elevation: Sizes.dimen_4,
            shape: const RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.all(Radius.circular(Sizes.dimen_10))),
            margin: const EdgeInsets.fromLTRB(
                Sizes.dimen_16, 0, Sizes.dimen_16, Sizes.dimen_16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ClipRRect(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(Sizes.dimen_10),
                        topRight: Radius.circular(Sizes.dimen_10)),
                    child: Image.network(
                      recipe.img_url,
                      height: 350,
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.fill,
                      // if the image is null
                      errorBuilder: (BuildContext context, Object exception,
                          StackTrace? stackTrace) {
                        return Card(
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(Sizes.dimen_10)),
                          child: const SizedBox(
                            height: 200,
                            width: double.infinity,
                            child: Icon(Icons.broken_image_outlined),
                          ),
                        );
                      },
                    )),
                const SizedBox(height: 15.0),
                Padding(
                  padding: const EdgeInsets.all(Sizes.dimen_6),
                  child: Text(
                    recipe.name,
                    maxLines: 2,
                    style: const TextStyle(
                        color: Colors.black87,
                        fontSize: Sizes.dimen_20,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(Sizes.dimen_6),
                  child: Text(
                    recipe.instructions,
                    maxLines: 2,
                    style: const TextStyle(
                        color: Colors.black54, fontSize: Sizes.dimen_14),
                  ),
                )
              ],
            ),
          ),
        ),
        Padding(
            padding: const EdgeInsets.only(left: 14),
            child: IconButton(
                onPressed: () async {
                  await postFavorites(recipe.recipeId, !inFav);
                      setState(() {
                        inFav = !inFav;
                      });
                    },
                icon: Icon(inFav ? Icons.star : Icons.star_border,
                    color: const Color(0xFFFFC107)))),
      ],
    );
  }
}
