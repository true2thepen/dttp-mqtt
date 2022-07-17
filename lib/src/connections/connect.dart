import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import '../models/client.dart';
import '../client_manager/client_manager.dart';
import '../connections/connection_enums.dart';
import '../message/message_enums.dart';
import '../message/message.dart';
import '../session_manager/session_manager.dart';
import '../subscriptions/subscription.dart';
import '../utils/utils.dart';

/// Connect Message
///
class ConnectMessage extends Message with ResponseMessage {
  final ProtocolVersion version;

  ConnectMessage({
    this.version = ProtocolVersion.mqtt_3_1_1,
  }) : super(
          type: MessageType.connect,
        );
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

/// Connection Acknowledgement Message
///
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

/// Connect message decoder
///
class ConnectMessageDecoder extends MessageDecoder {
  @override
  Future<ConnackMessage> decode(Uint8List uint8list, Socket socket) async {
    int currentIndex = 8;
    var protocolVersion =
        ProtocolVersionUtil.getProtocolVersion(uint8list[currentIndex]).name;

    currentIndex++;
    // final bits = uint8list[currentIndex].toRadixString(2);
    final cleanSession = uint8list[currentIndex].isBitSet(1);
    final willFlag = uint8list[currentIndex].isBitSet(2);
    final willQos = (uint8list[currentIndex].isBitSet(3)
        ? 1
        : 0 + (uint8list[currentIndex].isBitSet(4) ? 1 : 0));
    final willRetain = uint8list[currentIndex].isBitSet(5);
    final passwordFlag = uint8list[currentIndex].isBitSet(6);
    final usernameFlag = uint8list[currentIndex].isBitSet(7);

    currentIndex++;
    final keepAliveSeconds = Uint8List.fromList(
            [uint8list[currentIndex++], uint8list[currentIndex++]])
        .buffer
        .asByteData()
        .getUint16(0)
        .toString();

    /// Version 5 needs to get the following before getting the clientID
    if (protocolVersion == 'mqtt_5') {
      var connectPropertiesLength =
          uint8list.sublist(currentIndex++).buffer.asByteData().getUint8(0);

      /// Cycle through the connectionPropertiesLength until it is empty
      while (connectPropertiesLength > 0) {
        // Next byte is connection property type followed by x bytes
        var controlPropertyType =
            uint8list.sublist(currentIndex++).buffer.asByteData().getUint8(0);
        connectPropertiesLength--;
        switch (controlPropertyType) {
          case 17:

            /// four byte value for Session Expiry Interval
            /// must only be present once
            var controlPropertySEI = uint8list
                .sublist(currentIndex++)
                .buffer
                .asByteData()
                .getUint32(0);
            connectPropertiesLength =
                connectPropertiesLength - 4; // Remove 4 bytes for SEI
            currentIndex = currentIndex + 3; // Move index 3 bytes for SEI
            break;

          case 33:

            /// 2 byte value for Receive Maximum
            /// must only be present once
            var controlPropertyRM = uint8list
                .sublist(currentIndex++)
                .buffer
                .asByteData()
                .getUint16(0);
            connectPropertiesLength =
                connectPropertiesLength - 2; // Remove 2 bytes for RM
            currentIndex = currentIndex + 1;
            break;

          case 39:

            /// 4 byte value for Maximum Packet Size
            /// must only be present once
            var controlPropertyMPS = uint8list
                .sublist(currentIndex++)
                .buffer
                .asByteData()
                .getUint32(0);
            connectPropertiesLength =
                connectPropertiesLength - 4; // Remove 2 bytes for MPS
            currentIndex = currentIndex + 3;
            break;

          case 34:

            /// 2 byte value for Topic Alias Maximum
            /// must only be present once
            var controlPropertyTAM = uint8list
                .sublist(currentIndex++)
                .buffer
                .asByteData()
                .getUint16(0);
            connectPropertiesLength =
                connectPropertiesLength - 2; // Remove 2 bytes for TAM
            currentIndex++;
            break;

          case 25:

            /// one byte value for Request Response Information
            /// valid values are 0 and 1
            /// must only be present once
            var controlPropertyRRI = uint8list
                .sublist(currentIndex++)
                .buffer
                .asByteData()
                .getUint8(0);
            connectPropertiesLength--; // Remove byte for RRI
            break;

          case 23:

            /// one byte value for Request Problem Information
            /// valid values are 0 and 1
            /// must only be present once
            var controlPropertyRPI = uint8list
                .sublist(currentIndex++)
                .buffer
                .asByteData()
                .getUint8(0);
            connectPropertiesLength--; // Remove byte for RPI
            break;

          /// TODO Handle User Key/Value
          case 38:

            /// variable byte key/value pairs
            /// can be seen multiple times
            /// first two bytes give length of key
            /// once key is read the next two give length of value
            var keyLength = uint8list
                .sublist(currentIndex++)
                .buffer
                .asByteData()
                .getUint16(0);
            currentIndex++;
            currentIndex = currentIndex + keyLength;
            var valueLength = uint8list
                .sublist(currentIndex++)
                .buffer
                .asByteData()
                .getUint16(0);
            currentIndex = currentIndex + valueLength + 1;
            connectPropertiesLength =
                connectPropertiesLength - keyLength - valueLength - 4;

            /// TODO: Fix to store key/vale in Will Properties User field

            break;

          /// TODO Handle Authentication DATA
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
    final clientIdString = utf8.decode(
        uint8list.sublist(currentIndex, currentIndex + clientIdStringLength));

    currentIndex += clientIdStringLength;

    /// TODO complete implementation of  will topic
    /// If Will flag is set Will Properties is next
    /// Handling is based upon which Protocol
    /// Version 3.1.1 or Version 5
    ///
    if (willFlag) {
      switch (protocolVersion) {
        case 'mqtt_3_1_1':

          /// Will Topic
          final willTopicStringLength = uint8list
              .sublist(currentIndex++, ++currentIndex)
              .buffer
              .asByteData()
              .getUint16(0);
          final willTopicString = utf8.decode(uint8list.sublist(
              currentIndex, currentIndex + willTopicStringLength));
          currentIndex += willTopicStringLength;

          /// Will Message
          final willMessageStringLength = uint8list
              .sublist(currentIndex++, ++currentIndex)
              .buffer
              .asByteData()
              .getUint16(0);
          final willMessageString = utf8.decode(uint8list.sublist(
              currentIndex, currentIndex + willMessageStringLength));
          currentIndex += willMessageStringLength;

          break;
        case 'mqtt_5':

          /// Will Properties
          var decodedVariableByteHeader =
              decodeVariableByte(uint8list, currentIndex);
          currentIndex = decodedVariableByteHeader['index']!;
          var willPropertiesLength =
              decodedVariableByteHeader['decodedVariableByte']!;
          while (willPropertiesLength > 0) {
            int willPropertiesType =
                uint8list.buffer.asByteData(currentIndex).getUint8(0);
            willPropertiesLength--;
            currentIndex++;
            switch (willPropertiesType) {
              case 1:
                var payloadFormatIndicator =
                    uint8list.buffer.asByteData(currentIndex).getUint8(0);
                currentIndex++;
                willPropertiesLength--;
                break;

              case 2:
                var messageExpiryInterval =
                    uint8list.buffer.asByteData(currentIndex).getUint32(0);
                currentIndex += 4;
                willPropertiesLength -= 4;
                break;

              case 3:
                var decodedVariableByteHeader =
                    decodeVariableByte(uint8list, currentIndex);
                var oldIndex = currentIndex;
                currentIndex = decodedVariableByteHeader['index']!;
                willPropertiesLength =
                    willPropertiesLength - (currentIndex - oldIndex);
                int contentTypeLength =
                    decodedVariableByteHeader['decodedVariableByte']!;
                String willMessageString = utf8.decode(uint8list.sublist(
                    currentIndex, currentIndex + contentTypeLength));
                currentIndex += contentTypeLength;
                willPropertiesLength -= contentTypeLength;
                break;

              case 8:
                var decodedVariableByteHeader =
                    decodeVariableByte(uint8list, currentIndex);
                var oldIndex = currentIndex;
                currentIndex = decodedVariableByteHeader['index']!;
                willPropertiesLength =
                    willPropertiesLength - (currentIndex - oldIndex);
                int contentTypeLength =
                    decodedVariableByteHeader['decodedVariableByte']!;
                String responseTopicString = utf8.decode(uint8list.sublist(
                    currentIndex, currentIndex + contentTypeLength));
                currentIndex += contentTypeLength;
                willPropertiesLength -= contentTypeLength;
                break;

              case 9:
                int correlationDataLength =
                    uint8list.buffer.asByteData(currentIndex).getUint16(0);
                currentIndex += 2;
                willPropertiesLength -= 2;
                var correlationData = uint8list.sublist(
                    currentIndex, currentIndex + correlationDataLength);
                currentIndex += correlationDataLength;
                willPropertiesLength -= correlationDataLength;
                break;

              case 24:
                var willDelayInterval =
                    uint8list.buffer.asByteData(currentIndex).getUint32(0);
                currentIndex += 4;
                willPropertiesLength -= 4;
                break;

              case 38:

                /// variable byte key/value pairs
                /// can be seen multiple times
                /// first two bytes give length of key
                /// once key is read the next two give length of value
                var keyLength = uint8list
                    .sublist(currentIndex++)
                    .buffer
                    .asByteData()
                    .getUint16(0);
                currentIndex++;
                currentIndex = currentIndex + keyLength;
                var valueLength = uint8list
                    .sublist(currentIndex++)
                    .buffer
                    .asByteData()
                    .getUint16(0);
                currentIndex = currentIndex + valueLength + 1;
                willPropertiesLength =
                    willPropertiesLength - keyLength - valueLength - 4;

                /// TODO: Fix to store key/vale in Will Properties User field
                break;

              default:

              /// We should never reach this,
              /// If we do we should disconnect with unknown error
            }
          }

          /// Will Topic
          final willTopicStringLength = uint8list
              .sublist(currentIndex++, ++currentIndex)
              .buffer
              .asByteData()
              .getUint16(0);
          final willTopicString = utf8.decode(uint8list.sublist(
              currentIndex, currentIndex + willTopicStringLength));
          currentIndex += willTopicStringLength;

          /// Will Message
          final willMessageStringLength = uint8list
              .sublist(currentIndex++, ++currentIndex)
              .buffer
              .asByteData()
              .getUint16(0);
          final willMessageString = utf8.decode(uint8list.sublist(
              currentIndex, currentIndex + willMessageStringLength));
          currentIndex += willMessageStringLength;
          break;

        default:

        /// Should disconnect if we reach here
        /// with reason code invalid protocol
      }
    }

    if (usernameFlag) {
      final usernameLength =
          uint8list.buffer.asByteData(currentIndex++).getUint16(0);
      currentIndex++;
      final usernameString = utf8.decode(
          uint8list.sublist(currentIndex, currentIndex + usernameLength));
      currentIndex += usernameLength;
    }

    if (passwordFlag) {
      final passwordLength =
          uint8list.buffer.asByteData(currentIndex++).getUint16(0);
      final passwordString = utf8.decode(
          uint8list.sublist(++currentIndex, currentIndex + passwordLength));
      currentIndex += passwordLength;
    }

    /// TODO: At this point we really should create the client in
    /// the ClientManager. The ClientManager should be responsible
    /// for setting up the session for the client. Since clients
    /// can reconnect we do need to retain their previous information
    /// somewhere. Session management doesn't seem to be the
    /// appropriate place for that, hence the ClientManager.

    if (SessionManager.instance.containsClientId(clientIdString)) {
      /// TODO check flags and send error to socket
    }

    ClientManager.instance.clients.add(Client(
        clientId: clientIdString,
        id: clientIdString,
        protocol: protocolVersion));

    final connack = ConnackMessage(
        cleanSession: cleanSession,
        returnCode: ConnectReturnCode.connectionAccepted);

    return connack;
  }
}

/// DisconnectMessageDecoder
///
class DisconnectMessageDecoder {
  Future<void> decode(Uint8List uint8list, Socket socket) async {
    String clientId = SessionManager.instance.getClient(socket).clientId;
    SessionManager.instance.sessions
        .removeWhere((client) => client.socket == socket);
    SubscriptionManager.instance.subscriptions
        .removeWhere((key, value) => key.clientId == clientId);
    socket.close();
  }
}
