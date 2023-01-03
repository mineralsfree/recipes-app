import 'package:flutter/material.dart';
import 'package:front/screens.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:front/widgets/custom_form_field.dart';
import 'package:front/extensions/string_apis.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);
  static const routeName = '/signup';

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUpScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Future<String?> attemptSignUp(String username, String password) async {
    var res = await http.post(Uri.parse("$SERVER_IP/api/auth/register"),
        headers: {"Content-Type": "application/json"},
        body: json.encode({"email": username, "password": password}));
    if (res.statusCode == 200) return res.body;
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text("Sign up Page"),
        ),
        body: SingleChildScrollView(
            child: Form(
          key: _formKey,
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
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Field email cannot be empty";
                  } else if (!value.isValidEmail) {
                    return "Email is invalid";
                  }
                  return null;
                },
                controller: _usernameController,
                hintText: 'Enter email',
                labelText: 'Email',
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 30),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: CustomFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Field password cannot be empty";
                    } else if (!value.isValidPassword) {
                      return "Enter valid password";
                    }
                  },
                  controller: _passwordController,
                  obscureText: true,
                  labelText: 'Password',
                  hintText: 'Enter secure password'),
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
                    var res = await attemptSignUp(username, password);
                    if (res != null) {
                      Navigator.pushNamed(context, LoginScreen.routeName);
                    }
                  }
                },
                child: const Text(
                  'Create Account',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),
            const SizedBox(
              height: 130,
            ),
            TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, LoginScreen.routeName);
                },
                child: const Text('Back to Login'))
          ]),
        )));
  }
}
