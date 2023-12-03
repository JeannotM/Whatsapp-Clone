import 'package:flutter/foundation.dart';

class User {
  int code;
  String name;
  Uint8List image;

  User(this.code, this.name, this.image);

  update({int? code, String? name, Uint8List? image}) {
    if(code != null) { this.code = code; }
    if(name != null) { this.name = name; }
    if(image != null) { this.image = image; }
  }
}