import 'package:freezed_annotation/freezed_annotation.dart';
import './message.dart';

part 'offlineClients.freezed.dart';
part 'offlineClients.g.dart';

@freezed
class OffLineClient with _$OffLineClient {
  const factory OffLineClient({
    required String clientId,
    required List<Messages> messages,
  }) = _OffLineClient;

  factory OffLineClient.fromJson(json) => _$OffLineClientFromJson(json);
}

@freezed
class OffLineClients with _$OffLineClients {
  const factory OffLineClients({
    required List<OffLineClient> clients,
    required int totalClients,
  }) = _OffLineClients;

  factory OffLineClients.fromJson(json) => _$OffLineClientsFromJson(json);

  addClient(String clientId) {
    clients.add(OffLineClient(clientId: clientId, messages: []));
  }

  removeClient(String clientId) {
    OffLineClient client =
        clients.where((client) => client.clientId == clientId).first;
    clients.remove(client);
  }
  
}
