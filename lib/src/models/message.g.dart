// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Message _$$_MessageFromJson(Map<String, dynamic> json) => _$_Message(
      topic: json['topic'] as String,
      messages: json['messages'] as String,
    );

Map<String, dynamic> _$$_MessageToJson(_$_Message instance) =>
    <String, dynamic>{
      'topic': instance.topic,
      'messages': instance.messages,
    };

_$_Messages _$$_MessagesFromJson(Map<String, dynamic> json) => _$_Messages(
      messages: json['messages'] as List<dynamic>,
      totalMessages: json['totalMessages'] as int,
    );

Map<String, dynamic> _$$_MessagesToJson(_$_Messages instance) =>
    <String, dynamic>{
      'messages': instance.messages,
      'totalMessages': instance.totalMessages,
    };
