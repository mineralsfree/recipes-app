import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'dart:async';
import 'dart:convert';
import '../model/Ingredient.dart';
import '../model/IngredientModel.dart';
import '../widgets/ingredient_card.dart';
import 'login_screen.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

Future<List<Recipe>> fetchPossibleIngredients() async {
  var key = await storage.read(key: "jwt");

  List<Recipe> ingredients = [];
  final response = await http.get(
      Uri.parse('http://localhost:5000/api/ingredients/?size=100&page=1'),
      headers: {"Authorization": 'Bearer $key'});
  if (response.statusCode == 200) {
    final jsonData = json.decode(response.body);
    for (var rec in jsonData) {
      ingredients.add(Recipe.fromJson(rec));
    }
    return ingredients;
  } else {
    throw Exception('Failed to load recipes');
  }
}

Future<List<Recipe>> searchIngredients(String q) async {
  var key = await storage.read(key: "jwt");

  List<Recipe> ingredients = [];
  final response = await http.get(
      Uri.parse(
          'http://localhost:5000/api/ingredients/search?string=$q&size=100&page=1'),
      headers: {"Authorization": 'Bearer $key'});
  if (response.statusCode == 200) {
    final jsonData = json.decode(response.body);
    for (var rec in jsonData) {
      ingredients.add(Recipe.fromJson(rec));
    }

    return ingredients;
  } else {
    throw Exception('Failed to load recipes');
  }
}

Future<List<Recipe>> addIngredientByEANCode(String ean) async {
  var key = await storage.read(key: "jwt");

  List<Recipe> ingredients = [];
  final response = await http.put(
    Uri.parse('http://127.0.0.1:5000/api/user_ingredients/add_by_ean'),
    headers: {
      "Authorization": 'Bearer $key',
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{'EAN': ean}),
  );
  if (response.statusCode == 200) {
    final jsonData = json.decode(response.body);
    for (var rec in jsonData) {
      ingredients.add(Recipe.fromJson(rec));
    }
    return ingredients;
  } else {
    throw Exception('Failed to load recipes');
  }
}

class AddIngredientScreen extends StatefulWidget {
  const AddIngredientScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AddIngredientScreenState();
}

class _AddIngredientScreenState extends State<AddIngredientScreen> {
  late Future<List<Recipe>> futureIngredients;
  bool _searchBoolean = false; //add
  late TextEditingController searchTextController;

  @override
  void initState() {
    super.initState();
    searchTextController = TextEditingController();
    futureIngredients = fetchPossibleIngredients();
  }

  @override
  void dispose() {
    searchTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var ingredients = context.watch<IngredientModel>();
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          appBar: AppBar(
            actions: <Widget>[
              !_searchBoolean
                  ? IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: () {
                        setState(() {
                          _searchBoolean = true;
                        });
                      })
                  : IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () async {
                        searchTextController.text = "";
                        var ing = await fetchPossibleIngredients();
                        ingredients.replaceAll(ing);
                        setState(() {
                          _searchBoolean = false;
                        });
                      }),
              IconButton(
                onPressed: () async {
                  String barcodeScanRes =
                      await FlutterBarcodeScanner.scanBarcode(
                          "#ff6666", "Cancel", false, ScanMode.BARCODE);
                  debugPrint(barcodeScanRes);

                  var result = await addIngredientByEANCode(barcodeScanRes);
                  if (result.length == 1) {
                    ingredients.replaceAll(result);
                    setState(() {
                      _searchBoolean = true;
                    });
                    searchTextController.text = result[0].name;
                    showModalBottomSheet<void>(
                      context: context,
                      builder: (BuildContext context) {
                        return Container(
                          height: 200,
                          color: Colors.white60,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Text(
                                    'Added ${result[0].quantity_increased_by} ${result[0].unit} to ${result[0].name}'),
                                ElevatedButton(
                                  child: const Text('Ok'),
                                  onPressed: () => Navigator.pop(context),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
                icon: const Icon(
                  Icons.qr_code_scanner_outlined,
                ),
              ),
            ],
            title: !_searchBoolean
                ? const Text("Add ingredients to fridge")
                : _searchTextField(context),
          ),
          body: Column(children: [
            Expanded(
              child: FutureBuilder(
                  future: futureIngredients,
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      ingredients.replaceAll(snapshot.data);

                      return ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: ingredients.items.length,
                          itemBuilder: (context, index) {
                            return IngredientCard(
                                ingredient: ingredients.items[index]);
                          });
                    } else if (snapshot.hasError) {
                      return Text(snapshot.error.toString());
                    }
                    return const Center();
                  }),
            )
          ])),
    );
  }

  Widget _searchTextField(BuildContext context) {
    //add
    var ingredients = context.read<IngredientModel>();

    return TextField(
        controller: searchTextController,
        onSubmitted: (String s) async {
          var ing = await searchIngredients(s);
          ingredients.replaceAll(ing);
          setState(() {});
        },
        // autofocus: true,
        //Display the keyboard when TextField is displayed
        cursorColor: Colors.white,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
        textInputAction: TextInputAction.search,
        //Specify the action button on the keyboard
        decoration: const InputDecoration(
          //Style of TextField
          enabledBorder: UnderlineInputBorder(
              //Default TextField border
              borderSide: BorderSide(color: Colors.white)),
          focusedBorder: UnderlineInputBorder(
              //Borders when a TextField is in focus
              borderSide: BorderSide(color: Colors.white)),
          hintText: 'Search', //Text that is displayed when nothing is entered.
          hintStyle: TextStyle(
            //Style of hintText
            color: Colors.white60,
            fontSize: 20,
          ),
        ));
  }
}
