import 'package:flutter/material.dart';
import 'package:test_task/preferences_service.dart';
import 'package:test_task/screens/main_screen.dart';
import 'package:test_task/screens/unauthorized_screen.dart';

class WelcomeScreen extends StatelessWidget {
  final loginController = TextEditingController();
  final _preferencesService = PreferencesService();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  void goToUnauthorizedScreen(BuildContext ctx) {
    Navigator.of(ctx).push(
      MaterialPageRoute(builder: (_) {
        return UnauthorizedScreen();
      }),
    );
  }

  void goToMainScreen(BuildContext ctx) {
    Navigator.of(ctx).push(
      MaterialPageRoute(builder: (_) {
        return MainScreen();
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _key,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'WELCOME!',
                  textScaleFactor: 1.5,
                  style: TextStyle(
                      fontSize: 25,
                      color: Colors.blue[900],
                      fontWeight: FontWeight.bold),
                ),
                Container(
                  width: size.width * 0.35,
                  padding: EdgeInsets.all(10),
                  child: TextFormField(
                    controller: loginController,
                    validator: (value) {
                      if (value!.isNotEmpty && value.length > 2) {
                        return null;
                      } else {
                        return 'Please enter data';
                      }
                    },
                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.blue.shade900,
                        ),
                      ),
                      fillColor: Colors.blue[900],
                      hintText: 'Username',
                      hintStyle: TextStyle(
                        color: Colors.blue[900],
                        fontWeight: FontWeight.bold,
                      ),
                      icon: Icon(
                        Icons.person,
                        color: Colors.blue[900],
                      ),
                    ),
                  ),
                ),
                Container(
                  width: size.width * 0.35,
                  padding: EdgeInsets.all(10),
                  child: TextFormField(
                    obscureText: true,
                    validator: (value) {
                      if (value!.isNotEmpty && value.length > 2) {
                        return null;
                      } else {
                        return 'Please enter data';
                      }
                    },
                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.blue.shade900,
                        ),
                      ),
                      fillColor: Colors.blue[900],
                      hintText: 'Password',
                      hintStyle: TextStyle(
                        color: Colors.blue[900],
                        fontWeight: FontWeight.bold,
                      ),
                      icon: Icon(
                        Icons.lock,
                        color: Colors.blue[900],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  width: size.width * 0.35,
                  child: ElevatedButton(
                    onPressed: () {
                      if (!_key.currentState!.validate()) {
                        return;
                      }
                      _preferencesService.saveLoginName(loginController.text);
                      goToMainScreen(context);
                    },
                    child: Text(
                      'SIGN IN',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Text(
                  'or',
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.blue[900],
                      fontWeight: FontWeight.bold),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  width: size.width * 0.35,
                  child: ElevatedButton(
                    onPressed: () => goToUnauthorizedScreen(context),
                    child: Text(
                      'LIVE VIDEO',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AuthTextField extends StatelessWidget {
  final String hintText;
  final Icon prefIcon;

  AuthTextField({
    required this.hintText,
    required this.prefIcon,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.35,
      padding: EdgeInsets.all(10),
      child: TextFormField(
        obscureText: true,
        validator: (value) {
          if (value!.isNotEmpty && value.length > 2) {
            return null;
          } else {
            return 'Please enter data';
          }
        },
        decoration: InputDecoration(
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.blue.shade900,
            ),
          ),
          fillColor: Colors.blue[900],
          hintText: hintText,
          hintStyle: TextStyle(
            color: Colors.blue[900],
            fontWeight: FontWeight.bold,
          ),
          icon: prefIcon,
        ),
      ),
    );
  }
}
