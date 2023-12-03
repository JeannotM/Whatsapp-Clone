import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:localstorage/localstorage.dart';

class ChangeableCircleAvatar extends StatefulWidget {
  final LocalStorage storage;
  const ChangeableCircleAvatar(this.storage, {super.key});

  @override
  State<StatefulWidget> createState() => _ChangeableCircleAvatar(storage);
}

class _ChangeableCircleAvatar extends State<ChangeableCircleAvatar> {
  final LocalStorage storage;
  Uint8List imageBytes = Uint8List(0);

  _ChangeableCircleAvatar(this.storage) {
    String? image = storage.getItem("userImage");
    if(image != null) {
      imageBytes = base64Decode(image);
    }
  }

  @override
  Widget build(BuildContext context) {
      return InkWell(
      onTap: () async {
        final ImagePicker picker = ImagePicker();
        final XFile? image = await picker.pickImage(source: ImageSource.gallery);
        if(image != null) {
          Uint8List bytes = await image.readAsBytes();
          storage.setItem("userImage", base64Encode(bytes));
          setState(() {
            imageBytes = bytes;
          });
        }
      },
      child: CircleAvatar(
        radius: 100,
        child: ClipOval(
          child: Image.memory(
            imageBytes,
            width: 100,
            height: 100,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

}