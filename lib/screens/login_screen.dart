import 'package:flutter/material.dart';
import 'package:front/screens.dart';
import 'package:front/screens/main_screen.dart';
import 'package:front/screens/signup_screen.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'dart:convert';
import '../widgets/custom_form_field.dart';
import 'package:flutter/foundation.dart';

const SERVER_IP = "http://localhost:5000";
const storage = FlutterSecureStorage();

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static const routeName = '/login';

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<LoginScreen> {
  Future<Map<String, dynamic>?> attemptLogIn(String username, String password) async {
    var res = await http.post(Uri.parse("$SERVER_IP/api/auth/login"),
        headers: {"Content-Type": "application/json"},
        body: json.encode({"email": username, "password": password}));
    if (res.statusCode == 200) return jsonDecode(res.body);
    return null;
  }

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _usernameController = TextEditingController();
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
          automaticallyImplyLeading: false,
          title: const Text("Login Page"),
        ),
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
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
              child: CustomFormField(
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Field email cannot be empty";
                    }
                    return null;
                  },
                  controller: _usernameController,
                  labelText: 'Email',
                  hintText: 'Enter email'),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 15),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: CustomFormField(
                validator: (val) {
                  if (val!.isEmpty) {
                    return "Field password cannot be empty";
                  }
                  return null;
                },
                controller: _passwordController,
                obscureText: true,
                labelText: 'Password',
                hintText: 'Enter password',
              ),
            ),
            Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(20)),
              child: TextButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    var username = _usernameController.text;
                    var password = _passwordController.text;
                    var data = await attemptLogIn(username, password);
                    if (data != null) {
                      String jwt = data["user"]["access"];
                      debugPrint('movieTitle: $jwt');
                      await storage.write(key: "jwt", value: jwt);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MainScreen()));
                    } else {
                      displayDialog(context, "An Error Occurred",
                          "No account was found matching that username and password");
                    }
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
                  PersistentNavBarNavigator.pushNewScreen(
                    context,
                    screen: const SignUpScreen(key: Key("signup")),
                    withNavBar: false, // OPTIONAL VALUE. True by default.
                    // pageTransitionAnimation: PageTransitionAnimation.cupertino,
                  );
                  // Navigator.pushNamed(context, SignUpScreen.routeName);
                },
                child: const Text('New User? Create Account'))
          ])),
        ));
  }
}
