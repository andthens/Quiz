import 'package:flutter/material.dart';

class ScoreboardScreen extends StatefulWidget {
  @override
  _ScoreboardScreenState createState() => _ScoreboardScreenState();
}

class _ScoreboardScreenState extends State<ScoreboardScreen> {
  List<User> users = [
    User(name: 'Alice', mark: 80),
    User(name: 'Bob', mark: 90),
    User(name: 'Charlie', mark: 70),
    User(name: 'David', mark: 85),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: ListTile(
              title: Text(users[index].name),
              trailing: Text(
                users[index].mark.toString(),
                style: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class User {
  final String name;
  final int mark;

  User({
    required this.name,
    required this.mark,
  });
}
