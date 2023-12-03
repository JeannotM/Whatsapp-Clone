import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class KeyBoardScreen extends StatelessWidget {
  final messageInput = TextEditingController();
  final void Function(String data) messageSend;
  KeyBoardScreen(this.messageSend, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: messageInput,
              maxLength: 255,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Message..."
              ),
            ),
          ),
          SizedBox(
            width: 40,
            height: 40,
            child: IconButton(
                onPressed: () {
                  messageSend(messageInput.text);
                  messageInput.text = "";
                },
                icon: const Icon(CupertinoIcons.arrow_right),
            ),
          ),
        ],
      ),
    );
  }
}