// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ChatMessageImpl _$$ChatMessageImplFromJson(Map<String, dynamic> json) =>
    _$ChatMessageImpl(
      clientId: json['clientId'] as String? ?? "0",
      username: json['username'] as String,
      date: json['date'] as int,
      message: json['message'] as String? ?? "",
      type: $enumDecodeNullable(_$SocketEventsEnumMap, json['type']) ??
          SocketEvents.unknown,
    );

Map<String, dynamic> _$$ChatMessageImplToJson(_$ChatMessageImpl instance) =>
    <String, dynamic>{
      'clientId': instance.clientId,
      'username': instance.username,
      'date': instance.date,
      'message': instance.message,
      'type': _$SocketEventsEnumMap[instance.type]!,
    };

const _$SocketEventsEnumMap = {
  SocketEvents.unknown: 'unknown',
  SocketEvents.login: 'login',
  SocketEvents.logout: 'logout',
  SocketEvents.newMessage: 'newMessage',
  SocketEvents.newImageMessage: 'newImageMessage',
  SocketEvents.typingStart: 'typingStart',
  SocketEvents.typingStop: 'typingStop',
};
