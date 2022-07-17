import '../models/client.dart';
/// Client Manager
///
/// Manages Clients and their associated data.
/// Calls Session Manager or Subscription Manager
/// when required.

class ClientManager {
  static final ClientManager _instance = ClientManager._();
  final Set<Client> clients = {};

  ClientManager._();

  static ClientManager get instance => _instance;

  bool containsClientId(String clientId) {
    return clients.any((other) => other.clientId == clientId);
  }

  bool containsClient(Client client) {
    return containsClientId(client.clientId);
  }

  Client getClient(String clientId) {
    return clients.firstWhere((other) => other.clientId == clientId);
  }
}