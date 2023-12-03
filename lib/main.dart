import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:whatsapp_clone/chat_screen.dart';
import 'package:whatsapp_clone/components/message_screen.dart';
import 'package:whatsapp_clone/home_screen.dart';
import 'package:whatsapp_clone/settings_screen.dart';

import 'models/user.dart';

void main() {
  final LocalStorage storage = LocalStorage("secure_key.json");
  final channel = WebSocketChannel.connect( Uri.parse('ws://10.0.2.2:8080'), );
  final MessageNotifier messageNotifier = MessageNotifier();

  if(storage.getItem("userName") == null) {
    storage.setItem("userName", "Default");
  }

  if(storage.getItem("userImage") == null) {
    storage.setItem("userImage", Uint8List(0));
  }

  final userData = {
    "emit": "userRegister",
    "image": storage.getItem("userImage"),
    "name": storage.getItem("userName"),
  };

  channel.stream.listen(
    (data) {
      final parsed = json.decode(data);
      print(parsed);
      if(parsed['isFirstTime'] == 1) {
        messageNotifier.myId = parsed['userId'] as int;
      } else if (parsed['emit'] == "userRegister") {
        List<dynamic> dynamicList = parsed['image'] as List<dynamic>;
        List<int> intList = dynamicList.cast<int>().toList(); //This is the magical line.
        Uint8List uint8list = Uint8List.fromList(intList);

        messageNotifier.registerUser(User(parsed['userId'] as int,
            parsed['name'] as String, uint8list));
      }
    },
    onError: (error) => print(error),
  );

  channel.sink.add(json.encode(userData));

  runApp(MaterialApp(
    initialRoute: "/",
    routes: {
      "/": (context) => HomeScreen(channel, storage, messageNotifier),
      "/chat": (context) => ChatScreen(channel, storage, messageNotifier),
      "/settings": (context) => SettingsScreen(channel, storage),
    },
  ));
}

