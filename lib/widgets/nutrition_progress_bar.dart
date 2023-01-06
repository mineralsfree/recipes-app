import 'package:flutter/cupertino.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';

class Nutrition extends StatelessWidget {
  final double value;
  final String label;
  final Color background;
  final Color progressColor;
  const Nutrition(
      {super.key,
      required this.value,
      required this.background,
      required this.progressColor,
      required this.label});

  @override
  Widget build(BuildContext context) {
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
              maxValue: 100,
            ),
          ],
        ),
      )
    ]);
  }
}
