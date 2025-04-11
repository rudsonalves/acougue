import '/domain/enums/enums.dart';

class Product {
  final String? id;
  final CutsType cutType;
  final PrimalCuts? primalCut;
  final RetailCuts? retailCuts;
  final String? comments;
  final double weight;
  final String freezerId;
  final String employeeId;
  final DateTime inputDate;
  final DateTime expirationDate;

  Product({
    this.id,
    required this.cutType,
    this.primalCut,
    this.retailCuts,
    required this.comments,
    required this.freezerId,
    required this.employeeId,
    required this.weight,
    required this.inputDate,
    required this.expirationDate,
  });

  Product copyWith({
    String? id,
    String? name,
    CutsType? cutType,
    PrimalCuts? primalCut,
    RetailCuts? retailCuts,
    String? comments,
    String? freezerId,
    String? employeeId,
    double? weight,
    DateTime? inputDate,
    DateTime? expirationDate,
  }) {
    return Product(
      id: id ?? this.id,
      cutType: cutType ?? this.cutType,
      primalCut: primalCut ?? this.primalCut,
      retailCuts: retailCuts ?? this.retailCuts,
      comments: comments ?? this.comments,
      freezerId: freezerId ?? this.freezerId,
      employeeId: employeeId ?? this.employeeId,
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
    result.addAll({'cutType': cutType.name});
    if (primalCut != null) {
      result.addAll({'primalCut': primalCut?.name});
    }
    if (retailCuts != null) {
      result.addAll({'retailCuts': retailCuts?.name});
    }
    result.addAll({'comments': comments});
    result.addAll({'freezerId': freezerId});
    result.addAll({'employeeId': employeeId});
    result.addAll({'weight': weight});
    result.addAll({'inputDate': inputDate.millisecondsSinceEpoch});
    result.addAll({'expirationDate': expirationDate.millisecondsSinceEpoch});

    return result;
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'] as String?,
      cutType: CutsType.values.byName(map['cutType'] as String),
      primalCut:
          map['primalCut'] != null
              ? PrimalCuts.values.byName(map['primalCut'] as String)
              : null,
      retailCuts:
          map['retailCuts'] != null
              ? RetailCuts.values.byName(map['retailCuts'] as String)
              : null,
      comments: map['comments'] as String,
      freezerId: map['freezerId'] as String,
      employeeId: map['employeeId'] as String,
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
        ' cutType: ${cutType.name},'
        ' primalCut: ${primalCut?.name},'
        ' retailCuts: ${retailCuts?.name},'
        ' comments: $comments,'
        ' freezerId: $freezerId,'
        ' employeeId: $employeeId,'
        ' weight: $weight,'
        ' inputDate: $inputDate,'
        ' expirationDate: $expirationDate)';
  }
}
