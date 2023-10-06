import 'dart:async';

import 'package:admin/screens/signup_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../reusable_widgets/reusablewidgets.dart';
import '../utils/color_util.dart';
import 'home_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                //logoWidget("assests/images/admin.png"),
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
                forgetPassword(context),
                signInSignUpButton(context, true, () {
                  FirebaseAuth.instance
                      .signInWithEmailAndPassword(
                          email: _emailTextController.text,
                          password: _passwordTextController.text)
                      .then((value) {
                    print("sign in success");
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => const HomeScreen()));
                  }).onError((error, stackTrace) {
                    print("Error: ${error.toString()}");
                  });
                  /*FirebaseAuth.instance
                      .signInWithEmailAndPassword(
                          email: _emailTextController.text,
                          password: _passwordTextController.text)
                      .then((value) {
                    DatabaseReference adminRef = FirebaseDatabase.instance
                        .reference()
                        .child('admin')
                        .child(value.user!.uid);

                    adminRef
                        .once()
                        .then((DataSnapshot snapshot) {
                          Map<String, dynamic>? data =
                              snapshot.value as Map<String, dynamic>?;

                          if (data != null) {
                            bool isAdmin = data['admin'] ??
                                false; // Assuming false if 'admin' is not present

                            if (isAdmin) {
                              print("User is an admin");
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HomeScreen()));
                            } else {
                              print("User is not an admin");
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HomeScreen()));
                            }
                          } else {
                            print('User data not found in the database');
                          }
                        } as FutureOr Function(DatabaseEvent value))
                        .catchError((error) {
                      print("Error retrieving user data: $error");
                    });
                  }).catchError((error) {
                    print("Error: $error");
                  });*/
                }),
                signUpOption()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row signUpOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Don't have account?  ",
            style: TextStyle(color: Colors.white70)),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const SignUpScreen()));
          },
          child: const Text("Sign Up",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        )
      ],
    );
  }

  Widget forgetPassword(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 35,
      alignment: Alignment.bottomRight,
      child: TextButton(
        child: const Text(
          "Forgot Password? ",
          style: TextStyle(color: Colors.white70),
          textAlign: TextAlign.right,
        ),
        onPressed: () {},
      ),
    );
  }
}
