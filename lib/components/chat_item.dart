import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:whatsapp_clone/models/user.dart';

class ChatItem extends StatelessWidget {
  final String time = DateFormat("kk:mm").format(DateTime.now());
  final String message;
  final User user;

  ChatItem(this.user, this.message, {super.key});

  @override
  Widget build(BuildContext context) {
    double itemSize = MediaQuery.of(context).size.width * 0.65;
    bool isMe = user.code == -1;

    return Align(
      alignment: isMe ? Alignment.topRight : Alignment.topLeft,
      child: Container(
        padding: const EdgeInsets.all(4),
        width: itemSize,
        child: Row(
          children: [
            if(!isMe)
            ...[
                Padding(
                  padding: const EdgeInsets.all(4),
                  child: CircleAvatar(backgroundImage: MemoryImage(user.image), radius: 15,)
                ),
            ],
            Expanded(
              child: Container(
                color: Colors.grey[200],
                child: Column(
                  children: <Widget>[
                    Container(
                      width: itemSize,
                      padding: const EdgeInsets.fromLTRB(4, 4, 4, 0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Expanded(child: Text(user.name,
                            textAlign: TextAlign.left,
                            style: const TextStyle( fontWeight: FontWeight.w700, ),
                          ),),
                          Text(time, textAlign: TextAlign.right, ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(4, 0, 4, 4),
                      width: itemSize,
                      child: Text(message, textAlign: TextAlign.left, ),
                    )
                  ],
                ),
              ),
            ),
            if(isMe)
              ...[
                Padding(
                    padding: const EdgeInsets.all(4),
                    child: CircleAvatar(backgroundImage: MemoryImage(user.image), radius: 15,)
                ),
              ],
          ],
        ),
      ),
    );
  }
}