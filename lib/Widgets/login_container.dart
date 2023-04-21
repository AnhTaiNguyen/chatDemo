import 'package:Login_App/Screen/sign_up.dart';
import 'package:Login_App/utils/util.dart';
import 'package:flutter/material.dart';
import '../Screen/home_screen.dart';

class loginContainer extends StatefulWidget {
  const loginContainer({super.key});

  @override
  State<loginContainer> createState() => _loginContainerState();
}

class _loginContainerState extends State<loginContainer> {
  late final List<Widget> loginContent;
  late final List<Widget> signUp;
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  // Handle error message when login wrong
  bool validAccount = true;

  Widget inputField(String hint, _isHidden, txtController) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 38.0, vertical: 6.0),
        child: SizedBox(
            height: 30.0,
            child: Material(
                elevation: 5,
                borderRadius: BorderRadius.circular(30.0),
                child: TextField(
                    controller: txtController,
                    obscureText: _isHidden,
                    textAlignVertical: TextAlignVertical.bottom,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide.none),
                      filled: true,
                      fillColor: Colors.white,
                      hintText: hint,
                    )))));
  }

  Widget loginButton(String title) {
    return Container(
      child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 38.0, vertical: 8.0),
          child: ElevatedButton(
            onPressed: () async {
              if (await login(
                  _usernameController.text, _passwordController.text)) {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => HomeScreen(_usernameController.text),
                ));
              } else {
                setState(() {
                  validAccount = false;
                });
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromARGB(255, 116, 182, 176),
              padding: EdgeInsets.symmetric(vertical: 4),
              elevation: 4.0,
              shape: const StadiumBorder(),
              shadowColor: Colors.black87,
            ),
            child: Text(
              title,
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
          )),
    );
  }

  Widget registerButton(String title) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 38.0, vertical: 8.0),
        child: ElevatedButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => signUpScreen(),
            ));
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Color.fromARGB(255, 116, 182, 176),
            padding: EdgeInsets.symmetric(vertical: 4),
            elevation: 4.0,
            shape: const StadiumBorder(),
            shadowColor: Colors.black87,
          ),
          child: Text('Register',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            inputField('Username', false, _usernameController),
            inputField('Password', true, _passwordController),
            (validAccount == false)
                ? Padding(
                    padding: EdgeInsets.only(left: 50),
                    child:
                        Text('Try Again', style: TextStyle(color: Colors.red)))
                : Text(""),
            loginButton('Login'),
            registerButton('Register'),
          ],
        ),
      ],
    );
  }
}
