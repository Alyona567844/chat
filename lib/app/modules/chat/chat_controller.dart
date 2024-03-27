import 'package:chat/app/models/chat_message/chat_message.dart';
import 'package:chat/app/services/socket_service.dart';
import 'package:chat/app/services/user_service.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  RxList<ChatMessage> get messages => UserService.to.messages;

  final textCtrl = TextEditingController();
  final scrollCtrl = ScrollController();
  final focusNode = FocusNode();

  // @override
  // void onInit() {
  //   messages.listen((p0) async {
  //     var max = scrollCtrl.position.maxScrollExtent;
  //     if (scrollCtrl.offset + 100 >= max) {
  //       await Future.delayed(const Duration(microseconds: 300));
  //       scrollCtrl.jumpTo(max);
  //     }
  //   });
  //   super.onInit();
  // }

  @override
  void onInit() {
    messages.listen(
      (p0) async {
        if (scrollCtrl.hasClients) {
          var max = scrollCtrl.position.maxScrollExtent;
          if (scrollCtrl.offset + 100 >= max) {
            await Future.delayed(
              const Duration(milliseconds: 100),
              () {
                scrollCtrl.animateTo(scrollCtrl.position.maxScrollExtent,
                    duration: const Duration(milliseconds: 300),
                    // визуальное восприятие, скорость анимации
                    curve: Curves.easeOut);
              },
            );
          }
        }
      },
    );
    super.onInit();
  }

  void sendMessage() {
    var message = textCtrl.text;
    SocketService.to.sendMessageToChat(message);
    textCtrl.clear();
    focusNode.requestFocus();
  }

  void disconnect() {
    SocketService.to.disconnect();
  }

  bool itsMe(String clientId) => clientId == SocketService.to.clientId;

  @override
  void onClose() {
    scrollCtrl.dispose();
    super.onClose();
  }
}
