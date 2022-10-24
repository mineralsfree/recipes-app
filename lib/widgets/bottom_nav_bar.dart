import 'package:flutter/material.dart';
import 'package:front/screens/home_screen.dart';
import 'package:front/screens/recipes_screen.dart';
import 'package:front/presentation/fridge_icon_icons.dart';
import 'package:front/screens/fridge_screen.dart';
class BottomNavBar extends StatelessWidget{
  const BottomNavBar({Key? key, required this.index}): super(key: key);
  final int index;
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(        currentIndex: index,
      selectedItemColor: Colors.black,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      unselectedItemColor: Colors.black.withAlpha(100),
      items: [
        BottomNavigationBarItem(
            icon: Container(
              margin: const EdgeInsets.only(left: 50),
              child: IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, HomeScreen.routeName);
                },
                icon: const Icon(Icons.account_circle),
              ),
            ),
            label: 'Home'),
        BottomNavigationBarItem(
            icon: IconButton(
              onPressed: () {
                Navigator.pushNamed(context, RecipesScreen.routeName);
              },
              icon: const Icon(Icons.food_bank),
            ),
            label: 'Search'),
        BottomNavigationBarItem(
            icon: Container(
              margin: const EdgeInsets.only(right: 50),
              child: IconButton(
                onPressed: () {
                  print('No profile screen yet');
                  Navigator.pushNamed(context, FridgeScreen.routeName);
                },
                icon: const Icon(FridgeIcon.fridge_icon),
              ),
            ),
            label: 'Person')
      ],
    );
  }
}