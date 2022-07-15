import 'dart:io';

/// Should protocol version be added
/// How else will we know which version
/// client is using?
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
