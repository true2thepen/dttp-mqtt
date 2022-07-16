import 'dart:io';
import 'dart:typed_data';

import 'message_enums.dart';

import '../connections/connect.dart';
import '../publish/publish.dart';
import '../ping/ping.dart';
import '../subscriptions/subscription.dart';

class MessageDelegator {
  final publishDecoder = PublishMessageDecoder();
  final connectDecoder = ConnectMessageDecoder();
  final subscribeDecoder= SubscribeMessageDecoder();
  final unsubDecoder = UnsubscribeMessageDecoder();
  final pingreqDecoder = PingreqMessageDecoder();
  final disconnectDecoder = DisconnectMessageDecoder2();

  //TODO handle wrong protocols, versions, and more...
  Future<void> delegate(Uint8List uint8list, Socket socket) async {
    final type = MessageTypeUtil.valueOf(uint8list[0] >> 4);

    switch (type) {
      case MessageType.publish:
        publishDecoder.decode(uint8list, socket);
        break;
      case MessageType.connect:
        var connack = await connectDecoder.decode(uint8list, socket);
        socket.add(connack.toByte());
        break;
      case MessageType.puback:
        // TODO: Handle this case.
        // This is only for qoS Level 1

        break;
      case MessageType.pubrec:
        // TODO: Handle this case.
        // Clients do not send this


        break;
      case MessageType.pubrel:
        // TODO: Handle this case.
        // Sent by clients only

        break;
      case MessageType.pubcomp:
        // TODO: Handle this case.
        // Last in series for publishing
        // qoS Level 2 messages

        break;
      case MessageType.subscribe:
        subscribeDecoder.decode(uint8list, socket);
        break;

      case MessageType.unsubscribe:
        unsubDecoder.decode(uint8list, socket);
        break;

      case MessageType.pingreq:
        pingreqDecoder.decode(uint8list, socket);
        break;

      case MessageType.disconnect:
        disconnectDecoder.decode(uint8list, socket);
        break;
      case MessageType.auth:
        // TODO: Handle this case.
        break;

      case MessageType.reserved:
        // TODO: Handle this case.
        // This should be a disconnect

        break;

      case MessageType.connack:
        // TODO: Handle this case.
        // Clients do not send this

        break;
      case MessageType.suback:
        // TODO: Handle this case.
        // Clients do not send this

        break;
      case MessageType.unsuback:
        // TODO: Handle this case.
        // Clients do not send this

        break;
      case MessageType.pingresp:
        // TODO: Handle this case.

        break;
    }
  }
}
