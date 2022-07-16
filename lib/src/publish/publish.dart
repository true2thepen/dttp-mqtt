import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import '../message/message.dart';
import '../message/message_enums.dart';

import '../utils/utils.dart';

import '../subscriptions/subscription.dart';


class PublishMessage extends Message with ResponseMessage, RequestMessage {
  final int qos;
  int duplicateFlag = 0;
  final int retain;
  final String topic;
  final int packetIdentifier;
  final Uint8List payload;

  PublishMessage({
    required this.qos,
    this.retain = 0,
    required this.topic,
    required this.packetIdentifier,
    required this.payload,
  }) : super(type: MessageType.publish);

  @override
  Uint8List toByte() {
    int qosShift = qos == 2
        ? 4
        : (qos == 1)
            ? 2
            : 0;
    // print('qosShift is ' + qosShift.toString());
    int shift = duplicateFlag * 8 + qosShift + retain;

    final topicBytes = utf8.encode(topic);

    final variableHeader = Uint8List.fromList([
      ...Uint16List.fromList([topicBytes.length]).buffer.asUint8List().reversed,
      ...topicBytes
    ]);
    //Added support packet identifier
    var byte1 = packetIdentifier & 0xff;
    var byte2 = (packetIdentifier >> 8) & 0xff;

    final bytes = Uint8List.fromList([
      type.fixedHeader(shift),
      variableHeader.lengthInBytes +
          payload.lengthInBytes +
          2, // 2 for the packet identifier
      ...variableHeader,
      byte2,
      byte1,
      ...payload
    ]);
    // print('Bytes follow:');
    // print(bytes);
    return bytes;
  }
}


class PublishMessageDecoder implements MessageDecoder {
  @override
  Future<Message> decode(Uint8List uint8list, Socket socket) async {
    int currentIndex = 0;
//    print(uint8list.asMap());
//    print(uint8list.toString());
    var mqttControlByte =
        uint8list.buffer.asByteData(currentIndex, 1).getUint8(0);
    var qoS = (mqttControlByte.isBitSet(1) ? 1 : 0) +
        (mqttControlByte.isBitSet(2) ? 1 : 0) * 2;
//    print('qoS: ' + qoS.toString());
    currentIndex++;
    var decodedVariableByteHeader = decodeVariableByte(uint8list, currentIndex);
    currentIndex = decodedVariableByteHeader['index']!;
    var headerLength = decodedVariableByteHeader['decodedVariableByte'];
//    print('Current Index from encoding: ' + currentIndex.toString());
//    print('Header Length from encoding: ' + headerLength.toString());
    // TODO: Use headerLength properly
    int topicLength = uint8list.buffer.asByteData(currentIndex, 2).getUint16(0);
//    print('Topic Length: ' + topicLength.toString());
    currentIndex += 2;
    String topic =
        utf8.decode(uint8list.buffer.asUint8List(currentIndex, topicLength));
    currentIndex += topicLength;
    /**/
    var packetIdentifier =
        uint8list.buffer.asByteData(currentIndex, 2).getUint16(0);
//    print('Packet Identifier: ' + packetIdentifier.toString());
    currentIndex += 2;
    var recPayload = uint8list.buffer.asUint8List(currentIndex);
    print('Publishing - ' +
        utf8.decode(recPayload).toString() +
        ' to topic: ' +
        topic);

    var pub = PublishMessage(
        qos: qoS,
        topic: topic,
        packetIdentifier: packetIdentifier,
        payload: recPayload); //uint8list.buffer.asUint8List(currentIndex));
//    print('pub is ' + pub.payload.toString());

    for (var entry in SubscriptionManager.instance.subscriptions.entries) {
      print('Publishing to subscriber ' + entry.key.clientId);
      print('Topic: ' + topic);
      print(entry.value.map((e) => e.topic));
      // TODO: Fix for wildcard subscriptions
      if (entry.value.map((e) => e.topic).contains(topic)) {
        print('publishing');
        entry.key.socket.add(pub.toByte());
      } else {
        print('Why are we not publishing?');
      }
    }
    // Level 1 send PUBACK to PUBLISHER
    if (qoS == 1) {
      print('Send PUBACK');

    }
    // Level 2 send PUBREC to PUBLISHER
    if (qoS == 2) {
      print('Send PUBREC');

    }
    return pub;
  }
}

