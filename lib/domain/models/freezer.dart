import '/domain/enums/enums.dart';

class Freezer {
  final String? id;
  final FreezerType type;
  final String name;
  final String description;
  final String location;
  final double maxVolume; // max in liters - unit to freezers
  final double volume; // in liters
  final int maxPieces; // max number of pieces - unit to cold storage
  final int pieces; // number of pieces
  final DateTime createdAt;
  final DateTime? updatedAt;

  Freezer({
    this.id,
    required this.name,
    this.type = FreezerType.freezer,
    required this.description,
    required this.location,
    this.maxVolume = 0.0,
    this.volume = 0.0,
    this.maxPieces = 0,
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
    double? maxVolume,
    double? volume,
    int? maxPieces,
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
      maxVolume: maxVolume ?? this.maxVolume,
      volume: volume ?? this.volume,
      maxPieces: maxPieces ?? this.maxPieces,
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
    result.addAll({'maxVolume': maxVolume});
    result.addAll({'volume': volume});
    result.addAll({'maxPieces': maxPieces});
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
      maxVolume: map['maxVolume'].toDouble() as double,
      volume: map['volume'].toDouble() as double,
      maxPieces: map['maxPieces'].toInt() as int,
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
        ' maxVolume: $maxVolume,'
        ' volume: $volume,'
        ' maxPieces: $maxPieces,'
        ' pieces: $pieces,'
        ' createdAt: $createdAt,'
        ' updatedAt: $updatedAt)';
  }
}
