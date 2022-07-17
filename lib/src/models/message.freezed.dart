// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'message.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Message _$MessageFromJson(Map<String, dynamic> json) {
  return _Message.fromJson(json);
}

/// @nodoc
class _$MessageTearOff {
  const _$MessageTearOff();

  _Message call({required String topic, required String messages}) {
    return _Message(
      topic: topic,
      messages: messages,
    );
  }

  Message fromJson(Map<String, Object?> json) {
    return Message.fromJson(json);
  }
}

/// @nodoc
const $Message = _$MessageTearOff();

/// @nodoc
mixin _$Message {
  String get topic => throw _privateConstructorUsedError;
  String get messages => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MessageCopyWith<Message> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MessageCopyWith<$Res> {
  factory $MessageCopyWith(Message value, $Res Function(Message) then) =
      _$MessageCopyWithImpl<$Res>;
  $Res call({String topic, String messages});
}

/// @nodoc
class _$MessageCopyWithImpl<$Res> implements $MessageCopyWith<$Res> {
  _$MessageCopyWithImpl(this._value, this._then);

  final Message _value;
  // ignore: unused_field
  final $Res Function(Message) _then;

  @override
  $Res call({
    Object? topic = freezed,
    Object? messages = freezed,
  }) {
    return _then(_value.copyWith(
      topic: topic == freezed
          ? _value.topic
          : topic // ignore: cast_nullable_to_non_nullable
              as String,
      messages: messages == freezed
          ? _value.messages
          : messages // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$MessageCopyWith<$Res> implements $MessageCopyWith<$Res> {
  factory _$MessageCopyWith(_Message value, $Res Function(_Message) then) =
      __$MessageCopyWithImpl<$Res>;
  @override
  $Res call({String topic, String messages});
}

/// @nodoc
class __$MessageCopyWithImpl<$Res> extends _$MessageCopyWithImpl<$Res>
    implements _$MessageCopyWith<$Res> {
  __$MessageCopyWithImpl(_Message _value, $Res Function(_Message) _then)
      : super(_value, (v) => _then(v as _Message));

  @override
  _Message get _value => super._value as _Message;

  @override
  $Res call({
    Object? topic = freezed,
    Object? messages = freezed,
  }) {
    return _then(_Message(
      topic: topic == freezed
          ? _value.topic
          : topic // ignore: cast_nullable_to_non_nullable
              as String,
      messages: messages == freezed
          ? _value.messages
          : messages // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Message implements _Message {
  const _$_Message({required this.topic, required this.messages});

  factory _$_Message.fromJson(Map<String, dynamic> json) =>
      _$$_MessageFromJson(json);

  @override
  final String topic;
  @override
  final String messages;

  @override
  String toString() {
    return 'Message(topic: $topic, messages: $messages)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Message &&
            const DeepCollectionEquality().equals(other.topic, topic) &&
            const DeepCollectionEquality().equals(other.messages, messages));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(topic),
      const DeepCollectionEquality().hash(messages));

  @JsonKey(ignore: true)
  @override
  _$MessageCopyWith<_Message> get copyWith =>
      __$MessageCopyWithImpl<_Message>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_MessageToJson(this);
  }
}

abstract class _Message implements Message {
  const factory _Message({required String topic, required String messages}) =
      _$_Message;

  factory _Message.fromJson(Map<String, dynamic> json) = _$_Message.fromJson;

  @override
  String get topic;
  @override
  String get messages;
  @override
  @JsonKey(ignore: true)
  _$MessageCopyWith<_Message> get copyWith =>
      throw _privateConstructorUsedError;
}

Messages _$MessagesFromJson(Map<String, dynamic> json) {
  return _Messages.fromJson(json);
}

/// @nodoc
class _$MessagesTearOff {
  const _$MessagesTearOff();

  _Messages call(
      {required List<dynamic> messages, required int totalMessages}) {
    return _Messages(
      messages: messages,
      totalMessages: totalMessages,
    );
  }

  Messages fromJson(Map<String, Object?> json) {
    return Messages.fromJson(json);
  }
}

/// @nodoc
const $Messages = _$MessagesTearOff();

/// @nodoc
mixin _$Messages {
  List<dynamic> get messages => throw _privateConstructorUsedError;
  int get totalMessages => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MessagesCopyWith<Messages> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MessagesCopyWith<$Res> {
  factory $MessagesCopyWith(Messages value, $Res Function(Messages) then) =
      _$MessagesCopyWithImpl<$Res>;
  $Res call({List<dynamic> messages, int totalMessages});
}

/// @nodoc
class _$MessagesCopyWithImpl<$Res> implements $MessagesCopyWith<$Res> {
  _$MessagesCopyWithImpl(this._value, this._then);

  final Messages _value;
  // ignore: unused_field
  final $Res Function(Messages) _then;

  @override
  $Res call({
    Object? messages = freezed,
    Object? totalMessages = freezed,
  }) {
    return _then(_value.copyWith(
      messages: messages == freezed
          ? _value.messages
          : messages // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
      totalMessages: totalMessages == freezed
          ? _value.totalMessages
          : totalMessages // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
abstract class _$MessagesCopyWith<$Res> implements $MessagesCopyWith<$Res> {
  factory _$MessagesCopyWith(_Messages value, $Res Function(_Messages) then) =
      __$MessagesCopyWithImpl<$Res>;
  @override
  $Res call({List<dynamic> messages, int totalMessages});
}

/// @nodoc
class __$MessagesCopyWithImpl<$Res> extends _$MessagesCopyWithImpl<$Res>
    implements _$MessagesCopyWith<$Res> {
  __$MessagesCopyWithImpl(_Messages _value, $Res Function(_Messages) _then)
      : super(_value, (v) => _then(v as _Messages));

  @override
  _Messages get _value => super._value as _Messages;

  @override
  $Res call({
    Object? messages = freezed,
    Object? totalMessages = freezed,
  }) {
    return _then(_Messages(
      messages: messages == freezed
          ? _value.messages
          : messages // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
      totalMessages: totalMessages == freezed
          ? _value.totalMessages
          : totalMessages // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Messages implements _Messages {
  const _$_Messages({required this.messages, required this.totalMessages});

  factory _$_Messages.fromJson(Map<String, dynamic> json) =>
      _$$_MessagesFromJson(json);

  @override
  final List<dynamic> messages;
  @override
  final int totalMessages;

  @override
  String toString() {
    return 'Messages(messages: $messages, totalMessages: $totalMessages)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Messages &&
            const DeepCollectionEquality().equals(other.messages, messages) &&
            const DeepCollectionEquality()
                .equals(other.totalMessages, totalMessages));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(messages),
      const DeepCollectionEquality().hash(totalMessages));

  @JsonKey(ignore: true)
  @override
  _$MessagesCopyWith<_Messages> get copyWith =>
      __$MessagesCopyWithImpl<_Messages>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_MessagesToJson(this);
  }
}

abstract class _Messages implements Messages {
  const factory _Messages(
      {required List<dynamic> messages,
      required int totalMessages}) = _$_Messages;

  factory _Messages.fromJson(Map<String, dynamic> json) = _$_Messages.fromJson;

  @override
  List<dynamic> get messages;
  @override
  int get totalMessages;
  @override
  @JsonKey(ignore: true)
  _$MessagesCopyWith<_Messages> get copyWith =>
      throw _privateConstructorUsedError;
}
