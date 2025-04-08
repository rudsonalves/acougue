import 'dart:convert';

class ButcherShop {
  final String? id;
  final String name;
  final String description;
  final String addressId;
  final DateTime createdAt;
  final DateTime? updatedAt;

  ButcherShop({
    this.id,
    required this.name,
    required this.description,
    required this.addressId,
    DateTime? createdAt,
    this.updatedAt,
  }) : createdAt = createdAt ?? DateTime.now();

  ButcherShop copyWith({
    String? id,
    String? name,
    String? description,
    String? addressId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ButcherShop(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      addressId: addressId ?? this.addressId,
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
    result.addAll({'description': description});
    result.addAll({'addressId': addressId});
    result.addAll({'createdAt': createdAt.millisecondsSinceEpoch});
    if (updatedAt != null) {
      result.addAll({'updatedAt': updatedAt!.millisecondsSinceEpoch});
    }

    return result;
  }

  factory ButcherShop.fromMap(Map<String, dynamic> map) {
    return ButcherShop(
      id: map['id'] as String?,
      name: map['name'] as String,
      description: map['description'] as String,
      addressId: map['addressId'] as String,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
      updatedAt:
          map['updatedAt'] != null
              ? DateTime.fromMillisecondsSinceEpoch(map['updatedAt'] as int)
              : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ButcherShop.fromJson(String source) =>
      ButcherShop.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Butcher(id: $id, '
        'name: $name, '
        'description: $description, '
        'addressId: $addressId, '
        'createdAt: $createdAt, '
        'updatedAt: $updatedAt)';
  }
}
