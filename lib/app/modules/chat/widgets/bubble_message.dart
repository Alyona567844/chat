import 'package:chat/app/models/chat_message/chat_message.dart';
import 'package:flutter/material.dart';

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
          color: itsMe? const Color.fromARGB(186, 255, 255, 255) : Colors.blue,
          borderRadius: BorderRadius.circular(10)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if(!itsMe)
            Text(message.username),
            Text(message.message),
          ],
        )
      ),
    );
  }
}