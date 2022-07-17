import 'dart:io';
import 'client.dart';

class Session {
  final String clientId;
  final Socket socket;
  final Client client;

  Session({
    required this.clientId,
    required this.socket,
    required this.client
  });
}
