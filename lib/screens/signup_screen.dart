import 'package:flutter/material.dart';
import 'package:front/screens.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);
  static const routeName = '/signup';

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            automaticallyImplyLeading: false,
          title: const Text("Sign up Page"),
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
                        left: 15.0, right: 15.0, top: 15, bottom: 30),
                    //padding: EdgeInsets.symmetric(horizontal: 15),
                    child: TextField(

                      obscureText: true,
                      decoration: InputDecoration(
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
                      onPressed: () {
                        Navigator.pushNamed(
                            context, LoginScreen.routeName);
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
                  TextButton(onPressed: () {
                    Navigator.pushNamed(
                        context, LoginScreen.routeName);
                  },
                      child: const Text('Back to Login')
                  )
                ]
            )
        )
    );
  }

}