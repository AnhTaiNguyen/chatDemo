const express = require("express");
const app = express();
var cors = require("cors");
const port = 3000;
const fs = require("fs");

app.use(express.json());
app.use(cors());

app.post("/login", (req, res) => {
  var { username, password } = req.body;
  console.log(username, password);

  fs.readFile("user.json", (err, text) => {
    if (err) throw err;
    user = JSON.parse(text);

    for (var key in user) {
      let user_info = user[key];
      console.log(user_info);
      if (username == user_info.username && password == user_info.password) {
        return res.send("Right");
      }
    }
    res.send("Wrong");
  });
});

app.post("/signUp", (req, res) => {
  var { username, password } = req.body;
  console.log("Register account :", username, password);

  fs.readFile("user.json", "utf8", function (err, text) {
    var json = JSON.parse(text); // Object
    let userLength = Object.keys(json).length;

    for (var key in json) {
      let user_info = json[key];
      if (user_info.username == username) {
        console.log("This account already exist");
        return res.send("FAILED");
      }
    }

    json[`user${userLength + 1}`] = { username, password };

    fs.writeFile(
      "user.json",
      JSON.stringify(json, null, 2),
      function (err, result) {
        if (err) console.log(err);
      }
    );

    console.log("NEW ACCOUNT");
    console.log(JSON.stringify(json, null, 2));
    res.send("NEW");
  });
});

app.post("/friend", (req, res) => {
  var { username } = req.body;
  var friendList = [];

  fs.readFile("user.json", "utf8", function (err, text) {
    var user = JSON.parse(text);
    for (var key in user) {
      let friend_info = user[key];
      if (username != user[key].username) {
        friendList.push(friend_info.username);
      }
    }

    res.send(friendList);

    friendList[username] = {};

    fs.writeFile(
      "listFriend.json",
      JSON.stringify(friendList, null, 2),
      function (err) {
        if (err) console.log(err);
      }
    );
  });
});

app.post("/message", (req, res) => {
  var { main_username, friend_username } = req.body;

  fs.readFile("message.json", "utf8", function (err, text) {
    var result = [];
    var chats = JSON.parse(text);
    for (var key in chats ) {
      if (
        chats[key].from == main_username &&
        chats[key].to == friend_username
      ) {
        result.push({ role: "main", msg: chats[key].msg });
      } else if (
        chats[key].from == friend_username &&
        chats[key].to == main_username
      ) {
        result.push({ role: "friend", msg: chats[key].msg });
      }
    }
    // console.log("inside read file");
    res.send(result);
  });
  // console.log("Outside read file");
});

app.post("/recentChat", (req, res) => {
  var { main_username } = req.body;

  fs.readFile("message.json", "utf8", function (err, text) {
    var result = [];
    var chats = JSON.parse(text); // {key: value} chats[key]
    var length = Object.keys(chats).length;
    for (var key = length; key >= 1; key--) {
      key = key.toString();

      // Not chat of main_username
      if (
        chats[key]["to"] != main_username &&
        chats[key]["from"] != main_username
      ) {
        continue;
      }

      // Logic for chat of main_username
      let friend_username;
      let exist = false;

      if (chats[key]["to"] == main_username) {
        friend_username = chats[key]["from"];
      } else {
        friend_username = chats[key]["to"];
      }

      for (let i = 0; i < result.length; i++) {
        if (
          result[i]["from"] == friend_username ||
          result[i]["to"] == friend_username
        ) {
          exist = true;
          break;
        }
      }

      if (!exist) {
        result.push({
          from: chats[key]["from"],
          to: chats[key]["to"],
          msg: chats[key]["msg"],
        });
      }
    }
    res.send(result);
  });
});

app.listen(port, () => {
  console.log(`Example app listening on port ${port}`);
});
