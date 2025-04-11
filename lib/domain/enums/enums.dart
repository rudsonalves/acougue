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

enum VolumetricUnit implements LabeledEnum {
  liters('l'),
  cubicMeters('m³'),
  pieces('peças');

  @override
  final String label;

  const VolumetricUnit(this.label);
}

enum FreezerType implements LabeledEnum {
  coldStorage('Câmera Frigorífica'),
  freezer('Freezer');

  @override
  final String label;

  const FreezerType(this.label);
}

enum CutsType implements LabeledEnum {
  halfCarcass('Meias Carcaças'),
  primalCuts('Cortes Primários'),
  retailCuts('Cortes Comerciais');

  @override
  final String label;

  const CutsType(this.label);
}

enum PrimalCuts implements LabeledEnum {
  dianteiro('Dianteiro'),
  traseiro('Traseiro'),
  costilhar('Costilhar');

  @override
  final String label;

  const PrimalCuts(this.label);
}

enum HalfCarcass { dianteiro, traseiro, costilhar }

enum Dianteiro {
  Acem,
  Paleta,
  Musculo,
  Pescoco,
  Peito,
  PeitoComOsso,
  PeitoSemOsso,
  Cupim,
  PontaDeAgulha,
}

enum Traseiro {
  CoxaoMole,
  CoxaoDuro,
  Patinho,
  Lagarto,
  Alcatra,
  Maminha,
  Picanha,
  FileMignon,
  Fraldinha,
  Painho,
}

enum Costilhar { Costela, CostelaRipa, Fraldinha, PeitoBovino }

enum RetailCuts implements LabeledEnum {
  Acem('Acém'),
  Paleta('Paleta'),
  Musculo('Músculo'),
  Pescoco('Pescoço'),
  Peito('Peito'),
  PeitoComOsso('Peito com osso'),
  PeitoSemOsso('Peito sem osso'),
  Cupim('Cupim'),
  PontaDeAgulha('Ponta de agulha'),
  CoxaoMole('Coxão mole'),
  CoxaoDuro('Coxão duro'),
  Patinho('Patinho'),
  Lagarto('Lagarto'),
  Alcatra('Alcatra'),
  Maminha('Maminha'),
  Picanha('Picanha'),
  Contrafile('Contrafilé'),
  FileMignon('Filé mignon'),
  Fraldinha('Fraldinha'),
  Painho('Paínho'),
  Costela('Costela'),
  CostelaRipa('Costela ripa'),
  PeitoBovino('Peito bovino');

  @override
  final String label;

  const RetailCuts(this.label);
}
