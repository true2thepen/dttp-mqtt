// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'offlineClients.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_OffLineClient _$$_OffLineClientFromJson(Map<String, dynamic> json) =>
    _$_OffLineClient(
      clientId: json['clientId'] as String,
      messages: (json['messages'] as List<dynamic>)
          .map((e) => Messages.fromJson(e))
          .toList(),
    );

Map<String, dynamic> _$$_OffLineClientToJson(_$_OffLineClient instance) =>
    <String, dynamic>{
      'clientId': instance.clientId,
      'messages': instance.messages,
    };

_$_OffLineClients _$$_OffLineClientsFromJson(Map<String, dynamic> json) =>
    _$_OffLineClients(
      clients: (json['clients'] as List<dynamic>)
          .map((e) => OffLineClient.fromJson(e))
          .toList(),
      totalClients: json['totalClients'] as int,
    );

Map<String, dynamic> _$$_OffLineClientsToJson(_$_OffLineClients instance) =>
    <String, dynamic>{
      'clients': instance.clients,
      'totalClients': instance.totalClients,
    };
