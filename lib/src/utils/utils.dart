import 'dart:typed_data';
import 'package:dttp_mqtt/src/message/message_enums.dart';

/// Utilities for MQTT
///

extension ProtocolVersionUtil on ProtocolVersion {
  static const _protocols = ProtocolVersion.values;

  static ProtocolVersion getProtocolVersion(int version) {
    final offset = 4;
    return _protocols[version - offset];
  }
}

/// Determine if bit x is set
extension Bits on int {
  /// Returns true if bit is 1 else false
  bool isBitSet(final int position) {
    return (this & (1 << position)) != 0;
  }
}


/// variable byte decode
///

Map<String, int> decodeVariableByte(Uint8List uint8list, startIndex) {
  int multiplier = 1;
  int value = 0;
  int encodedByte = 0;
  do {
    encodedByte = uint8list.buffer.asByteData(startIndex).getUint8(0);
    value += (encodedByte & 127) * multiplier;
    if (multiplier > 128 * 128 * 128) {
      // Something is wrong
      // disconnect from client
    }
    multiplier *= 128;
    startIndex++;
  } while ((encodedByte & 128) != 0);
  return {'decodedVariableByte': value, 'index': startIndex };
}

/// variable byte encode
/// TODO: implement this
