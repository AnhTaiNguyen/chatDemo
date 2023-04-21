import 'package:Login_App/Screen/home_screen.dart';
import 'package:Login_App/Screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:Login_App/utils/util.dart';

class signUpScreen extends StatefulWidget {
  const signUpScreen({super.key});

  @override
  State<signUpScreen> createState() => _signUpScreenState();
}

class _signUpScreenState extends State<signUpScreen> {
  Widget topWidget(double screenWidth) {
    return Transform.rotate(
        angle: -35 * math.pi / 180,
        child: Container(
          width: 1.2 * screenWidth,
          height: 1.2 * screenWidth,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment(-0.2, -0.8),
              end: Alignment.bottomCenter,
              colors: [
                Color(0xDB4BE8CC),
                Color(0x005CDBCF),
              ],
            ),
          ),
        ));
  }

  Widget bottomWidget(double screenWidth) {
    return Transform.rotate(
        angle: -35 * math.pi / 180,
        child: Container(
          width: 1.2 * screenWidth,
          height: 1.2 * screenWidth,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment(-0.2, -0.8),
              end: Alignment.bottomCenter,
              colors: [
                Color(0x007CBFCF),
                Color(0xB316BFC4),
              ],
            ),
          ),
        ));
  }

  // Widget inform(double screenWidth) {
  //   return Container(
  //     decoration: BoxDecoration(
  //       color: Color.black90,
  //     ),
  //   )
  // }

  @override
  Widget build(BuildContext context) {
    bool validAccount = true;
    TextEditingController _controllerUsername = TextEditingController();
    TextEditingController _controllerPassword = TextEditingController();
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
        body: Stack(children: [
      Positioned(
          top: -150,
          left: screenSize.width / 2,
          child: topWidget(screenSize.width)),
      Positioned(
        top: -100,
        left: screenSize.height / -2,
        child: bottomWidget(screenSize.width),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 30.0, top: 150.0, right: 30.0),
        child: SizedBox(
          height: screenSize.height,
          width: screenSize.width,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white60,
              boxShadow: [
                BoxShadow(
                  color: Color.fromARGB(255, 5, 5, 5).withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 30.0),
                const Text("Sign Up",
                    style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                    )),
                const SizedBox(height: 20.0),
                Expanded(
                  child: Container(
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 116, 182, 176),
                      ),
                      // margin: const EdgeInsets.only(left: 30.0, right: 30.0),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(children: [
                          TextFormField(
                              controller: _controllerUsername,
                              decoration: const InputDecoration(
                                labelText: 'Username *',
                              ),
                              validator: (String? value) {
                                return (_controllerUsername.text == value
                                    ? 'loading'
                                    : null);
                              }),
                          TextFormField(
                              controller: _controllerPassword,
                              decoration: const InputDecoration(
                                labelText: 'Password *',
                              ),
                              obscureText: true,
                              enableSuggestions: false,
                              autocorrect: false,
                              validator: (String? value) {
                                return (_controllerPassword.text == value
                                    ? 'loading'
                                    : null);
                              }),
                          TextFormField(
                              decoration: const InputDecoration(
                                hintText: "Enter",
                                labelText: 'Confirm Password *',
                              ),
                              obscureText: true,
                              enableSuggestions: false,
                              autocorrect: false,
                              validator: (String? value) {
                                return (value != null ? 'loading' : null);
                              }),
                          SizedBox(height: 30.0),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Color.fromARGB(255, 182, 218, 215),
                              ),
                              onPressed: () async {
                                if (await signUp(_controllerUsername.text,
                                    _controllerPassword.text)) {
                                  print("Welcome");

                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => LoginScreen()));
                                } else {
                                  setState(() {
                                    validAccount = false;
                                  });
                                }
                                ;
                              },
                              child: Container(
                                  child: Text("Sign Up",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)))),
                        ]),
                      )),
                )
              ],
            ),
          ),
        ),
      )
    ]));
  }
}
