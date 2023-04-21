import 'package:Login_App/utils/util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../models/Message.dart';

class ChatScreen extends StatefulWidget {
  ChatScreen(this.username, this.friend);
  String username;
  String friend;

  @override
  State<ChatScreen> createState() => _ChatScreenState(username, friend);
}

class _ChatScreenState extends State<ChatScreen> {
  _ChatScreenState(this.username, this.friend);
  String username;
  String friend;
  List conversationData = [];

  Future<void> getChatScreen() async {
    final response = await showMessage(username, friend);
    setState(() {
      conversationData.addAll(response);
    });
    print(conversationData);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getChatScreen();
  }

  Widget conversation() {
    var screenSize = MediaQuery.of(context).size;
    return Expanded(
        child: ListView.builder(
      itemCount: conversationData.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
            margin: EdgeInsets.only(bottom: 10.0),
            child: conversationData[index]['role'] == 'main'
                ? Row(
                    textDirection: TextDirection.rtl,
                    children: [
                      CircleAvatar(
                        backgroundColor: Color.fromARGB(255, 216, 210, 210),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(15.0)),
                          color: Colors.blue[200],
                        ),
                        margin: EdgeInsets.only(left: 5.0),
                        padding: EdgeInsets.all(10),
                        constraints: const BoxConstraints(
                          maxWidth: 200.0,
                        ),
                        child: Text(conversationData[index]["msg"]),
                      ),
                    ],
                  )
                : Container(
                    child: Row(
                    textDirection: TextDirection.ltr,
                    children: [
                      CircleAvatar(
                        backgroundColor: Color.fromARGB(255, 51, 35, 35),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(15.0)),
                          color: Colors.blue[200],
                        ),
                        margin: EdgeInsets.only(left: 5.0),
                        padding: EdgeInsets.all(10),
                        constraints: const BoxConstraints(
                          maxWidth: 200.0,
                        ),
                        child: Text(conversationData[index]["msg"]),
                      ),
                    ],
                  )));
      },
    ));
  }

  Widget keyboard() {
    return Row(children: [
      IconButton(
        icon: Icon(Icons.image),
        onPressed: () {},
      ),
      Expanded(
        child: TextField(
            textCapitalization: TextCapitalization.characters,
            decoration: InputDecoration(
              hintText: 'Aa',
              contentPadding: EdgeInsets.symmetric(horizontal: 40.0),
            )),
      ),
      IconButton(
        icon: Icon(Icons.send),
        onPressed: () {},
      )
    ]);
  }

  @override
  Widget build(BuildContext context) {
    final mainColor = Color.alphaBlend(
      Color.fromARGB(219, 194, 223, 218),
      Color.fromARGB(0, 238, 247, 246),
    );
    return Scaffold(
        backgroundColor: mainColor,
        appBar: AppBar(
            centerTitle: true,
            backgroundColor: Color.fromARGB(255, 7, 255, 218),
            elevation: 0.0,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(friend,
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white)),
                Text("Online",
                    style: TextStyle(
                        fontWeight: FontWeight.normal, color: Colors.white)),
              ],
            )),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [conversation(), keyboard()],
        ));
  }
}
