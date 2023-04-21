import 'package:Login_App/Widgets/category_selector.dart';
import 'package:Login_App/Widgets/favorite_contacts.dart';
import 'package:Login_App/Widgets/recent_chats.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen(this.username);
  String username;
  @override
  _HomeScreenState createState() => _HomeScreenState(username);
}

class _HomeScreenState extends State<HomeScreen> {
  _HomeScreenState(this.username);
  String username;

  String? get msg => null;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(137, 131, 130, 130),
      appBar: AppBar(
        backgroundColor: Color(0xB316BFC4),
        leading: IconButton(
          icon: Icon(Icons.menu),
          color: Colors.white,
          onPressed: () {},
        ),
        title: Text('Chats',
            style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold)),
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.search), iconSize: 28.0, onPressed: () {}),
        ],
      ),
      body: Column(children: <Widget>[
        CategorySelector(),
        Expanded(
            child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      topRight: Radius.circular(30.0)),
                ),
                child: Column(
                  children: <Widget>[
                    FavoriteContacts(username),
                    RecentChats(username),
                  ],
                )))
      ]),
    );
  }
}
