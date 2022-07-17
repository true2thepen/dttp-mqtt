// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'client.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Client _$ClientFromJson(Map<String, dynamic> json) {
  return _Client.fromJson(json);
}

/// @nodoc
class _$ClientTearOff {
  const _$ClientTearOff();

  _Client call(
      {required String clientId,
      required String protocol,
      required String id}) {
    return _Client(
      clientId: clientId,
      protocol: protocol,
      id: id,
    );
  }

  Client fromJson(Map<String, Object?> json) {
    return Client.fromJson(json);
  }
}

/// @nodoc
const $Client = _$ClientTearOff();

/// @nodoc
mixin _$Client {
  String get clientId => throw _privateConstructorUsedError;
  String get protocol => throw _privateConstructorUsedError;
  String get id => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ClientCopyWith<Client> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClientCopyWith<$Res> {
  factory $ClientCopyWith(Client value, $Res Function(Client) then) =
      _$ClientCopyWithImpl<$Res>;
  $Res call({String clientId, String protocol, String id});
}

/// @nodoc
class _$ClientCopyWithImpl<$Res> implements $ClientCopyWith<$Res> {
  _$ClientCopyWithImpl(this._value, this._then);

  final Client _value;
  // ignore: unused_field
  final $Res Function(Client) _then;

  @override
  $Res call({
    Object? clientId = freezed,
    Object? protocol = freezed,
    Object? id = freezed,
  }) {
    return _then(_value.copyWith(
      clientId: clientId == freezed
          ? _value.clientId
          : clientId // ignore: cast_nullable_to_non_nullable
              as String,
      protocol: protocol == freezed
          ? _value.protocol
          : protocol // ignore: cast_nullable_to_non_nullable
              as String,
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$ClientCopyWith<$Res> implements $ClientCopyWith<$Res> {
  factory _$ClientCopyWith(_Client value, $Res Function(_Client) then) =
      __$ClientCopyWithImpl<$Res>;
  @override
  $Res call({String clientId, String protocol, String id});
}

/// @nodoc
class __$ClientCopyWithImpl<$Res> extends _$ClientCopyWithImpl<$Res>
    implements _$ClientCopyWith<$Res> {
  __$ClientCopyWithImpl(_Client _value, $Res Function(_Client) _then)
      : super(_value, (v) => _then(v as _Client));

  @override
  _Client get _value => super._value as _Client;

  @override
  $Res call({
    Object? clientId = freezed,
    Object? protocol = freezed,
    Object? id = freezed,
  }) {
    return _then(_Client(
      clientId: clientId == freezed
          ? _value.clientId
          : clientId // ignore: cast_nullable_to_non_nullable
              as String,
      protocol: protocol == freezed
          ? _value.protocol
          : protocol // ignore: cast_nullable_to_non_nullable
              as String,
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Client implements _Client {
  const _$_Client(
      {required this.clientId, required this.protocol, required this.id});

  factory _$_Client.fromJson(Map<String, dynamic> json) =>
      _$$_ClientFromJson(json);

  @override
  final String clientId;
  @override
  final String protocol;
  @override
  final String id;

  @override
  String toString() {
    return 'Client(clientId: $clientId, protocol: $protocol, id: $id)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Client &&
            const DeepCollectionEquality().equals(other.clientId, clientId) &&
            const DeepCollectionEquality().equals(other.protocol, protocol) &&
            const DeepCollectionEquality().equals(other.id, id));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(clientId),
      const DeepCollectionEquality().hash(protocol),
      const DeepCollectionEquality().hash(id));

  @JsonKey(ignore: true)
  @override
  _$ClientCopyWith<_Client> get copyWith =>
      __$ClientCopyWithImpl<_Client>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ClientToJson(this);
  }
}

abstract class _Client implements Client {
  const factory _Client(
      {required String clientId,
      required String protocol,
      required String id}) = _$_Client;

  factory _Client.fromJson(Map<String, dynamic> json) = _$_Client.fromJson;

  @override
  String get clientId;
  @override
  String get protocol;
  @override
  String get id;
  @override
  @JsonKey(ignore: true)
  _$ClientCopyWith<_Client> get copyWith => throw _privateConstructorUsedError;
}

Clients _$ClientsFromJson(Map<String, dynamic> json) {
  return _Clients.fromJson(json);
}

/// @nodoc
class _$ClientsTearOff {
  const _$ClientsTearOff();

  _Clients call({required List<dynamic> clients, required int totalClients}) {
    return _Clients(
      clients: clients,
      totalClients: totalClients,
    );
  }

  Clients fromJson(Map<String, Object?> json) {
    return Clients.fromJson(json);
  }
}

/// @nodoc
const $Clients = _$ClientsTearOff();

/// @nodoc
mixin _$Clients {
  List<dynamic> get clients => throw _privateConstructorUsedError;
  int get totalClients => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ClientsCopyWith<Clients> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClientsCopyWith<$Res> {
  factory $ClientsCopyWith(Clients value, $Res Function(Clients) then) =
      _$ClientsCopyWithImpl<$Res>;
  $Res call({List<dynamic> clients, int totalClients});
}

/// @nodoc
class _$ClientsCopyWithImpl<$Res> implements $ClientsCopyWith<$Res> {
  _$ClientsCopyWithImpl(this._value, this._then);

  final Clients _value;
  // ignore: unused_field
  final $Res Function(Clients) _then;

  @override
  $Res call({
    Object? clients = freezed,
    Object? totalClients = freezed,
  }) {
    return _then(_value.copyWith(
      clients: clients == freezed
          ? _value.clients
          : clients // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
      totalClients: totalClients == freezed
          ? _value.totalClients
          : totalClients // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
abstract class _$ClientsCopyWith<$Res> implements $ClientsCopyWith<$Res> {
  factory _$ClientsCopyWith(_Clients value, $Res Function(_Clients) then) =
      __$ClientsCopyWithImpl<$Res>;
  @override
  $Res call({List<dynamic> clients, int totalClients});
}

/// @nodoc
class __$ClientsCopyWithImpl<$Res> extends _$ClientsCopyWithImpl<$Res>
    implements _$ClientsCopyWith<$Res> {
  __$ClientsCopyWithImpl(_Clients _value, $Res Function(_Clients) _then)
      : super(_value, (v) => _then(v as _Clients));

  @override
  _Clients get _value => super._value as _Clients;

  @override
  $Res call({
    Object? clients = freezed,
    Object? totalClients = freezed,
  }) {
    return _then(_Clients(
      clients: clients == freezed
          ? _value.clients
          : clients // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
      totalClients: totalClients == freezed
          ? _value.totalClients
          : totalClients // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Clients implements _Clients {
  const _$_Clients({required this.clients, required this.totalClients});

  factory _$_Clients.fromJson(Map<String, dynamic> json) =>
      _$$_ClientsFromJson(json);

  @override
  final List<dynamic> clients;
  @override
  final int totalClients;

  @override
  String toString() {
    return 'Clients(clients: $clients, totalClients: $totalClients)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Clients &&
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
  _$ClientsCopyWith<_Clients> get copyWith =>
      __$ClientsCopyWithImpl<_Clients>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ClientsToJson(this);
  }
}

abstract class _Clients implements Clients {
  const factory _Clients(
      {required List<dynamic> clients, required int totalClients}) = _$_Clients;

  factory _Clients.fromJson(Map<String, dynamic> json) = _$_Clients.fromJson;

  @override
  List<dynamic> get clients;
  @override
  int get totalClients;
  @override
  @JsonKey(ignore: true)
  _$ClientsCopyWith<_Clients> get copyWith =>
      throw _privateConstructorUsedError;
}
