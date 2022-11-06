import 'package:flutter/material.dart';
import 'package:front/screens.dart';
import 'package:front/screens/signup_screen.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';

const SERVER_IP = "https://wg-forge-back.herokuapp.com";
const storage = FlutterSecureStorage();

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static const routeName = '/login';

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<LoginScreen> {


  Future<String?> attemptLogIn(String username, String password) async {
    var res = await http.post(Uri.parse("$SERVER_IP/api/user/auth"),
        headers: {"Content-Type": "application/json"},

        body: json.encode({"email": username, "password": password}));
    if (res.statusCode == 200) return res.body;
    return null;
  }
  final  TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    void displayDialog(context, title, text) => showDialog(
          context: context,
          builder: (context) =>
              AlertDialog(title: Text(title), content: Text(text)),
        );
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text("Login Page"),
        ),
        body: SingleChildScrollView(
            child: Column(children: <Widget>[
          Padding(
              padding: const EdgeInsets.only(top: 60.0),
              child: Center(
                  child: SizedBox(
                      width: 200,
                      height: 150,
                      child: Image.asset('assets/images/logo.png')))),
           Padding(
            //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: TextField(
              controller: _usernameController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                  hintText: 'Enter email'),
            ),
          ),
           Padding(
            padding:
                const EdgeInsets.only(left: 15.0, right: 15.0, top: 15, bottom: 15),
            //padding: EdgeInsets.symmetric(horizontal: 15),
            child: TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                  hintText: 'Enter secure password'),
            ),
          ),
          Container(
            height: 50,
            width: 250,
            decoration: BoxDecoration(
                color: Colors.blue, borderRadius: BorderRadius.circular(20)),
            child: TextButton(
              onPressed: () async {
                var username = _usernameController.text;
                var password = _passwordController.text;
                var jwt = await attemptLogIn(username, password);
                if (jwt != null) {
                  storage.write(key: "jwt", value: jwt);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => FridgeScreen(jwt: jwt)));
                } else {
                  displayDialog(context, "An Error Occurred",
                      "No account was found matching that username and password");
                }
              },
              child: const Text(
                'Login',
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
            ),
          ),
          const SizedBox(
            height: 130,
          ),
          TextButton(
              onPressed: () {
                Navigator.pushNamed(context, SignUpScreen.routeName);
              },
              child: const Text('New User? Create Account'))
        ])));
  }
}