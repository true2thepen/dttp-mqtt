import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'message_enums.dart';

/// Base Message class
/// 
abstract class Message {
  final MessageType type;
  int fixedHeaderFlags = 0; // value between 0 and 15

  Message({
    required this.type,
  });
}

/// Base model for outgoing message types
/// 
/// i.e. CONNACK, SUBACK, PUBACK...
mixin RequestMessage {
  Uint8List toByte();
}

/// Base model for incoming message types
/// 
/// i.e. CONNECT, SUBSCRIBE, PUBLISH...
mixin ResponseMessage {}

abstract class MessageDecoder {
  Future<Message> decode(Uint8List uint8list, Socket socket);
}
