import 'package:freezed_annotation/freezed_annotation.dart';

part 'client.freezed.dart';
part 'client.g.dart';

@freezed
class Client with _$Client {
  const factory Client({
    required String clientId,
    required String protocol,
    required String id,
    //required Map<String, dynamic> abilities,
  }) = _Client;

  factory Client.fromJson(json) => _$ClientFromJson(json);
}

@freezed
class Clients with _$Clients {
  const factory Clients({
    required List clients,
    required int totalClients,
  }) = _Clients;

  factory Clients.fromJson(json) => _$ClientsFromJson(json);
}
