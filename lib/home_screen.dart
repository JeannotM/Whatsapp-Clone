import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen(LocalStorage storage, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[600],
        title: const Text(
            "Whatsapp Clone",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            )),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          "Testing Things Out",
          style: TextStyle(
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}