// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'moor_database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class UserData extends DataClass implements Insertable<UserData> {
  final String id;
  final String nickname;
  final String email;
  final String image;
  final int type;
  UserData(
      {@required this.id,
      @required this.nickname,
      @required this.email,
      @required this.image,
      @required this.type});
  factory UserData.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    final intType = db.typeSystem.forDartType<int>();
    return UserData(
      id: stringType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      nickname: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}nickname']),
      email:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}email']),
      image:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}image']),
      type: intType.mapFromDatabaseResponse(data['${effectivePrefix}type']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<String>(id);
    }
    if (!nullToAbsent || nickname != null) {
      map['nickname'] = Variable<String>(nickname);
    }
    if (!nullToAbsent || email != null) {
      map['email'] = Variable<String>(email);
    }
    if (!nullToAbsent || image != null) {
      map['image'] = Variable<String>(image);
    }
    if (!nullToAbsent || type != null) {
      map['type'] = Variable<int>(type);
    }
    return map;
  }

  UserCompanion toCompanion(bool nullToAbsent) {
    return UserCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      nickname: nickname == null && nullToAbsent
          ? const Value.absent()
          : Value(nickname),
      email:
          email == null && nullToAbsent ? const Value.absent() : Value(email),
      image:
          image == null && nullToAbsent ? const Value.absent() : Value(image),
      type: type == null && nullToAbsent ? const Value.absent() : Value(type),
    );
  }

  factory UserData.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return UserData(
      id: serializer.fromJson<String>(json['id']),
      nickname: serializer.fromJson<String>(json['nickname']),
      email: serializer.fromJson<String>(json['email']),
      image: serializer.fromJson<String>(json['image']),
      type: serializer.fromJson<int>(json['type']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'nickname': serializer.toJson<String>(nickname),
      'email': serializer.toJson<String>(email),
      'image': serializer.toJson<String>(image),
      'type': serializer.toJson<int>(type),
    };
  }

  UserData copyWith(
          {String id, String nickname, String email, String image, int type}) =>
      UserData(
        id: id ?? this.id,
        nickname: nickname ?? this.nickname,
        email: email ?? this.email,
        image: image ?? this.image,
        type: type ?? this.type,
      );
  @override
  String toString() {
    return (StringBuffer('UserData(')
          ..write('id: $id, ')
          ..write('nickname: $nickname, ')
          ..write('email: $email, ')
          ..write('image: $image, ')
          ..write('type: $type')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(nickname.hashCode,
          $mrjc(email.hashCode, $mrjc(image.hashCode, type.hashCode)))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is UserData &&
          other.id == this.id &&
          other.nickname == this.nickname &&
          other.email == this.email &&
          other.image == this.image &&
          other.type == this.type);
}

class UserCompanion extends UpdateCompanion<UserData> {
  final Value<String> id;
  final Value<String> nickname;
  final Value<String> email;
  final Value<String> image;
  final Value<int> type;
  const UserCompanion({
    this.id = const Value.absent(),
    this.nickname = const Value.absent(),
    this.email = const Value.absent(),
    this.image = const Value.absent(),
    this.type = const Value.absent(),
  });
  UserCompanion.insert({
    @required String id,
    @required String nickname,
    @required String email,
    @required String image,
    @required int type,
  })  : id = Value(id),
        nickname = Value(nickname),
        email = Value(email),
        image = Value(image),
        type = Value(type);
  static Insertable<UserData> custom({
    Expression<String> id,
    Expression<String> nickname,
    Expression<String> email,
    Expression<String> image,
    Expression<int> type,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nickname != null) 'nickname': nickname,
      if (email != null) 'email': email,
      if (image != null) 'image': image,
      if (type != null) 'type': type,
    });
  }

  UserCompanion copyWith(
      {Value<String> id,
      Value<String> nickname,
      Value<String> email,
      Value<String> image,
      Value<int> type}) {
    return UserCompanion(
      id: id ?? this.id,
      nickname: nickname ?? this.nickname,
      email: email ?? this.email,
      image: image ?? this.image,
      type: type ?? this.type,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (nickname.present) {
      map['nickname'] = Variable<String>(nickname.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (image.present) {
      map['image'] = Variable<String>(image.value);
    }
    if (type.present) {
      map['type'] = Variable<int>(type.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserCompanion(')
          ..write('id: $id, ')
          ..write('nickname: $nickname, ')
          ..write('email: $email, ')
          ..write('image: $image, ')
          ..write('type: $type')
          ..write(')'))
        .toString();
  }
}

class $UserTable extends User with TableInfo<$UserTable, UserData> {
  final GeneratedDatabase _db;
  final String _alias;
  $UserTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedTextColumn _id;
  @override
  GeneratedTextColumn get id => _id ??= _constructId();
  GeneratedTextColumn _constructId() {
    return GeneratedTextColumn(
      'id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _nicknameMeta = const VerificationMeta('nickname');
  GeneratedTextColumn _nickname;
  @override
  GeneratedTextColumn get nickname => _nickname ??= _constructNickname();
  GeneratedTextColumn _constructNickname() {
    return GeneratedTextColumn(
      'nickname',
      $tableName,
      false,
    );
  }

  final VerificationMeta _emailMeta = const VerificationMeta('email');
  GeneratedTextColumn _email;
  @override
  GeneratedTextColumn get email => _email ??= _constructEmail();
  GeneratedTextColumn _constructEmail() {
    return GeneratedTextColumn(
      'email',
      $tableName,
      false,
    );
  }

  final VerificationMeta _imageMeta = const VerificationMeta('image');
  GeneratedTextColumn _image;
  @override
  GeneratedTextColumn get image => _image ??= _constructImage();
  GeneratedTextColumn _constructImage() {
    return GeneratedTextColumn(
      'image',
      $tableName,
      false,
    );
  }

  final VerificationMeta _typeMeta = const VerificationMeta('type');
  GeneratedIntColumn _type;
  @override
  GeneratedIntColumn get type => _type ??= _constructType();
  GeneratedIntColumn _constructType() {
    return GeneratedIntColumn(
      'type',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [id, nickname, email, image, type];
  @override
  $UserTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'user';
  @override
  final String actualTableName = 'user';
  @override
  VerificationContext validateIntegrity(Insertable<UserData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('nickname')) {
      context.handle(_nicknameMeta,
          nickname.isAcceptableOrUnknown(data['nickname'], _nicknameMeta));
    } else if (isInserting) {
      context.missing(_nicknameMeta);
    }
    if (data.containsKey('email')) {
      context.handle(
          _emailMeta, email.isAcceptableOrUnknown(data['email'], _emailMeta));
    } else if (isInserting) {
      context.missing(_emailMeta);
    }
    if (data.containsKey('image')) {
      context.handle(
          _imageMeta, image.isAcceptableOrUnknown(data['image'], _imageMeta));
    } else if (isInserting) {
      context.missing(_imageMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type'], _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UserData map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return UserData.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $UserTable createAlias(String alias) {
    return $UserTable(_db, alias);
  }
}

class MessageData extends DataClass implements Insertable<MessageData> {
  final String id;
  final String idFrom;
  final String idTo;
  final String content;
  final int timestamp;
  final int type;
  final String chatId;
  MessageData(
      {@required this.id,
      @required this.idFrom,
      @required this.idTo,
      @required this.content,
      @required this.timestamp,
      @required this.type,
      @required this.chatId});
  factory MessageData.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    final intType = db.typeSystem.forDartType<int>();
    return MessageData(
      id: stringType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      idFrom:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}id_from']),
      idTo: stringType.mapFromDatabaseResponse(data['${effectivePrefix}id_to']),
      content:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}content']),
      timestamp:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}timestamp']),
      type: intType.mapFromDatabaseResponse(data['${effectivePrefix}type']),
      chatId:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}chat_id']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<String>(id);
    }
    if (!nullToAbsent || idFrom != null) {
      map['id_from'] = Variable<String>(idFrom);
    }
    if (!nullToAbsent || idTo != null) {
      map['id_to'] = Variable<String>(idTo);
    }
    if (!nullToAbsent || content != null) {
      map['content'] = Variable<String>(content);
    }
    if (!nullToAbsent || timestamp != null) {
      map['timestamp'] = Variable<int>(timestamp);
    }
    if (!nullToAbsent || type != null) {
      map['type'] = Variable<int>(type);
    }
    if (!nullToAbsent || chatId != null) {
      map['chat_id'] = Variable<String>(chatId);
    }
    return map;
  }

  MessageCompanion toCompanion(bool nullToAbsent) {
    return MessageCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      idFrom:
          idFrom == null && nullToAbsent ? const Value.absent() : Value(idFrom),
      idTo: idTo == null && nullToAbsent ? const Value.absent() : Value(idTo),
      content: content == null && nullToAbsent
          ? const Value.absent()
          : Value(content),
      timestamp: timestamp == null && nullToAbsent
          ? const Value.absent()
          : Value(timestamp),
      type: type == null && nullToAbsent ? const Value.absent() : Value(type),
      chatId:
          chatId == null && nullToAbsent ? const Value.absent() : Value(chatId),
    );
  }

  factory MessageData.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return MessageData(
      id: serializer.fromJson<String>(json['id']),
      idFrom: serializer.fromJson<String>(json['idFrom']),
      idTo: serializer.fromJson<String>(json['idTo']),
      content: serializer.fromJson<String>(json['content']),
      timestamp: serializer.fromJson<int>(json['timestamp']),
      type: serializer.fromJson<int>(json['type']),
      chatId: serializer.fromJson<String>(json['chatId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'idFrom': serializer.toJson<String>(idFrom),
      'idTo': serializer.toJson<String>(idTo),
      'content': serializer.toJson<String>(content),
      'timestamp': serializer.toJson<int>(timestamp),
      'type': serializer.toJson<int>(type),
      'chatId': serializer.toJson<String>(chatId),
    };
  }

  MessageData copyWith(
          {String id,
          String idFrom,
          String idTo,
          String content,
          int timestamp,
          int type,
          String chatId}) =>
      MessageData(
        id: id ?? this.id,
        idFrom: idFrom ?? this.idFrom,
        idTo: idTo ?? this.idTo,
        content: content ?? this.content,
        timestamp: timestamp ?? this.timestamp,
        type: type ?? this.type,
        chatId: chatId ?? this.chatId,
      );
  @override
  String toString() {
    return (StringBuffer('MessageData(')
          ..write('id: $id, ')
          ..write('idFrom: $idFrom, ')
          ..write('idTo: $idTo, ')
          ..write('content: $content, ')
          ..write('timestamp: $timestamp, ')
          ..write('type: $type, ')
          ..write('chatId: $chatId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          idFrom.hashCode,
          $mrjc(
              idTo.hashCode,
              $mrjc(
                  content.hashCode,
                  $mrjc(timestamp.hashCode,
                      $mrjc(type.hashCode, chatId.hashCode)))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is MessageData &&
          other.id == this.id &&
          other.idFrom == this.idFrom &&
          other.idTo == this.idTo &&
          other.content == this.content &&
          other.timestamp == this.timestamp &&
          other.type == this.type &&
          other.chatId == this.chatId);
}

class MessageCompanion extends UpdateCompanion<MessageData> {
  final Value<String> id;
  final Value<String> idFrom;
  final Value<String> idTo;
  final Value<String> content;
  final Value<int> timestamp;
  final Value<int> type;
  final Value<String> chatId;
  const MessageCompanion({
    this.id = const Value.absent(),
    this.idFrom = const Value.absent(),
    this.idTo = const Value.absent(),
    this.content = const Value.absent(),
    this.timestamp = const Value.absent(),
    this.type = const Value.absent(),
    this.chatId = const Value.absent(),
  });
  MessageCompanion.insert({
    @required String id,
    @required String idFrom,
    @required String idTo,
    @required String content,
    @required int timestamp,
    @required int type,
    @required String chatId,
  })  : id = Value(id),
        idFrom = Value(idFrom),
        idTo = Value(idTo),
        content = Value(content),
        timestamp = Value(timestamp),
        type = Value(type),
        chatId = Value(chatId);
  static Insertable<MessageData> custom({
    Expression<String> id,
    Expression<String> idFrom,
    Expression<String> idTo,
    Expression<String> content,
    Expression<int> timestamp,
    Expression<int> type,
    Expression<String> chatId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (idFrom != null) 'id_from': idFrom,
      if (idTo != null) 'id_to': idTo,
      if (content != null) 'content': content,
      if (timestamp != null) 'timestamp': timestamp,
      if (type != null) 'type': type,
      if (chatId != null) 'chat_id': chatId,
    });
  }

  MessageCompanion copyWith(
      {Value<String> id,
      Value<String> idFrom,
      Value<String> idTo,
      Value<String> content,
      Value<int> timestamp,
      Value<int> type,
      Value<String> chatId}) {
    return MessageCompanion(
      id: id ?? this.id,
      idFrom: idFrom ?? this.idFrom,
      idTo: idTo ?? this.idTo,
      content: content ?? this.content,
      timestamp: timestamp ?? this.timestamp,
      type: type ?? this.type,
      chatId: chatId ?? this.chatId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (idFrom.present) {
      map['id_from'] = Variable<String>(idFrom.value);
    }
    if (idTo.present) {
      map['id_to'] = Variable<String>(idTo.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (timestamp.present) {
      map['timestamp'] = Variable<int>(timestamp.value);
    }
    if (type.present) {
      map['type'] = Variable<int>(type.value);
    }
    if (chatId.present) {
      map['chat_id'] = Variable<String>(chatId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MessageCompanion(')
          ..write('id: $id, ')
          ..write('idFrom: $idFrom, ')
          ..write('idTo: $idTo, ')
          ..write('content: $content, ')
          ..write('timestamp: $timestamp, ')
          ..write('type: $type, ')
          ..write('chatId: $chatId')
          ..write(')'))
        .toString();
  }
}

class $MessageTable extends Message with TableInfo<$MessageTable, MessageData> {
  final GeneratedDatabase _db;
  final String _alias;
  $MessageTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedTextColumn _id;
  @override
  GeneratedTextColumn get id => _id ??= _constructId();
  GeneratedTextColumn _constructId() {
    return GeneratedTextColumn(
      'id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _idFromMeta = const VerificationMeta('idFrom');
  GeneratedTextColumn _idFrom;
  @override
  GeneratedTextColumn get idFrom => _idFrom ??= _constructIdFrom();
  GeneratedTextColumn _constructIdFrom() {
    return GeneratedTextColumn(
      'id_from',
      $tableName,
      false,
    );
  }

  final VerificationMeta _idToMeta = const VerificationMeta('idTo');
  GeneratedTextColumn _idTo;
  @override
  GeneratedTextColumn get idTo => _idTo ??= _constructIdTo();
  GeneratedTextColumn _constructIdTo() {
    return GeneratedTextColumn(
      'id_to',
      $tableName,
      false,
    );
  }

  final VerificationMeta _contentMeta = const VerificationMeta('content');
  GeneratedTextColumn _content;
  @override
  GeneratedTextColumn get content => _content ??= _constructContent();
  GeneratedTextColumn _constructContent() {
    return GeneratedTextColumn(
      'content',
      $tableName,
      false,
    );
  }

  final VerificationMeta _timestampMeta = const VerificationMeta('timestamp');
  GeneratedIntColumn _timestamp;
  @override
  GeneratedIntColumn get timestamp => _timestamp ??= _constructTimestamp();
  GeneratedIntColumn _constructTimestamp() {
    return GeneratedIntColumn(
      'timestamp',
      $tableName,
      false,
    );
  }

  final VerificationMeta _typeMeta = const VerificationMeta('type');
  GeneratedIntColumn _type;
  @override
  GeneratedIntColumn get type => _type ??= _constructType();
  GeneratedIntColumn _constructType() {
    return GeneratedIntColumn(
      'type',
      $tableName,
      false,
    );
  }

  final VerificationMeta _chatIdMeta = const VerificationMeta('chatId');
  GeneratedTextColumn _chatId;
  @override
  GeneratedTextColumn get chatId => _chatId ??= _constructChatId();
  GeneratedTextColumn _constructChatId() {
    return GeneratedTextColumn(
      'chat_id',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns =>
      [id, idFrom, idTo, content, timestamp, type, chatId];
  @override
  $MessageTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'message';
  @override
  final String actualTableName = 'message';
  @override
  VerificationContext validateIntegrity(Insertable<MessageData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('id_from')) {
      context.handle(_idFromMeta,
          idFrom.isAcceptableOrUnknown(data['id_from'], _idFromMeta));
    } else if (isInserting) {
      context.missing(_idFromMeta);
    }
    if (data.containsKey('id_to')) {
      context.handle(
          _idToMeta, idTo.isAcceptableOrUnknown(data['id_to'], _idToMeta));
    } else if (isInserting) {
      context.missing(_idToMeta);
    }
    if (data.containsKey('content')) {
      context.handle(_contentMeta,
          content.isAcceptableOrUnknown(data['content'], _contentMeta));
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    if (data.containsKey('timestamp')) {
      context.handle(_timestampMeta,
          timestamp.isAcceptableOrUnknown(data['timestamp'], _timestampMeta));
    } else if (isInserting) {
      context.missing(_timestampMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type'], _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('chat_id')) {
      context.handle(_chatIdMeta,
          chatId.isAcceptableOrUnknown(data['chat_id'], _chatIdMeta));
    } else if (isInserting) {
      context.missing(_chatIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MessageData map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return MessageData.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $MessageTable createAlias(String alias) {
    return $MessageTable(_db, alias);
  }
}

abstract class _$AppDataBase extends GeneratedDatabase {
  _$AppDataBase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  $UserTable _user;
  $UserTable get user => _user ??= $UserTable(this);
  $MessageTable _message;
  $MessageTable get message => _message ??= $MessageTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [user, message];
}
