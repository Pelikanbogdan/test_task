import 'package:flutter/material.dart';
import 'package:test_task/preferences_service.dart';
import 'package:test_task/screens/main_screen.dart';
import 'screens/welcome_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String validatorValue = '';
  final _preferences = PreferencesService();

  void setValidatorValue() async {
    final settings = await _preferences.getLoginName();
    setState(() => validatorValue = settings);
  }

  @override
  void initState() {
    super.initState();
    setValidatorValue();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hello',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: (validatorValue == '') ? WelcomeScreen() : MainScreen(),
    );
  }
}
