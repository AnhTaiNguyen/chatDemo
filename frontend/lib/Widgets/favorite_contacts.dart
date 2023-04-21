import 'package:flutter/material.dart';

import '../Screen/chat_screen.dart';
import '../utils/util.dart';
import '../Widgets/login_container.dart';

class FavoriteContacts extends StatefulWidget {
  FavoriteContacts(this.username);
  String username;

  @override
  State<FavoriteContacts> createState() => _FavoriteContactsState(username);
}

class _FavoriteContactsState extends State<FavoriteContacts> {
  _FavoriteContactsState(this.username);
  String username;
  List<String> favorites = [];

  Future<void> getFavorites() async {
    final response = await showListFriend(username);
    setState(() {
      favorites = response;
    });
  }

  @override
  void initState() {
    super.initState();

    getFavorites();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Favorite Contacts',
                    style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white70)),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.more_horiz),
                  iconSize: 20.0,
                  color: Colors.white70,
                ),
              ]),
        ),
        Container(
          height: 200.0,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: favorites.length,
            itemBuilder: (BuildContext context, int index) {
              // return Text(favorites[index]);
              return GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => ChatScreen(username, favorites[index])),
                ),
                child: Padding(
                  padding: EdgeInsets.only(right: 40.0, left: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      CircleAvatar(
                          radius: 40.0,
                          backgroundColor: Color.fromARGB(255, 7, 255, 218)),
                      SizedBox(height: 20.0),
                      Text(
                        favorites[index],
                        style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
