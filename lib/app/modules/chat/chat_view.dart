import 'package:chat/app/models/socked_events.dart';
import 'package:chat/app/modules/chat/chat_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatPage extends GetView<ChatController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ChatPage')),
      body: Column(
        children: [
          Expanded(
            child: Obx(
              () => ListView.builder(
                itemCount: controller.messages.length,
                itemBuilder: (context, index) {
                  var message = controller.messages[index];
                  switch (message.type) {
                    case SocketEvent.login:
                      return Text("${message.username} вошёл в чат");
                    case SocketEvent.newMessage:
                      return Text("${message.username} ${message.message}");
                    case SocketEvent.logout:
                      return Text("${message.username} вышел из чата");
                    default:
                      return const SizedBox();
                  }
                },
              ),
            ),
          ),
          const SizedBox(),
          TextFormField(
            controller: controller.textCtrl,
            onFieldSubmitted: (value) => controller.sendMessage(),
            decoration: const InputDecoration(
              suffixIcon: Icon(Icons.send),
              border: OutlineInputBorder(),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              controller.disconnect();
            },
            child: const Text('Выйти'),
          ),
        ],
      ),
    );
  }
}