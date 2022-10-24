import 'package:flutter/material.dart';

import '../model/Ingredient.dart';

class AddIngredientScreen extends StatelessWidget {
  const AddIngredientScreen({Key? key}) : super(key: key);
  static const List<Ingredient> list = Ingredient.ingredients;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
      Expanded(
        child: ListView.builder(
            itemCount: list.length,
            itemBuilder: (context, index) {
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Image(
                              height: 100,
                              width: 100,
                              image: NetworkImage(list[index].img_url)),
                          Text(
                            list[index].title,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(height: 5),
                        ],
                      )
                    ],
                  ),
                ),
              );
            }),
      )
    ]));
  }
}
