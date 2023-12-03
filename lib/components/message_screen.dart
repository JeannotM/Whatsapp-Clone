import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_clone/components/chat_item.dart';
import 'package:whatsapp_clone/models/chat.dart';
import 'package:whatsapp_clone/models/user.dart';

class MessageScreen extends StatelessWidget {
  final MessageNotifier messageNotifier;
  final int id;
  const MessageScreen(this.id, this.messageNotifier, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
        listenable: messageNotifier,
        builder: (BuildContext context, Widget? child) {
          final List<ChatItem>? values = messageNotifier.chats[id]?.messages;
          return ListView.builder(
            itemBuilder: (BuildContext context, int index) => values?[index],
            itemCount: values?.length,
            shrinkWrap: true,
          );
        },
    );
  }
}


class MessageNotifier extends ChangeNotifier {
  List<ChatItem> messages = List.empty(growable: true);
  HashMap<int, Chat> chats = HashMap();
  HashMap<int, User> users = HashMap();
  late int myId;

  void registerUser(User user) {
    users[user.code] = user;
    registerChat(user.code);
  }

  void updateUser(User user) {
    users[user.code] = user;
    notifyListeners();
  }

  void unRegisterUser(int code) {
    users.remove(code);
    unRegisterChat(code);
  }

  void registerChat(int code) {
    if(!chats.containsKey(code)) {
      chats[code] = Chat(code);
      notifyListeners();
    }
  }
  
  void unRegisterChat(int code) { 
    chats.remove(code);
    notifyListeners();
  }

  User? getMyself() {
    return users[myId];
  }

  void addMessage(int code, User? user, String message) {
    if(chats.containsKey(code)) {
      chats[code]?.messages.add(ChatItem(user ?? User(-1, "", Uint8List(0)), message));

      if(chats[code]!.messages.length > 20) {
        chats[code]?.messages.removeAt(0);
      }

      notifyListeners();
    }
  }

  void receiveMessage(int code, User user, String message) {
    if(chats.containsKey(code)) {
      chats[code]?.messages.add(ChatItem(user, message));

      if(chats[code]!.messages.length > 20) {
        chats[code]?.messages.removeAt(0);
      }

      notifyListeners();
    }
  }

  String? getLastMessage(int code) {
    if(chats.containsKey(code)) {
      if(chats[code]!.messages.isNotEmpty) {
        return chats[code]!.messages[chats[code]!.messages.length - 1].message;
      }
    }
    return null;
  }

  String? getName(int code) {
    if(chats.containsKey(code)) {
      if(users.containsKey(code)) {
        return users[chats[code]?.id]?.name;
      }
    }
    return null;
  }
}