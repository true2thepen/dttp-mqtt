import 'package:freezed_annotation/freezed_annotation.dart';

part 'message.freezed.dart';
part 'message.g.dart';

@freezed
class Message with _$Message {
  const factory Message({
    required String topic,
    required String messages,
  }) = _Message;

  factory Message.fromJson(json) => _$MessageFromJson(json);
}

@freezed
class Messages with _$Messages {
  const factory Messages({
    required List messages,
    required int totalMessages,
  }) = _Messages;

  factory Messages.fromJson(json) => _$MessagesFromJson(json);
}



/*
class Message {
  final String topic;
  final String message;

  Message({required this.topic, required this.message});
}

class Messages {
  final List<Message> messages;

  Messages(this.messages);

  addMessage(String topic, String message) {
    messages.add(Message(topic: topic, message: message));
  }

  removeMessage(String topic, String message) {
    messages.remove(Message(topic: topic, message: message));
  }

  getAllMessages() {
    return messages;
  }



}
*/