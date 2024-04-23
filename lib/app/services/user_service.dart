import 'package:chat/app/models/chat_message/chat_message.dart';
import 'package:chat/app/models/socked_events.dart';
import 'package:chat/app/services/socket_service.dart';
import 'package:get/get.dart';

class UserService extends GetxService {
  static UserService get to => Get.find();

  String username = "";
  final messages = RxList<ChatMessage>.empty();
  final typingUsers = RxSet<String>();

  void setUsernameAndConnect(String user) {
    username = user;
    SocketService.to.connect();
  }

  // довавить сообщение [ChatMessage] в историю
  void addMessageToList(ChatMessage message) async {
    switch (message.type) {
      case SocketEvents.typingStart:
        typingUsers.add(message.username);
        return;
      case SocketEvents.typingStop:
        typingUsers.removeWhere((element) => element == message.username);
        return;
      default:
    }
    messages.add(message);
  }

  void sendMessage(String message) =>
      SocketService.to.sendMessageToChat(message);
  void sendImageMessage(String file) => SocketService.to.sendImageMessage(file);

  void typingStart() => SocketService.to.sendTypingStart();
  void typindStop() => SocketService.to.sendTypingStop();

  void clearMessage() {
    messages.clear();
  }
}
