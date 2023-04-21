import 'dart:convert';
import 'package:Login_App/models/Message.dart';
import 'package:http/http.dart';
import 'package:flutter/material.dart';

import '../Screen/sign_up.dart';

Map<String, String> headers = {
  'Content-type': 'application/json',
  'Accept': 'application/json',
};

Future<bool> login(String username, String password) async {
  try {
    Response response = await post(Uri.parse('http://10.0.2.2:3000/login'),
        headers: headers,
        body: json.encode({'username': username, 'password': password}));
    print(response.body);
    if (response.body == 'Wrong') {
      return false;
    } else {
      return true;
    }
  } catch (e) {
    print(e.toString());
    return false;
  }
}

Future<bool> signUp(String username, String password) async {
  try {
    Response response = await post(Uri.parse('http://10.0.2.2:3000/signUp'),
        headers: headers,
        body: json.encode({'username': username, 'password': password}));
    if (response.body == 'FAILED') {
      return false;
    } else {
      print("Success");
      return true;
    }
  } catch (e) {
    print(e.toString());
    return false;
  }
}

Future<List<String>> showListFriend(String username) async {
  List<String> result = [];

  try {
    Response response = await post(Uri.parse('http://10.0.2.2:3000/friend'),
        headers: headers, body: json.encode({'username': username}));
    List<dynamic> favoritesList = json.decode(response.body);
    for (int i = 0; i < favoritesList.length; i++) {
      result.add(favoritesList[i].toString());
    }

    return result;
  } catch (e) {
    print(e.toString());
    return [];
  }
}

Future<List> showMessage(String mainUser, mainUser_friend) async {
  List result = [];
  try {
    Response response = await post(Uri.parse('http://10.0.2.2:3000/message'),
        headers: headers,
        body: json.encode(
            {'main_username': mainUser, 'friend_username': mainUser_friend}));
    List conversationData = json.decode(response.body);
    for (int i = 0; i < conversationData.length; i++) {
      result.add(conversationData[i]);
    }
    return result;
  } catch (e) {
    print(e.toString());
    return [];
  }
}

Future<List> showRecentChat(String username) async {
  List result = [];
  try {
    Response response = await post(Uri.parse('http://10.0.2.2:3000/recentChat'),
        headers: headers, body: json.encode({'main_username': username}));
    List recentData = json.decode(response.body);
    for (int i = 0; i < recentData.length; i++) {
      result.add(recentData[i]);
    }

    return result;
  } catch (e) {
    print(e.toString());
    return [];
  }
}
