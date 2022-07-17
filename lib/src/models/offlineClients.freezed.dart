// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'offlineClients.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

OffLineClient _$OffLineClientFromJson(Map<String, dynamic> json) {
  return _OffLineClient.fromJson(json);
}

/// @nodoc
class _$OffLineClientTearOff {
  const _$OffLineClientTearOff();

  _OffLineClient call(
      {required String clientId, required List<Messages> messages}) {
    return _OffLineClient(
      clientId: clientId,
      messages: messages,
    );
  }

  OffLineClient fromJson(Map<String, Object?> json) {
    return OffLineClient.fromJson(json);
  }
}

/// @nodoc
const $OffLineClient = _$OffLineClientTearOff();

/// @nodoc
mixin _$OffLineClient {
  String get clientId => throw _privateConstructorUsedError;
  List<Messages> get messages => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OffLineClientCopyWith<OffLineClient> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OffLineClientCopyWith<$Res> {
  factory $OffLineClientCopyWith(
          OffLineClient value, $Res Function(OffLineClient) then) =
      _$OffLineClientCopyWithImpl<$Res>;
  $Res call({String clientId, List<Messages> messages});
}

/// @nodoc
class _$OffLineClientCopyWithImpl<$Res>
    implements $OffLineClientCopyWith<$Res> {
  _$OffLineClientCopyWithImpl(this._value, this._then);

  final OffLineClient _value;
  // ignore: unused_field
  final $Res Function(OffLineClient) _then;

  @override
  $Res call({
    Object? clientId = freezed,
    Object? messages = freezed,
  }) {
    return _then(_value.copyWith(
      clientId: clientId == freezed
          ? _value.clientId
          : clientId // ignore: cast_nullable_to_non_nullable
              as String,
      messages: messages == freezed
          ? _value.messages
          : messages // ignore: cast_nullable_to_non_nullable
              as List<Messages>,
    ));
  }
}

/// @nodoc
abstract class _$OffLineClientCopyWith<$Res>
    implements $OffLineClientCopyWith<$Res> {
  factory _$OffLineClientCopyWith(
          _OffLineClient value, $Res Function(_OffLineClient) then) =
      __$OffLineClientCopyWithImpl<$Res>;
  @override
  $Res call({String clientId, List<Messages> messages});
}

/// @nodoc
class __$OffLineClientCopyWithImpl<$Res>
    extends _$OffLineClientCopyWithImpl<$Res>
    implements _$OffLineClientCopyWith<$Res> {
  __$OffLineClientCopyWithImpl(
      _OffLineClient _value, $Res Function(_OffLineClient) _then)
      : super(_value, (v) => _then(v as _OffLineClient));

  @override
  _OffLineClient get _value => super._value as _OffLineClient;

  @override
  $Res call({
    Object? clientId = freezed,
    Object? messages = freezed,
  }) {
    return _then(_OffLineClient(
      clientId: clientId == freezed
          ? _value.clientId
          : clientId // ignore: cast_nullable_to_non_nullable
              as String,
      messages: messages == freezed
          ? _value.messages
          : messages // ignore: cast_nullable_to_non_nullable
              as List<Messages>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_OffLineClient implements _OffLineClient {
  const _$_OffLineClient({required this.clientId, required this.messages});

  factory _$_OffLineClient.fromJson(Map<String, dynamic> json) =>
      _$$_OffLineClientFromJson(json);

  @override
  final String clientId;
  @override
  final List<Messages> messages;

  @override
  String toString() {
    return 'OffLineClient(clientId: $clientId, messages: $messages)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _OffLineClient &&
            const DeepCollectionEquality().equals(other.clientId, clientId) &&
            const DeepCollectionEquality().equals(other.messages, messages));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(clientId),
      const DeepCollectionEquality().hash(messages));

  @JsonKey(ignore: true)
  @override
  _$OffLineClientCopyWith<_OffLineClient> get copyWith =>
      __$OffLineClientCopyWithImpl<_OffLineClient>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_OffLineClientToJson(this);
  }
}

abstract class _OffLineClient implements OffLineClient {
  const factory _OffLineClient(
      {required String clientId,
      required List<Messages> messages}) = _$_OffLineClient;

  factory _OffLineClient.fromJson(Map<String, dynamic> json) =
      _$_OffLineClient.fromJson;

  @override
  String get clientId;
  @override
  List<Messages> get messages;
  @override
  @JsonKey(ignore: true)
  _$OffLineClientCopyWith<_OffLineClient> get copyWith =>
      throw _privateConstructorUsedError;
}

OffLineClients _$OffLineClientsFromJson(Map<String, dynamic> json) {
  return _OffLineClients.fromJson(json);
}

/// @nodoc
class _$OffLineClientsTearOff {
  const _$OffLineClientsTearOff();

  _OffLineClients call(
      {required List<OffLineClient> clients, required int totalClients}) {
    return _OffLineClients(
      clients: clients,
      totalClients: totalClients,
    );
  }

  OffLineClients fromJson(Map<String, Object?> json) {
    return OffLineClients.fromJson(json);
  }
}

/// @nodoc
const $OffLineClients = _$OffLineClientsTearOff();

/// @nodoc
mixin _$OffLineClients {
  List<OffLineClient> get clients => throw _privateConstructorUsedError;
  int get totalClients => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OffLineClientsCopyWith<OffLineClients> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OffLineClientsCopyWith<$Res> {
  factory $OffLineClientsCopyWith(
          OffLineClients value, $Res Function(OffLineClients) then) =
      _$OffLineClientsCopyWithImpl<$Res>;
  $Res call({List<OffLineClient> clients, int totalClients});
}

/// @nodoc
class _$OffLineClientsCopyWithImpl<$Res>
    implements $OffLineClientsCopyWith<$Res> {
  _$OffLineClientsCopyWithImpl(this._value, this._then);

  final OffLineClients _value;
  // ignore: unused_field
  final $Res Function(OffLineClients) _then;

  @override
  $Res call({
    Object? clients = freezed,
    Object? totalClients = freezed,
  }) {
    return _then(_value.copyWith(
      clients: clients == freezed
          ? _value.clients
          : clients // ignore: cast_nullable_to_non_nullable
              as List<OffLineClient>,
      totalClients: totalClients == freezed
          ? _value.totalClients
          : totalClients // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
abstract class _$OffLineClientsCopyWith<$Res>
    implements $OffLineClientsCopyWith<$Res> {
  factory _$OffLineClientsCopyWith(
          _OffLineClients value, $Res Function(_OffLineClients) then) =
      __$OffLineClientsCopyWithImpl<$Res>;
  @override
  $Res call({List<OffLineClient> clients, int totalClients});
}

/// @nodoc
class __$OffLineClientsCopyWithImpl<$Res>
    extends _$OffLineClientsCopyWithImpl<$Res>
    implements _$OffLineClientsCopyWith<$Res> {
  __$OffLineClientsCopyWithImpl(
      _OffLineClients _value, $Res Function(_OffLineClients) _then)
      : super(_value, (v) => _then(v as _OffLineClients));

  @override
  _OffLineClients get _value => super._value as _OffLineClients;

  @override
  $Res call({
    Object? clients = freezed,
    Object? totalClients = freezed,
  }) {
    return _then(_OffLineClients(
      clients: clients == freezed
          ? _value.clients
          : clients // ignore: cast_nullable_to_non_nullable
              as List<OffLineClient>,
      totalClients: totalClients == freezed
          ? _value.totalClients
          : totalClients // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_OffLineClients implements _OffLineClients {
  const _$_OffLineClients({required this.clients, required this.totalClients});

  factory _$_OffLineClients.fromJson(Map<String, dynamic> json) =>
      _$$_OffLineClientsFromJson(json);

  @override
  final List<OffLineClient> clients;
  @override
  final int totalClients;

  @override
  String toString() {
    return 'OffLineClients(clients: $clients, totalClients: $totalClients)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _OffLineClients &&
            const DeepCollectionEquality().equals(other.clients, clients) &&
            const DeepCollectionEquality()
                .equals(other.totalClients, totalClients));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(clients),
      const DeepCollectionEquality().hash(totalClients));

  @JsonKey(ignore: true)
  @override
  _$OffLineClientsCopyWith<_OffLineClients> get copyWith =>
      __$OffLineClientsCopyWithImpl<_OffLineClients>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_OffLineClientsToJson(this);
  }
  
  @override
  addClient(String clientId) {
    // TODO: implement addClient
    throw UnimplementedError();
  }
  
  @override
  removeClient(String clientId) {
    // TODO: implement removeClient
    throw UnimplementedError();
  }
}

abstract class _OffLineClients implements OffLineClients {
  const factory _OffLineClients(
      {required List<OffLineClient> clients,
      required int totalClients}) = _$_OffLineClients;

  factory _OffLineClients.fromJson(Map<String, dynamic> json) =
      _$_OffLineClients.fromJson;

  @override
  List<OffLineClient> get clients;
  @override
  int get totalClients;
  @override
  @JsonKey(ignore: true)
  _$OffLineClientsCopyWith<_OffLineClients> get copyWith =>
      throw _privateConstructorUsedError;
}
