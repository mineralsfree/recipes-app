import 'package:flutter/material.dart';

import '../model/Ingredient.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import '../widgets/count_swing.dart';

class AddIngredientScreen extends StatelessWidget {
  const AddIngredientScreen({Key? key}) : super(key: key);
  static List<Ingredient> list = Ingredient.ingredients;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
      Expanded(
        child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
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
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 5.0),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Center(
                                        child: Text(
                                          list[index].title,
                                          style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                      const Text(
                                        "5 mins ago",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.grey),
                                      )
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width: 130,
                                        child: Column(
                                          children: [
                                            Row(
                                              children: const [
                                                Text("Fruit"),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                CountSwing(list, index),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Column(
                                          children: [
                                            Nutrition(
                                                list[index].fat,
                                                Colors.grey[100]!,
                                                Colors.black54,
                                                "fat"),
                                            Nutrition(
                                                list[index].sugar,
                                                Colors.grey[100]!,
                                                Colors.black54,
                                                "sugar"),
                                            Nutrition(
                                                list[index].carbs,
                                                Colors.grey[100]!,
                                                Colors.black54,
                                                "carbs"),
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
            }),
      )
    ]));
  }

  Row Nutrition(
      double value, Color background, Color progressColor, String label) {
    return Row(children: <Widget>[
      SizedBox(width: 40, child: Text(label)),
      Expanded(
        child: Column(
          children: [
            FAProgressBar(
              size: 15,
              currentValue: value,
              backgroundColor: background,
              progressColor: progressColor,
              maxValue: 100,
            ),
          ],
        ),
      )
    ]);
  }
}
