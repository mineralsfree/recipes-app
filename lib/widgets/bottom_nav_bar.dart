// import 'package:flutter/material.dart';
// import 'package:front/screens/history_screen.dart';
// import 'package:front/screens/recipes_screen.dart';
// import 'package:front/presentation/fridge_icon_icons.dart';
// import 'package:front/screens/fridge_screen.dart';
// import 'package:front/screens/favorite_screen.dart';
//
// import '../screens/login_screen.dart';
//
// class BottomNavBar extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() => _StatefulWidgetState();
//
//   const BottomNavBar({Key? key}) : super(key: key);
// }
// class _StatefulWidgetState extends State<BottomNavBar> {
//   int _selectedIndex = 4;
//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }
//   static const TextStyle optionStyle =
//   TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
//
//   static const List<Widget> _widgetOptions = <Widget>[
//     FavoritesScreen(),
//     RecipesScreen(),
//     HistoryScreen(),
//     FridgeScreen(),
//     LoginScreen()
//   ];
//   @override
//   Widget build(BuildContext context) {
//
//     return Scaffold(
//       body: Center(
//         child: _widgetOptions.elementAt(_selectedIndex),
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: _selectedIndex,
//         selectedItemColor: Colors.black,
//         showSelectedLabels: true,
//         showUnselectedLabels: true,
//         unselectedItemColor: Colors.black.withAlpha(100),
//         onTap: _onItemTapped,
//         items:  const <BottomNavigationBarItem>[
//           BottomNavigationBarItem(
//               icon: Icon(Icons.star_border),
//               label: 'Favorites'),
//           BottomNavigationBarItem(
//               icon: Icon(Icons.history),
//               label: 'History'),
//           BottomNavigationBarItem(
//               icon: Icon(Icons.food_bank),
//               label: 'Main'),
//           BottomNavigationBarItem(
//               icon: Icon(FridgeIcon.fridge_icon),
//               label: 'Fridge'),
//         ],
//       ),
//     );
//   }
// }
