import 'package:dttp_mqtt/dttp_mqtt.dart';

void main() {
  var s = Server('0.0.0.0', 1885);
  s.start();
}
