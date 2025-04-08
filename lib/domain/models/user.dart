import 'dart:convert';

import 'package:acougue/domain/enums/enums.dart';

class User {
  final String? id;
  final String name;
  final String? password;
  final String addressId;
  final String document;
  final String contact;
  final Positions position;
  final DateTime createdAt;
  final DateTime? updatedAt;

  User({
    this.id,
    required this.name,
    this.password,
    required this.addressId,
    required this.document,
    required this.contact,
    this.position = Positions.employee,
    DateTime? createdAt,
    this.updatedAt,
  }) : createdAt = createdAt ?? DateTime.now();

  User copyWith({
    String? id,
    String? name,
    String? password,
    String? addressId,
    String? document,
    String? contact,
    Positions? position,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      password: password ?? this.password,
      addressId: addressId ?? this.addressId,
      document: document ?? this.document,
      contact: contact ?? this.contact,
      position: position ?? this.position,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'id': id});
    }
    result.addAll({'name': name});
    result.addAll({'password': password});
    result.addAll({'addressId': addressId});
    result.addAll({'document': document});
    result.addAll({'contact': contact});
    result.addAll({'position': position.name});
    result.addAll({'createdAt': createdAt.millisecondsSinceEpoch});
    if (updatedAt != null) {
      result.addAll({'updatedAt': updatedAt!.millisecondsSinceEpoch});
    }

    return result;
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] as String?,
      name: map['name'] as String,
      password: map['password'] as String?,
      addressId: map['addressId'] as String,
      document: map['document'] as String,
      contact: map['contact'] as String,
      position: Positions.values.byName(map['position'] as String),
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
      updatedAt:
          map['updatedAt'] != null
              ? DateTime.fromMillisecondsSinceEpoch(map['updatedAt'] as int)
              : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  @override
  String toString() {
    return 'User(id: $id,'
        ' name: $name,'
        ' password: $password,'
        ' addressId: $addressId,'
        ' document: $document,'
        ' contact: $contact,'
        ' position: $position,'
        ' createdAt: $createdAt,'
        ' updatedAt: $updatedAt)';
  }
}
