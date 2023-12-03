import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:whatsapp_clone/components/changeable_circle_avatar.dart';

class SettingsScreen extends StatelessWidget {
  static const List<String> themes = <String>['Light', 'Dark'];

  final WebSocketChannel channel;
  final LocalStorage storage;
  const SettingsScreen(this.channel, this.storage, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings")
      ),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 150,
            child: InkWell(
              onTap: () {
                print("yes");
              },
              child: Container(
                alignment: Alignment.bottomLeft,
                color: Colors.red[400],
                child: const Padding(
                  padding: EdgeInsets.all(4),
                  child: Text("Click to change banner",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: 14
                    ),
                  ),
                )
              )
            )
          ),
          Positioned(
            top: 25,
            left: 0,
            right: 0,
            height: 100,
            child: ChangeableCircleAvatar(storage),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 170, 20, 20),
            child: Column(
              children: [
                TextFormField(
                  initialValue: storage.getItem("userName"),
                  maxLength: 20,
                  keyboardType: TextInputType.name,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Enter your username",
                    labelText: "Username"
                  ),
                  onChanged: (newName) async { storage.setItem("userName", newName); },
                ),
                DropdownButton(value: themes.last,
                  underline: const SizedBox(),
                  items: themes.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                  }).toList(),
                  onChanged: (string) { print(string); }
                ),
              ],
            )
          ),
        ],
      )
    );
  }
}