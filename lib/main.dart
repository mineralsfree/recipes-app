import 'package:flutter/material.dart';
import 'package:front/model/IngredientModel.dart';
import 'package:front/screens/signup_screen.dart';
import 'package:provider/provider.dart';

import 'screens.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (context) => IngredientModel(), child: const MyApp()));
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
          buttonTheme: const ButtonThemeData(
            minWidth: 40.0,
          )),
      initialRoute: LoginScreen.routeName,
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
