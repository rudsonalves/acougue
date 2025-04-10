import '/domain/enums/enums.dart';

class Freezer {
  final String? id;
  final FreezerType type;
  final String name;
  final String description;
  final String location;
  final double volume; // in liters - unit to freezers
  final int pieces; // number of pieces - unit to cold storage
  final DateTime createdAt;
  final DateTime? updatedAt;

  Freezer({
    this.id,
    required this.name,
    this.type = FreezerType.freezer,
    required this.description,
    required this.location,
    this.volume = 0.0,
    this.pieces = 0,
    DateTime? createdAt,
    this.updatedAt,
  }) : createdAt = createdAt ?? DateTime.now();

  Freezer copyWith({
    String? id,
    FreezerType? type,
    String? name,
    String? description,
    String? location,
    double? volume,
    int? pieces,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Freezer(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      description: description ?? this.description,
      location: location ?? this.location,
      volume: volume ?? this.volume,
      pieces: pieces ?? this.pieces,
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
    result.addAll({'type': type.name});
    result.addAll({'description': description});
    result.addAll({'location': location});
    result.addAll({'volume': volume});
    result.addAll({'pieces': pieces});
    result.addAll({'createdAt': createdAt.millisecondsSinceEpoch});
    if (updatedAt != null) {
      result.addAll({'updatedAt': updatedAt!.millisecondsSinceEpoch});
    }

    return result;
  }

  factory Freezer.fromMap(Map<String, dynamic> map) {
    return Freezer(
      id: map['id'] as String?,
      name: map['name'] as String,
      type: FreezerType.values.byName(map['type'] as String),
      description: map['description'] as String,
      location: map['location'] as String,
      volume: map['volume'].toDouble() as double,
      pieces: map['pieces'].toInt() as int,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
      updatedAt:
          map['updatedAt'] != null
              ? DateTime.fromMillisecondsSinceEpoch(map['updatedAt'] as int)
              : null,
    );
  }

  @override
  String toString() {
    return 'Freezer(id: $id,'
        ' name: $name,'
        ' type: ${type.name},'
        ' description: $description,'
        ' location: $location,'
        ' volume: $volume,'
        ' pieces: $pieces,'
        ' createdAt: $createdAt,'
        ' updatedAt: $updatedAt)';
  }
}
