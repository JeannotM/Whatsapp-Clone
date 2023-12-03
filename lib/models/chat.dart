import 'package:whatsapp_clone/components/chat_item.dart';

class Chat {
  final List<ChatItem> messages = List.empty(growable: true);
  final bool hasUnreadMessages = false;
  final int id;
  Chat(this.id);
}