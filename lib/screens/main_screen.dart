import 'package:flutter/cupertino.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import '../presentation/fridge_icon_icons.dart';
import '../screens.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  late PersistentTabController _controller;
  late List<PersistentBottomNavBarItem> navBarsItemsNew;
  late List<Widget> screens;

  List<Widget> _buildScreens() {
    return [
      const RecipesScreen(),
      const FavoritesScreen(),
      const AddIngredientScreen(),
      const HistoryScreen(),
      const FridgeScreen(),
      // LoginScreen()
    ];
  }

  void initState() {
    super.initState();
    setState(() {
      _controller = PersistentTabController(initialIndex: 0);
    });
    screens = _buildScreens();
    navBarsItemsNew = [
      PersistentBottomNavBarItem(
        onPressed: (context) {
          setState(() {
            _controller.index = 0;
          });
        },
        icon: const Icon(Icons.food_bank),
        title: ("Recipes"),
        activeColorPrimary: Colors.red,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        onPressed: (context) {
          setState(() {
            _controller.index = 1;
          });
        },
        icon: const Icon(Icons.star_border),
        title: ("Favorites"),
        activeColorPrimary: Colors.lightBlue,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
          onPressed: (context) {
            setState(() {
              _controller.index = 2;
            });
          },
          icon: const Icon(Icons.add),
          title: ("Add"),
          activeColorPrimary: Colors.lightBlueAccent,
          inactiveColorSecondary: Colors.white,
          inactiveColorPrimary: Colors.grey,
          activeColorSecondary: Colors.white),
      PersistentBottomNavBarItem(
        onPressed: (context) {
          setState(() {
            _controller.index = 3;
          });
        },
        icon: const Icon(Icons.history),
        title: ("History"),
        activeColorPrimary: Colors.lightBlue,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        onPressed: (context) {
          setState(() {
            _controller.index = 4;
          });
        },
        icon: const Icon(FridgeIcon.fridge_icon),
        title: ("Fridge"),
        activeColorPrimary: Colors.lightBlue,
        inactiveColorPrimary: Colors.grey,
      ),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.food_bank),
        title: ("Recipes"),
        activeColorPrimary: Colors.red,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.star_border),
        title: ("Favorites"),
        activeColorPrimary: Colors.lightBlue,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
          icon: const Icon(Icons.add),
          title: ("Add"),
          activeColorPrimary: Colors.lightBlueAccent,
          inactiveColorSecondary: Colors.white,
          inactiveColorPrimary: Colors.grey,
          activeColorSecondary: Colors.white),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.history),
        title: ("History"),
        activeColorPrimary: Colors.lightBlue,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(FridgeIcon.fridge_icon),
        title: ("Fridge"),
        activeColorPrimary: Colors.lightBlue,
        inactiveColorPrimary: Colors.grey,
      ),
    ];
  }

  // LoginScreen()
  @override
  Widget build(BuildContext context) {
    switch (_controller.index) {
      case 0:
        screens[_controller.index] = RecipesScreen(key: UniqueKey());
        break;
      case 1:
        screens[_controller.index] = FavoritesScreen(key: UniqueKey());
        break;
      case 2:
        screens[_controller.index] = AddIngredientScreen(key: UniqueKey());
        break;
      case 3:
        screens[_controller.index] = HistoryScreen(key: UniqueKey());
        break;
      case 4:
        screens[_controller.index] = FridgeScreen(key: UniqueKey());
        break;
    }

    return PersistentTabView(
      context,
      controller: _controller,
      screens: screens,
      stateManagement: true,
      items: navBarsItemsNew,
      // popAllScreensOnTapOfSelectedTab: true,
      confineInSafeArea: true,
      popAllScreensOnTapOfSelectedTab: true,
      backgroundColor: Colors.white,
      // Default is Colors.white.
      handleAndroidBackButtonPress: true,
      // Default is true.
      resizeToAvoidBottomInset: false,
      // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      hideNavigationBarWhenKeyboardShows: true,
      // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
      ),
      itemAnimationProperties: const ItemAnimationProperties(
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),

      navBarStyle: NavBarStyle.style15,
    );
  }
}
