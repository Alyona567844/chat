import 'package:chat/app/models/chat_message/chat_message.dart';
import 'package:chat/app/models/socked_events.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BubbleMessage extends StatelessWidget {
  const BubbleMessage({super.key, required this.message, required this.itsMe});

  final ChatMessage message;
  final bool itsMe;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: itsMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color:
                itsMe ? const Color.fromARGB(186, 255, 255, 255) : Colors.blue,
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!itsMe) Text(message.username),
            (() {
              if (message.type == SocketEvents.newImageMessage) {
                return Image.memory(
                  message.image,
                  height: 200,
                  width: 200,
                  fit: BoxFit.contain,
                );
              }
              return Text(message.message);
            })(),
            Text(message.time, style: const TextStyle(fontSize: 10)),
          ],
        ),
      ),
    );
  }
}
