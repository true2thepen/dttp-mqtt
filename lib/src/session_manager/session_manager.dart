import 'dart:io';

import '../models/session.dart';

/// Session manager
class SessionManager {
  static final SessionManager _instance = SessionManager._();
  final Set<Session> sessions = {};

  SessionManager._();

  static SessionManager get instance => _instance;

  bool containsClientId(String clientId) {
    return sessions.any((other) => other.clientId == clientId);
  }

  bool containsClient(Session client) {
    return containsClientId(client.clientId);
  }

  bool containsSocket(Socket socket) {
    return sessions.any((other) => other.socket == socket);
  }

  Session getClient(Socket socket) {
    return sessions.firstWhere((other) => other.socket == socket);
  }
}
/*
class Session {
  void refresh() {}
}
*/