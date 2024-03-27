import 'package:chat/app/models/socked_events.dart';
import 'package:chat/app/modules/chat/chat_controller.dart';
import 'package:chat/app/modules/chat/widgets/bubble_message.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatPage extends GetView<ChatController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Чатик👩‍❤️‍💋‍👨'),
        leading: IconButton(
            onPressed: () {
              controller.disconnect();
            },
            icon: const Icon(Icons.arrow_back)),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage('assets/images/night_city2.png')),
        ),
        child: Column(
          children: [
            Expanded(
              child: Obx(
                () => ListView.builder(
                  controller: controller.scrollCtrl,
                  itemCount: controller.messages.length,
                  itemBuilder: (context, index) {
                    var message = controller.messages[index];
                    var itsMe = controller.itsMe(message.clientId);
                    switch (message.type) {
                      case SocketEvent.login:
                        return Center(
                            child: Text(
                          "${message.username} присоединился(ась) к чату",
                          style: const TextStyle(fontSize: 13.0, color: Color.fromARGB(186, 255, 255, 255)),
                        ));
                      case SocketEvent.newMessage:
                        // return Text("${message.username} ${message.message}");
                        return BubbleMessage(message: message, itsMe: itsMe);
                      case SocketEvent.logout:
                        return Center(
                            child: Text("${message.username} покинул(а) чат",
                            style: const TextStyle(fontSize: 13.0, color: Color.fromARGB(186, 255, 255, 255)),
                          ));
                      default:
                        return const SizedBox();
                    }
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30, bottom: 20),
              child: TextFormField(
                focusNode: controller.focusNode,
                cursorColor: const Color.fromARGB(186, 255, 255, 255),
                style: const TextStyle(color: Color.fromARGB(186, 255, 255, 255)),
                controller: controller.textCtrl,
                onFieldSubmitted: (value) {
                  controller.sendMessage();
                },
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                      onPressed: () {
                        controller.sendMessage();
                      },
                      icon: const Icon(Icons.send)),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20.0),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: const BorderSide(
                      color: Color.fromARGB(186, 255, 255, 255),
                    )
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
