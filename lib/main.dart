import 'package:flutter/material.dart';
import 'package:front/screens/signup_screen.dart';

import 'screens.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Recipes front',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/login',
      routes: {
        HomeScreen.routeName: (context) => const HomeScreen(),
        RecipesScreen.routeName: (context) => const RecipesScreen(),
        FridgeScreen.routeName: (context) => const FridgeScreen(),
        LoginScreen.routeName: (context) => const LoginScreen(),
        SignUpScreen.routeName: (context) => const SignUpScreen()

      },
    );
  }

}
