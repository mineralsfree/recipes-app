import 'package:flutter/material.dart';
import 'package:front/screens.dart';

import '../widgets/bottom_nav_bar.dart';

class FridgeScreen extends StatelessWidget {
  final String jwt;
  const FridgeScreen({Key? key, this.jwt = ''}) : super(key: key);

  static const routeName = '/fridge';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const BottomNavBar(index: 2),
      body: const Center(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AddIngredientScreen(),
              ));
        },
        child: Text('Add'),
        backgroundColor: Colors.red[500],
      ),
    );
  }
}
