import 'dart:convert';

import 'package:chat/app/models/socked_events.dart';
import 'package:chat/app/modules/chat/chat_controller.dart';
import 'package:chat/app/modules/chat/widgets/bubble_message.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ChatPage extends GetView<ChatController> {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(
          () => Column(
            children: [
              const Text('Чатик👩‍❤️‍💋‍👨'),
              if (controller.typingUsers.isNotEmpty)
                Text(
                  '${controller.typingUsers.join(',')} печатает${controller.stringAnimation.padRight(3)}',
                  style: const TextStyle(fontSize: 10),
                )
            ],
          ),
        ),
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
                      case SocketEvents.login:
                        return Center(
                            child: Text(
                          "${message.username} присоединился(ась) к чату",
                          style: const TextStyle(
                              fontSize: 13.0,
                              color: Color.fromARGB(186, 255, 255, 255)),
                        ));
                      case SocketEvents.newMessage ||
                            SocketEvents.newImageMessage:
                        // return Text("${message.username} ${message.message}");
                        return BubbleMessage(message: message, itsMe: itsMe);
                      case SocketEvents.logout:
                        return Center(
                            child: Text(
                          "${message.username} покинул(а) чат",
                          style: const TextStyle(
                              fontSize: 13.0,
                              color: Color.fromARGB(186, 255, 255, 255)),
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
                onChanged: (value) => controller.typingStart(value),
                onTapOutside: (event) => controller.typingStop(),
                decoration: InputDecoration(
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(30.0),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: const BorderSide(
                      color: Color.fromARGB(186, 255, 255, 255),
                    ),
                  ),
                  suffixIcon: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () async {
                          final ImagePicker picker = ImagePicker();
                          final XFile? image = await picker.pickImage(
                              source: ImageSource.gallery);
                          if (image != null) {
                            var data = base64Encode(await image.readAsBytes());
                            controller.sendImageMessage(data);
                          }
                        },
                        icon: const Icon(Icons.attach_file),
                      ),
                      IconButton(
                        onPressed: () {
                          controller.sendMessage();
                        },
                        icon: const Icon(Icons.send),
                      ),
                    ],
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
