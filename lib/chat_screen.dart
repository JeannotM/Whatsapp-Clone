import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:whatsapp_clone/components/keyboard_screen.dart';
import 'package:whatsapp_clone/components/message_screen.dart';
import 'package:whatsapp_clone/models/user.dart';

class ChatScreen extends StatelessWidget {
  final MessageNotifier messageNotifier;
  final WebSocketChannel channel;
  final LocalStorage storage;
  late int id;
  ChatScreen(this.channel, this.storage, this.messageNotifier, {super.key});

  void messageSend(String input) {
    messageNotifier.addMessage(id, messageNotifier.getMyself(), input);
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments;
    if(args != null) {
      id = args as int;
      messageNotifier.registerChat(id);
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[600],
        title: const Text(
            "Chat",
            style: TextStyle(
              fontSize: 22,
            ),),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: MessageScreen(id, messageNotifier),
          ),
          KeyBoardScreen(messageSend),
        ],
      )
    );
  }
}



