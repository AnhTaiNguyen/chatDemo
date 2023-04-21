import 'package:Login_App/Screen/chat_screen.dart';
import 'package:Login_App/Widgets/favorite_contacts.dart';
import 'package:Login_App/utils/util.dart';
import 'package:flutter/material.dart';
import '../Screen/home_screen.dart';
import '../models/Message.dart';

class RecentChats extends StatefulWidget {
  RecentChats(this.username);
  String username;

  @override
  State<RecentChats> createState() => _RecentChatsState(username);
}

class _RecentChatsState extends State<RecentChats> {
  _RecentChatsState(this.username);
  String username;

  List recentData = [];
  Future<void> getRecentChat() async {
    final response = await showRecentChat(username);
    setState(() {
      recentData.addAll(response);
    });
    print(recentData);
  }

  @override
  void initState() {
    super.initState();
    getRecentChat();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment(-0.2, -0.8),
            end: Alignment.bottomCenter,
            colors: [
              Color(0x007CBFCF),
              Color(0xB316BFC4),
            ],
          ),
        ),
        child: ListView.builder(
            itemCount: recentData.length,
            itemBuilder: (BuildContext context, int index) {
              var friend = recentData[index]["from"] != username
                  ? recentData[index]["from"]
                  : recentData[index]["to"];

              return GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ChatScreen(username, friend),
                  ),
                ),
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  margin: EdgeInsets.only(bottom: 8.0, top: 8.0),
                  decoration: BoxDecoration(color: Color(0xFFFFFEFEE)),
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        CircleAvatar(radius: 25.0, backgroundColor: Colors.red),
                        SizedBox(width: 10.0),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(friend,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0,
                                      color: Colors.blueGrey)),
                              Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.5,
                                  child: Text(
                                    recentData[index]["msg"],
                                    style: TextStyle(color: Colors.blueGrey),
                                    overflow: TextOverflow.ellipsis,
                                  )),
                            ])
                      ]),
                ),
              );
            }),
      ),
    );
  }
}
