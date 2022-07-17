import 'dart:io';

/// Client model
/// 
class Client {
  final String clientId;
  final Socket socket;
  final String protocol;

  Client({
    required this.clientId,
    required this.socket,
    required this.protocol
  });
}
