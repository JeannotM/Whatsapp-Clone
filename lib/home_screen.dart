import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:whatsapp_clone/components/chat_container.dart';
import 'package:whatsapp_clone/components/message_screen.dart';

class HomeScreen extends StatelessWidget {
  final MessageNotifier messageNotifier;
  final WebSocketChannel channel;
  final LocalStorage storage;
  const HomeScreen(this.channel, this.storage, this.messageNotifier, {super.key});

  @override
  Widget build(BuildContext context) {
    messageNotifier.registerChat(0);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[600],
        title: const Text(
          "Whatsapp Clone",
          style: TextStyle(
            fontSize: 22,
        ),),
        actions: [
          IconButton(
            onPressed: () { Navigator.pushNamed(context, "/settings"); },
            icon: const Icon(Icons.settings)
          ),
        ],
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 50,
            child: ListenableBuilder(
                listenable: messageNotifier,
                builder: (BuildContext context, Widget? child) {
                  final List<int> values = List.of(messageNotifier.chats.keys);
                  return ListView.builder(
                    itemBuilder: (BuildContext context, int index) => ChatContainer(values[index],
                          messageNotifier.getName(values[index]) ?? "Unknown",
                          messageNotifier.getLastMessage(values[index]) ?? ""),
                    itemCount: values.length,
                    shrinkWrap: true,
                  );
              }
            ),
          ),

          ElevatedButton(onPressed: () { Navigator.pushNamed(context, "/chat", arguments: 0); }, child: const Text("group"),),
          ElevatedButton(onPressed: () { Navigator.pushNamed(context, "/chat", arguments: 1); }, child: const Text("chat"),),
          ElevatedButton(onPressed: () { channel.sink.add("messageSent"); }, child: const Text("msg"),),
        ],
      ),
    );
  }
}