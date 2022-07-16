import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import '../message/message_enums.dart';
import '../message/message.dart';

class PingreqMessageDecoder extends MessageDecoder {
  final pingresp = PingrespMessage();

  @override
  Future<PingrespMessage> decode(Uint8List uint8list, Socket socket) async {
    socket.add(pingresp.toByte());
    return pingresp;
  }
}

class PingrespMessage extends Message with RequestMessage {
  PingrespMessage() : super(type: MessageType.pingresp);

  @override
  Uint8List toByte() {
    return Uint8List.fromList([type.fixedHeader(), 0]);
  }
}
