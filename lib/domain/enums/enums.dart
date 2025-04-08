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
