import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_task/screens/main_screen.dart';
import 'package:test_task/services/preferences_service.dart';
import '../screens/welcome_screen.dart';
import 'main/main_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Hello',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: BlocProvider<MainBloc>(
          create: (context) =>
              MainBloc(PreferencesService())..add(CheckIfLoggedIn()),
          child: BlocBuilder<MainBloc, MainState>(
            builder: (context, state) {
              if (state is InitialState) {
                return Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else if (state is ShowLogin) {
                return WelcomeScreen();
              } else if (state is ShowAuthorizedScreen) {
                return MainScreen();
              } else {
                return Container();
              }
            },
          ),
        ));
  }
}
