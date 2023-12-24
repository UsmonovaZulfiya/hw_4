
import 'package:flutter/material.dart';
import 'package:hw_4/api_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome Screen'),
      ),
      body: Container(
        child: Column(
          children: [
            SizedBox(height: 100.0,),
            Text('Welcome to the App!'),
            SizedBox(height: 100.0,),
            ElevatedButton(
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => ApiScreen()),
                );
              },
              child: Text('Start'),
            ),
          ],

        )
      ),
    );
  }
}
