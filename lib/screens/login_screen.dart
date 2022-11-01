import 'package:flutter/material.dart';
import 'package:front/screens.dart';
import 'package:front/screens/signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static const routeName = '/login';

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text("Login Page"),
        ),
        body: SingleChildScrollView(
            child: Column(
                children: <Widget>[
                  Padding(padding: const EdgeInsets.only(top: 60.0),
                      child: Center(
                          child: SizedBox(
                              width: 200,
                              height: 150,
                              child: Image.asset('assets/images/logo.png'))
                      )
                  ),
                  const Padding(
                    //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: TextField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Email',
                          hintText: 'Enter email'),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 15, bottom: 15),
                    //padding: EdgeInsets.symmetric(horizontal: 15),
                    child: TextField(

                      obscureText: true,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Password',
                          hintText: 'Enter secure password'),
                    ),
                  ),
                  TextButton(              onPressed: (){
                    //TODO FORGOT PASSWORD SCREEN GOES HERE
                  },
                    child: const Text(
                      'Forgot Password',
                      style: TextStyle(color: Colors.blue, fontSize: 15),
                    ),
                  ),
                  Container(
                    height: 50,
                    width: 250,
                    decoration: BoxDecoration(
                        color: Colors.blue, borderRadius: BorderRadius.circular(20)),
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(
                            context, FridgeScreen.routeName);
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
                  TextButton(onPressed: () {
                    Navigator.pushNamed(
                        context, SignUpScreen.routeName);
                  },
                    child: const Text('New User? Create Account')
                  )
                ]
            )
        )
    );
  }

}