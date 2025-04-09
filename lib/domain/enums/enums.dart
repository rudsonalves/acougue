// ignore_for_file: constant_identifier_names

import 'package:acougue/domain/enums/enums_base.dart';

enum AddressType implements LabeledEnum {
  residential('Residencial'),
  commercial('Comercial'),
  apartment('Apartamento'),
  others('Outros');

  @override
  final String label;

  const AddressType(this.label);
}

enum Positions implements LabeledEnum {
  admin('Administrador'),
  manager('Gerente'),
  employee('Funcionário'),
  others('Outros');

  @override
  final String label;

  const Positions(this.label);
}

enum BrStates implements LabeledEnum {
  AC('Acre'),
  AL('Alagoas'),
  AP('Amapá'),
  AM('Amazonas'),
  BA('Bahia'),
  CE('Ceará'),
  DF('Distrito Federal'),
  ES('Espírito Santo'),
  GO('Goiás'),
  MA('Maranhão'),
  MT('Mato Grosso'),
  MS('Mato Grosso do Sul'),
  MG('Minas Gerais'),
  PA('Pará'),
  PB('Paraíba'),
  PR('Paraná'),
  PE('Pernambuco'),
  PI('Piauí'),
  RJ('Rio de Janeiro'),
  RN('Rio Grande do Norte'),
  RS('Rio Grande do Sul'),
  RO('Rondônia'),
  RR('Roraima'),
  SC('Santa Catarina'),
  SP('São Paulo'),
  SE('Sergipe'),
  TO('Tocantins');

  @override
  final String label;

  const BrStates(this.label);
}
