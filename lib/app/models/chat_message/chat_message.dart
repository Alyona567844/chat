import 'dart:convert';
import 'dart:typed_data';

import 'package:chat/app/models/socked_events.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intl/intl.dart';

part 'chat_message.freezed.dart';
part 'chat_message.g.dart';

@freezed
class ChatMessage with _$ChatMessage {
  ChatMessage._();

  factory ChatMessage({
    @Default("0") String clientId,
    required String username,
    required int date,
    @Default("") String message,
    @Default(SocketEvents.unknown) SocketEvents type,
  }) = _ChatMessage;

  String get time {
    DateTime date = DateTime.fromMillisecondsSinceEpoch(this.date, isUtc: true);
    DateTime today = DateTime.now();
    String format = 'kk:mm';
    if(date.day != today.day) {
      format = "dd.MM $format";
    }
    return DateFormat(format).format(date);
  }

  Uint8List get image {
    if( type == SocketEvents.newImageMessage) {
      final source = base64Decode(message);
      return source;
    }
    return Uint8List.fromList([]);
  }

  factory ChatMessage.fromJson(Map<String, dynamic> json) => _$ChatMessageFromJson(json);
}