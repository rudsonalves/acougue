import 'dart:convert';

import '/domain/enums/enums.dart';
import '/domain/enums/enums_base.dart';

class Address {
  final String? id;
  final AddressType type;
  final String cep;
  final String street;
  final String number;
  final String? complement;
  final String neighborhood;
  final String city;
  final String state;

  Address({
    this.id,
    required this.type,
    required this.cep,
    required this.street,
    required this.number,
    this.complement,
    required this.neighborhood,
    required this.city,
    required this.state,
  });

  Address copyWith({
    String? id,
    AddressType? type,
    String? cep,
    String? street,
    String? number,
    String? complement,
    String? neighborhood,
    String? city,
    String? state,
  }) {
    return Address(
      id: id ?? this.id,
      type: type ?? this.type,
      cep: cep ?? this.cep,
      street: street ?? this.street,
      number: number ?? this.number,
      complement: complement ?? this.complement,
      neighborhood: neighborhood ?? this.neighborhood,
      city: city ?? this.city,
      state: state ?? this.state,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'id': id});
    }
    result.addAll({'type': type.name});
    result.addAll({'cep': cep});
    result.addAll({'street': street});
    result.addAll({'number': number});
    if (complement != null) {
      result.addAll({'complement': complement});
    }
    result.addAll({'neighborhood': neighborhood});
    result.addAll({'city': city});
    result.addAll({'state': state});

    return result;
  }

  factory Address.fromMap(Map<String, dynamic> map) {
    return Address(
      id: map['id'],
      type: AddressType.values.fromName(map['type'] as String)!,
      cep: map['cep'],
      street: map['street'],
      number: map['number'],
      complement: map['complement'],
      neighborhood: map['neighborhood'],
      city: map['city'],
      state: map['state'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Address.fromJson(String source) =>
      Address.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Address(id: $id,'
        ' type: $type,'
        ' cep: $cep,'
        ' street: $street,'
        ' number: $number,'
        ' complement: $complement,'
        ' neighborhood: $neighborhood,'
        ' city: $city,'
        ' state: $state)';
  }
}
