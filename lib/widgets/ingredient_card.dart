import 'package:flutter/cupertino.dart';
import 'package:front/model/Ingredient.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import '../widgets/count_swing.dart';

class IngredientCard extends StatelessWidget {
  const IngredientCard({Key? key, required this.ingredient}) : super(key: key);
  final Ingredient ingredient;

  @override
  Widget build(BuildContext context) {
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
                    image: NetworkImage(ingredient.img_url)),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 5.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Center(
                              child: Text(
                                ingredient.name,
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w700),
                              ),
                            ),
                            Text(
                              ingredient.date,
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 150,
                              child: Column(
                                children: [
                                  Row(
                                    children: const [
                                      // Text("Fruit"),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      CountSwing(ingredient, context),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  Nutrition(ingredient.fat, Colors.grey[100]!,
                                      Colors.black54, "fat"),
                                  Nutrition(ingredient.sug, Colors.grey[100]!,
                                      Colors.black54, "sugar"),
                                  // Nutrition(ingredient.carbs, Colors.grey[100]!,
                                  //     Colors.black54, "carbs"),
                                  Nutrition(ingredient.pro, Colors.grey[100]!,
                                      Colors.black54, "protein"),
                                ],
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 5),
              ],
            )
          ],
        ),
      ),
    );
  }

  Row Nutrition(
      double value, Color background, Color progressColor, String label) {
    return Row(children: <Widget>[
      SizedBox(width: 44, child: Text(label)),
      Expanded(
        child: Column(
          children: [
            FAProgressBar(
              size: 15,
              currentValue: value,
              backgroundColor: background,
              progressColor: progressColor,
              maxValue: 1,
            ),
          ],
        ),
      )
    ]);
  }
}
