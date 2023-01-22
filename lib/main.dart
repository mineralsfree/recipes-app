import 'package:flutter/material.dart';
import 'package:front/model/IngredientModel.dart';
import 'package:front/screens/favorite_screen.dart';
import 'package:front/screens/main_screen.dart';
import 'package:front/screens/signup_screen.dart';
import 'package:provider/provider.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import 'screens.dart';
import 'widgets/bottom_nav_bar.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const storage = FlutterSecureStorage();

void main() {
  runApp(ChangeNotifierProvider(
      create: (context) => IngredientModel(), child: MyApp()));
}

class MyApp extends StatelessWidget {


  MyApp({Key? key}) : super(key: key);



  Future<bool> isLogged() async {
    var token = await storage.read(key: "jwt");
    return token != null;
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // routes: {
      //   HistoryScreen.routeName: (context) => const HistoryScreen(),
      //   FavoritesScreen.routeName: (context) => const FavoritesScreen(),
      //   RecipesScreen.routeName: (context) => const RecipesScreen(),
      //   FridgeScreen.routeName: (context) => const FridgeScreen(),
      //   LoginScreen.routeName: (context) => const LoginScreen(),
      //   SignUpScreen.routeName: (context) => const SignUpScreen()
      // },
      home: FutureBuilder<bool>(
        future: isLogged(),
        builder: (context, snapshot) {

          if (snapshot.hasData && snapshot.data == true) {
            return MainScreen();
          } else if (snapshot.hasData && snapshot.data == false) {
            return LoginScreen(key: key);
          }
          return const CircularProgressIndicator();
        },
      ),
    );
  }
}
