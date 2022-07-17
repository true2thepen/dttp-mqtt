// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Client _$$_ClientFromJson(Map<String, dynamic> json) => _$_Client(
      clientId: json['clientId'] as String,
      protocol: json['protocol'] as String,
      id: json['id'] as String,
    );

Map<String, dynamic> _$$_ClientToJson(_$_Client instance) => <String, dynamic>{
      'clientId': instance.clientId,
      'protocol': instance.protocol,
      'id': instance.id,
    };

_$_Clients _$$_ClientsFromJson(Map<String, dynamic> json) => _$_Clients(
      clients: json['clients'] as List<dynamic>,
      totalClients: json['totalClients'] as int,
    );

Map<String, dynamic> _$$_ClientsToJson(_$_Clients instance) =>
    <String, dynamic>{
      'clients': instance.clients,
      'totalClients': instance.totalClients,
    };
