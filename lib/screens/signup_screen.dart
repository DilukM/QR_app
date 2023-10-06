import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

import '../reusable_widgets/reusablewidgets.dart';
import '../utils/color_util.dart';
import 'home_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _userNameTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _comfirpasswordTextController = TextEditingController();
  bool passwordsMatch = true;

  get obscureText => null;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Sign Up",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          hexStringToColor("#CB2B93"),
          hexStringToColor("#9546C4"),
          hexStringToColor("#5E61F4")
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
                20, MediaQuery.of(context).size.height * 0.2, 20, 0),
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 30,
                ),
                reusableTextField("Enter Username", Icons.person_outline, false,
                    _userNameTextController),
                const SizedBox(
                  height: 30,
                ),
                reusableTextField("Enter Email", Icons.person_outline, false,
                    _emailTextController),
                const SizedBox(
                  height: 30,
                ),
                reusableTextField("Enter Password", Icons.lock_outline, true,
                    _passwordTextController),
                const SizedBox(
                  height: 30,
                ),
                reusableTextField("Confirm Password", Icons.lock_outline, true,
                    _comfirpasswordTextController),
                const SizedBox(
                  height: 30,
                ),
                signInSignUpButton(context, false, () {
                  FirebaseAuth.instance
                      .createUserWithEmailAndPassword(
                          email: _emailTextController.text,
                          password: _passwordTextController.text)
                      .then((value) {
                    User? user = value.user;
                    if (user != null) {
                      // Store the user's name in Firebase Realtime Database
                      FirebaseDatabase.instance
                          .reference()
                          .child('admin')
                          .child(user.uid)
                          .set({
                        'name': _userNameTextController.text,
                        'admin': true
                      });
                    }
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const HomeScreen()));
                  }).onError((error, stackTrace) {
                    print("Error: ${error.toString()}");
                  });
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
