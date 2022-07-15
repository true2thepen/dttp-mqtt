import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dttp_mqtt/src/client.dart';

import '../session_manager.dart';
import 'message_enums.dart';
import '../utils/utils.dart';

enum ProtocolVersion {
  mqtt_3_1_1,
  mqtt_5,
}

extension ProtocolVersionUtil on ProtocolVersion {
  static const _protocols = ProtocolVersion.values;

  static ProtocolVersion getProtocolVersion(int version) {
    final offset = 4;
    return _protocols[version - offset];
  }
}

abstract class Message {
  final MessageType type;
  int fixedHeaderFlags = 0; // value between 0 and 15

  Message({
    required this.type,
  });
}

/// Base model for outgoing message types, i.e. CONNACK, SUBACK, PUBACK...
mixin RequestMessage {
  Uint8List toByte();
}

/// Base model for incoming message types, i.e. CONNECT, SUBSCRIBE, PUBLISH...
mixin ResponseMessage {}

class ConnectMessage extends Message with ResponseMessage {
  final ProtocolVersion version;

  ConnectMessage({
    this.version = ProtocolVersion.mqtt_3_1_1,
  }) : super(
          type: MessageType.connect,
        );
}

class ConnackMessage extends Message with RequestMessage {
  final bool cleanSession;
  final ConnectReturnCode returnCode;

  ConnackMessage({required this.cleanSession, required this.returnCode})
      : super(type: MessageType.connack);

  @override
  Uint8List toByte() {
    final variableHeader =
        Uint8List.fromList([cleanSession ? 0 : 1, returnCode.index]);
    final bytes = Uint8List.fromList([
      type.fixedHeader(),
      variableHeader.lengthInBytes,
      ...variableHeader,
    ]);
    return bytes;
  }
}

class SubscribeMessage extends Message with ResponseMessage {
  SubscribeMessage() : super(type: MessageType.subscribe);
}

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
      variableHeader.lengthInBytes + payload.lengthInBytes + 2, // 2 for the packet identifier
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

extension Bits on int {
  /// Returns true if bit is 1 else false
  bool isBitSet(final int position) {
    return (this & (1 << position)) != 0;
  }
}

enum ConnectReturnCode {
  connectionAccepted,
  wrongProtocol,
  identifierRejected,
  serverUnavailable,
  badUsernameOrPassword,
  notAuthorized,
}

extension ConnectReturnCodeUtil on ConnectReturnCode {
  static const _connectionReturnCodes = ConnectReturnCode.values;

  static ConnectReturnCode valueOf(int index) {
    if (index > _connectionReturnCodes.length) {
      throw Exception('Invalid message type of index $index');
    }
    return _connectionReturnCodes[index];
  }
}

class ConnectMessageDecoder extends MessageDecoder {
  @override
  Future<ConnackMessage> decode(Uint8List uint8list, Socket socket) async {
//    print(uint8list.asMap());
//    print(uint8list.toString());
//
    int currentIndex = 8;
//
    var protocolVersion =
        ProtocolVersionUtil.getProtocolVersion(uint8list[currentIndex]).name;
//    print('version: ' + protocolVersion);

    currentIndex++;
//
//    print('number of bytes: ' + uint8list.length.toString());
    final bits = uint8list[currentIndex].toRadixString(2);
    //
//    print('connect flag bits: ' + bits);
    final cleanSession = uint8list[currentIndex].isBitSet(1);
    //
//    print('clean session: ' + cleanSession.toString());
    final cleanWill = uint8list[currentIndex].isBitSet(2);
    //
//    print('clean will flag: ' + cleanWill.toString());
    final willQos = (uint8list[currentIndex].isBitSet(3)
        ? 1
        : 0 + (uint8list[currentIndex].isBitSet(4) ? 1 : 0));
    //
//    print('will qos: ' + (willQos.toString()));
    final willRetain = uint8list[currentIndex].isBitSet(5);
    //
//    print('will retain: ' + willRetain.toString());
    final passwordFlag = uint8list[currentIndex].isBitSet(6);
    //
//    print('password flag: ' + passwordFlag.toString());
    final usernameFlag = uint8list[currentIndex].isBitSet(7);
    //
//    print('user name flag $usernameFlag');

    currentIndex++;
    final keepAliveSeconds = Uint8List.fromList(
            [uint8list[currentIndex++], uint8list[currentIndex++]])
        .buffer
        .asByteData()
        .getUint16(0)
        .toString();
    //
//    print('Keep alive: ' + keepAliveSeconds);

    // Version 5 needs to get the following before getting the clientID
    if (protocolVersion == 'mqtt_5') {
      var connectPropertiesLength =
          uint8list.sublist(currentIndex++).buffer.asByteData().getUint8(0);
//      print('Length Connection Properties: ' +
//          connectPropertiesLength.toString());
      // Cycle through the connectionPropertiesLength until it is empty
      while (connectPropertiesLength > 0) {
        // Next byte is connection property type followed by x bytes

        var controlPropertyType =
            uint8list.sublist(currentIndex++).buffer.asByteData().getUint8(0);
        connectPropertiesLength--;
        switch (controlPropertyType) {
          case 17:
            // four byte value for Session Expiry Interval
            // must only be present once
            var controlPropertySEI = uint8list
                .sublist(currentIndex++)
                .buffer
                .asByteData()
                .getUint32(0);
//            print('Control Request Response Information: ' +
//                controlPropertySEI.toString());
            connectPropertiesLength =
                connectPropertiesLength - 4; // Remove 4 bytes for SEI
            currentIndex = currentIndex + 3; // Move index 3 bytes for SEI
            break;

          case 33:
            // 2 byte value for Receive Maximum
            // must only be present once
            var controlPropertyRM = uint8list
                .sublist(currentIndex++)
                .buffer
                .asByteData()
                .getUint16(0);
//            print('Control Receive Maximum: ' + controlPropertyRM.toString());
            connectPropertiesLength =
                connectPropertiesLength - 2; // Remove 2 bytes for RM
            currentIndex = currentIndex + 1;
            break;

          case 39:
            // 4 byte value for Maximum Packet Size
            // must only be present once
            var controlPropertyMPS = uint8list
                .sublist(currentIndex++)
                .buffer
                .asByteData()
                .getUint32(0);
//            print('Control Maximum Packet Size: ' +
//                controlPropertyMPS.toString());
            connectPropertiesLength =
                connectPropertiesLength - 4; // Remove 2 bytes for MPS
            currentIndex = currentIndex + 3;
            break;

          case 34:
            // 2 byte value for Topic Alias Maximum
            // must only be present once
            var controlPropertyTAM = uint8list
                .sublist(currentIndex++)
                .buffer
                .asByteData()
                .getUint16(0);
//            print('Control Topic Alias Maximum: ' +
//                controlPropertyTAM.toString());
            connectPropertiesLength =
                connectPropertiesLength - 2; // Remove 2 bytes for TAM
            currentIndex++;
            break;

          case 25:
            // one byte value for Request Response Information
            // valid values are 0 and 1
            // must only be present once
            var controlPropertyRRI = uint8list
                .sublist(currentIndex++)
                .buffer
                .asByteData()
                .getUint8(0);
//            print('Control Request Response Information: ' +
//                controlPropertyRRI.toString());
            connectPropertiesLength--; // Remove byte for RRI
            break;

          case 23:
            // one byte value for Request Problem Information
            // valid values are 0 and 1
            // must only be present once
            var controlPropertyRPI = uint8list
                .sublist(currentIndex++)
                .buffer
                .asByteData()
                .getUint8(0);
//            print('Control Request Problem Information: ' +
//                controlPropertyRPI.toString());
            connectPropertiesLength--; // Remove byte for RPI
            break;

          // TODO Handle User Key/Value
          case 38:
            // variable byte key/value pairs
            // can be seen multiple times
            // first two bytes give length of key
            // once key is read the next two give length of value
            var keyLength = uint8list
                .sublist(currentIndex++)
                .buffer
                .asByteData()
                .getUint16(0);
            currentIndex++;
//            print('Key length: ' + keyLength.toString());
            currentIndex = currentIndex + keyLength;
            var valueLength = uint8list
                .sublist(currentIndex++)
                .buffer
                .asByteData()
                .getUint16(0);
//            print('Value Length: ' + valueLength.toString());
            currentIndex = currentIndex + valueLength + 1;
            connectPropertiesLength =
                connectPropertiesLength - keyLength - valueLength - 4;
//            print('connectionPropertiesLength: ' +
//                connectPropertiesLength.toString());
            break;

          // TODO Handle Authentication DATA
          case 22:
            break;

          default:
        }
      }
    }
    print(uint8list.sublist(currentIndex).buffer.asByteData().getInt8(0));

    final clientIdStringLength = uint8list
        .sublist(currentIndex++, ++currentIndex)
        .buffer
        .asByteData()
        .getUint16(0);

//    print('clientIdStringLength:' + clientIdStringLength.toString());

    final clientIdString = utf8.decode(
        uint8list.sublist(currentIndex, currentIndex + clientIdStringLength));

    //
//    print('client id: ' + clientIdString);

    currentIndex += clientIdStringLength;

    if (usernameFlag) {
      final usernameLength =
          uint8list.buffer.asByteData(currentIndex++).getUint16(0);
      currentIndex++;
      final usernameString = utf8.decode(
          uint8list.sublist(currentIndex, currentIndex + usernameLength));
      currentIndex += usernameLength;
      //
//      print('username: ' + usernameString);
    }

    //
//    print(currentIndex);

    if (passwordFlag) {
      final passwordLength =
          uint8list.buffer.asByteData(currentIndex++).getUint16(0);
      final passwordString = utf8.decode(
          uint8list.sublist(++currentIndex, currentIndex + passwordLength));
      currentIndex += passwordLength;

      //
//      print('password: $passwordString');
    }

    //TODO implement will topic
    if (SessionManager.instance.containsClientId(clientIdString)) {
      //TODO check flags and send error to socket
    }

    SessionManager.instance.sessions.add(Client(
        clientId: clientIdString, socket: socket, protocol: protocolVersion));

    final connack = ConnackMessage(
        cleanSession: cleanSession,
        returnCode: ConnectReturnCode.connectionAccepted);

    return connack;
  }
}

class Subscription {
  final int qos;
  final String topic;

  Subscription({required this.qos, required this.topic});
}

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


//TODO: Handle wildcard subcriptions 
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
//    print('Current Index from encoding: ' + currentIndex.toString());
//    print('Header Length from encoding: ' + headerLength.toString());
    final packetIdentifier = buffer.asByteData(currentIndex, 2).getUint16(0);
    //
//    print('packet identifier: $packetIdentifier');
    currentIndex++;
    // TODO: Figure why the extra byte before payload in protocol 5
    if (clientProtocol == 'mqtt_5') {
      currentIndex++;
    }

    //print(buffer.lengthInBytes);

    final List<String> topics = [];

    final List<Subscription> subscriptions = [];

    // print(currentIndex);

    ///payload
    while (currentIndex < buffer.lengthInBytes - 1) {
      currentIndex++;
      int payloadLength = buffer.asByteData(currentIndex, 2).getUint16(0);
      currentIndex += 2;
      final topic =
          utf8.decode(buffer.asUint8List(currentIndex, payloadLength));
      topics.add(topic);
//      print(topic);
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

class PublishMessageDecoder implements MessageDecoder {
  // bool checkBit(int value, int bit) => (value & (1 << bit)) != 0;

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
    return pub;
  }
}

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


// TODO: Should this even extend MessageDecoder?
// Would it be better as a standalone class that 
// handles disconnecting client?

class DisconnectMessageDecoder extends MessageDecoder {
  @override
  Future<Message> decode(Uint8List uint8list, Socket socket) async {
    SessionManager.instance.sessions
        .removeWhere((client) => client.socket == socket);
    SubscriptionManager.instance.subscriptions
        .removeWhere((key, value) => key.socket == socket);
    socket.close();
    //TODO shouldn't return

    return PingrespMessage();
  }
}

abstract class MessageDecoder {
  Future<Message> decode(Uint8List uint8list, Socket socket);
}

main() {}
