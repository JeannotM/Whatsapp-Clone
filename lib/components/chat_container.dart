import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_clone/components/message_screen.dart';

class ChatContainer extends StatelessWidget {
  const ChatContainer(this.id, this.name, this.text, {super.key});
  final String text;
  final String name;
  final int id;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () { Navigator.pushNamed(context, "/chat", arguments: id); },
      child: Row(
        children: [
          Column(
            children: [
              Text(id == 0 ? "Group" : name),
              if(text == "")
                ...[
                  const Text("No messages")
                ]
              else
                ...[
                  Text(id == 0 ? "$name: ${text.substring(0, min(20, text.length))}" : text.substring(0, min(20, text.length)))
                ],
              ],
            )
          ],
        ),
      );
  }
}
