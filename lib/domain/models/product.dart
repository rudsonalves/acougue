import '/domain/enums/enums.dart';

class Product {
  final String? id;
  final String name;
  final PrimalCuts? primalCut;
  final RetailCuts? retailCuts;
  final double weight;
  final DateTime inputDate;
  final DateTime expirationDate;

  Product({
    this.id,
    required this.name,
    this.primalCut,
    this.retailCuts,
    required this.weight,
    required this.inputDate,
    required this.expirationDate,
  });

  Product copyWith({
    String? id,
    String? name,
    PrimalCuts? primalCut,
    RetailCuts? retailCuts,
    double? weight,
    DateTime? inputDate,
    DateTime? expirationDate,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      primalCut: primalCut ?? this.primalCut,
      retailCuts: retailCuts ?? this.retailCuts,
      weight: weight ?? this.weight,
      inputDate: inputDate ?? this.inputDate,
      expirationDate: expirationDate ?? this.expirationDate,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'id': id});
    }
    result.addAll({'name': name});
    if (primalCut != null) {
      result.addAll({'primalCut': primalCut?.name});
    }
    if (retailCuts != null) {
      result.addAll({'retailCuts': retailCuts?.name});
    }
    result.addAll({'weight': weight});
    result.addAll({'inputDate': inputDate.millisecondsSinceEpoch});
    result.addAll({'expirationDate': expirationDate.millisecondsSinceEpoch});

    return result;
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'],
      name: map['name'] ?? '',
      primalCut:
          map['primalCut'] != null
              ? PrimalCuts.values.byName(map['primalCut'] as String)
              : null,
      retailCuts:
          map['retailCuts'] != null
              ? RetailCuts.values.byName(map['retailCuts'] as String)
              : null,
      weight: map['weight']?.toDouble() ?? 0.0,
      inputDate: DateTime.fromMillisecondsSinceEpoch(map['inputDate'] as int),
      expirationDate: DateTime.fromMillisecondsSinceEpoch(
        map['expirationDate'] as int,
      ),
    );
  }

  @override
  String toString() {
    return 'Product(id: $id,'
        ' name: $name,'
        ' primalCut: $primalCut,'
        ' retailCuts: $retailCuts,'
        ' weight: $weight,'
        ' inputDate: $inputDate,'
        ' expirationDate: $expirationDate)';
  }
}
