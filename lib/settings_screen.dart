import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen(LocalStorage storage, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings")
      ),
    );
  }
}