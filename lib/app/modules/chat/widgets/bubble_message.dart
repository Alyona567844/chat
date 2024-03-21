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
        child: Column(
          crossAxisAlignment: itsMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            if(!itsMe)
            Text(message.username),
            Text(message.message),
          ],
        ),
      ),
    );
  }
}