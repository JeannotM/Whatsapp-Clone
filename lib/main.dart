import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:whatsapp_clone/chat_screen.dart';
import 'package:whatsapp_clone/home_screen.dart';
import 'package:whatsapp_clone/settings_screen.dart';

void main() {
  final LocalStorage storage = LocalStorage("secure_key.json");
  
  runApp(MaterialApp(
    initialRoute: "/",
    routes: {
      "/": (context) => HomeScreen(storage),
      "/chat": (context) => ChatScreen(storage),
      "/settings": (context) => SettingsScreen(storage),
    },
  ));
}

