import 'package:flutter/material.dart';
import 'welcome_screen.dart';
import 'db_screen.dart';
import 'api_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
void main() {
  runApp(MyApp());
}

Future<bool> isFirstLaunch() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isFirstLaunch = prefs.getBool('first_launch') ?? true;
  return isFirstLaunch;
}

Future<void> setFirstLaunch() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setBool('first_launch', false);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FutureBuilder<bool>(
        future: isFirstLaunch(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Future hasn't completed yet, return a loading indicator or splash screen.
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            // Handle error
            return Text('Error: ${snapshot.error}');
          } else {
            // If it's the first launch, show the welcome screen.
            return (snapshot.data ?? false) ?   WelcomeScreen() : ApiScreen();
          }
        },
      ),
    );
  }
}