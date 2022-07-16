import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dttp_mqtt/src/client.dart';
import 'package:dttp_mqtt/src/message/message.dart';
import 'package:dttp_mqtt/src/message/message_enums.dart';
import 'package:dttp_mqtt/src/session_manager/session_manager.dart';
import 'package:dttp_mqtt/src/utils/utils.dart';

/// Subscribe message
class SubscribeMessage extends Message with ResponseMessage {
  SubscribeMessage() : super(type: MessageType.subscribe);
}


/// Subscription acknowledgement message
class SubackMessage extends Message with RequestMessage {
  final List<int> qoss;
  final int packetIdentifier;

  SubackMessage({required this.qoss, required this.packetIdentifier})
      : super(type: MessageType.suback);

  @override
  Uint8List toByte() {
    final variableHeader =
        Uint16List.fromList([packetIdentifier]).buffer.asUint8List();
    final payload = Uint8List.fromList(qoss);
    final bytes = Uint8List.fromList([
      type.fixedHeader(),
      variableHeader.lengthInBytes + payload.lengthInBytes,
      ...variableHeader.reversed,
      ...payload,
    ]);
    return bytes;
  }
}

/// Unsubscribe acknowledgement message
class UnsubackMessage extends Message with RequestMessage {
  final int packetIdentifier;

  UnsubackMessage({required this.packetIdentifier})
      : super(type: MessageType.unsuback);

  @override
  Uint8List toByte() {
    final variableHeader =
        Uint16List.fromList([packetIdentifier]).buffer.asUint8List();
    return Uint8List.fromList(
        [type.fixedHeader(), variableHeader.lengthInBytes, ...variableHeader]);
  }
}

/// Subscription
class Subscription {
  final int qos;
  final String topic;

  Subscription({required this.qos, required this.topic});
}


/// Subscription Manager
class SubscriptionManager {
  final Map<Client, Set<Subscription>> subscriptions = {};

  static final _instance = SubscriptionManager._();

  static SubscriptionManager get instance => _instance;

  SubscriptionManager._();

  void add(Client client, Subscription subscription) {
    if (!subscriptions.containsKey(client)) {
      subscriptions[client] = {};
    }
    subscriptions[client]!.add(subscription);
    print('Setting subscription - ' +
        subscription.topic +
        ' for client: ' +
        client.clientId);
  }

  void addAll(Client client, List<Subscription> subscriptions) {
    for (var subscription in subscriptions) {
      add(client, subscription);
    }
  }
}

/// Subscription message decoder
/// 
/// TODO: Handle wildcard subcriptions
class SubscribeMessageDecoder implements MessageDecoder {
  @override
  Future<SubackMessage> decode(Uint8List uint8list, Socket socket) async {
    final buffer = uint8list.buffer;
    //
    String clientProtocol = SessionManager.instance.getClient(socket).protocol;
    int currentIndex = 0;
//    print(uint8list.asMap());
//    print(uint8list.toString());
    var mqttControlByte =
        uint8list.buffer.asByteData(currentIndex, 1).getUint8(0);
    if (mqttControlByte != 130) {
      // Control byte is not a subscribe, bail
      print('Bad control byte of ' + mqttControlByte.toString());
    }

    currentIndex++;
    var decodedVariableByteHeader = decodeVariableByte(uint8list, currentIndex);
    currentIndex = decodedVariableByteHeader['index']!;
    var headerLength = decodedVariableByteHeader['decodedVariableByte'];
    final packetIdentifier = buffer.asByteData(currentIndex, 2).getUint16(0);
    currentIndex++;
    /// TODO: Figure why the extra byte before payload in protocol 5
    if (clientProtocol == 'mqtt_5') {
      currentIndex++;
    }

    final List<String> topics = [];
    final List<Subscription> subscriptions = [];

    /// payload
    while (currentIndex < buffer.lengthInBytes - 1) {
      currentIndex++;
      int payloadLength = buffer.asByteData(currentIndex, 2).getUint16(0);
      currentIndex += 2;
      final topic =
          utf8.decode(buffer.asUint8List(currentIndex, payloadLength));
      topics.add(topic);
      currentIndex += payloadLength;
      final qos = buffer.asByteData(currentIndex, 1).getUint8(0);
      subscriptions.add(Subscription(qos: qos, topic: topic));
    }

    SubscriptionManager.instance
        .addAll(SessionManager.instance.getClient(socket), subscriptions);
    final suback = SubackMessage(
        qoss: subscriptions.map((e) => e.qos).toList(),
        packetIdentifier: packetIdentifier);
    socket.add(suback.toByte());
    return suback;
  }
}


/// Unsubscribe message decoder
class UnsubscribeMessageDecoder implements MessageDecoder {
  @override
  Future<UnsubackMessage> decode(Uint8List uint8list, Socket socket) async {
    final buffer = uint8list.buffer;

    int currentIndex = 2;

    final packetIdentifier = buffer.asByteData(currentIndex, 2).getUint16(0);
    final List<String> topics = [];

    currentIndex++;

    /// decode topics
    try {
      while (currentIndex < buffer.lengthInBytes - 1) {
        currentIndex++;
        int payloadLength = buffer.asByteData(currentIndex, 2).getUint16(0);
        currentIndex += 2;
        final topic =
            utf8.decode(buffer.asUint8List(currentIndex, payloadLength));
        topics.add(topic);
        currentIndex += payloadLength;
      }
    } on Exception {
      SessionManager.instance.sessions
          .removeWhere((client) => client.socket == socket);
      SubscriptionManager.instance.subscriptions
          .removeWhere((key, value) => key.socket == socket);
      socket.close();
    }

    var client = SessionManager.instance.getClient(socket);
    SubscriptionManager.instance.subscriptions[client]
        ?.removeWhere((subscription) => topics.contains(subscription.topic));
    var unsubackMessage = UnsubackMessage(packetIdentifier: packetIdentifier);
    socket.add(unsubackMessage.toByte());
    return unsubackMessage;
  }
}

