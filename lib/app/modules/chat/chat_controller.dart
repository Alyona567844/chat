import 'package:chat/app/models/chat_message/chat_message.dart';
import 'package:chat/app/services/socket_service.dart';
import 'package:chat/app/services/user_service.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  RxList<ChatMessage> get messages => UserService.to.messages;

  final textCtrl = TextEditingController();
  void clearText() {
    textCtrl.clear();
  }
  
  void textClear() {
    textCtrl.clear();
  }

  @override
  void onInit() {
    super.onInit();
  }

  void sendMessage() {
    var message = textCtrl.text;
    SocketService.to.sendMessageToChat(message);
  }

  void disconnect() {
    SocketService.to.disconnect();
  }
}
