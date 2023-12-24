
import 'package:http/http.dart' as http;

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hw_4/db_screen.dart';
import 'user.dart';
import 'db_help.dart';

class ApiScreen extends StatefulWidget {
  @override
  _ApiScreenState createState() => _ApiScreenState();
}

class _ApiScreenState extends State<ApiScreen> {
  List<User> userList = [];
  DatabaseHelper dbHelper = DatabaseHelper();


  // Add code to fetch user information from an API
  Future<void> getdata() async {
    final response = await http.get(Uri.parse('https://randomuser.me/api'));
    if (response.statusCode == 200) {
      setState(() {
        Map<String, dynamic> originalJson = json.decode((response.body));
        // Process JSON and get the desired fields
         userList = originalJson['results']
            .map<Map<String, dynamic>>((result) => {
          'id': result['id']['value'],
          'name': '${result['name']['first']} ${result['name']['last']}',
          'email': result['email'],
        })
            .toList();
      });
    }
  }
  // Use ListView to display the user information
  // Add buttons for getting more users and storing data into SQLite database

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User List Screen'),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Card(
                elevation: 4.0,
                child: userList.isEmpty
                    ? Center(
                  child: CircularProgressIndicator(),
                )
                    : ListView.builder(
                  itemCount: userList.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(userList[index].name),
                      subtitle: Text(userList[index].email),
                    );
                  },
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: moreUsers(),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.orange,
                  ),
                  child: Text('Get More Users'),
                ),
                ElevatedButton(
                  onPressed: storeDb(),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                  ),
                  child: Text('Store Data Locally'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => DatabaseScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue,
                  ),
                  child: Text('Go to Screen3'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  moreUsers() {

  }

  storeDb() {}
}