import 'package:acougue/utils/extensions.dart';
import 'package:flutter/material.dart';

import 'package:acougue/routing/router.dart';
import 'package:acougue/ui/core/themes/dimens.dart';
import 'package:acougue/ui/features/home/registrations/view_model/butcher_shop_view_model.dart';

class RegistrationsPage extends StatefulWidget {
  final ButcherShopViewModel butcherShopViewModel;

  const RegistrationsPage({super.key, required this.butcherShopViewModel});

  @override
  State<RegistrationsPage> createState() => _RegistrationsPageState();
}

class _RegistrationsPageState extends State<RegistrationsPage> {
  late final ButcherShopViewModel _butcherShopViewModel;

  @override
  void initState() {
    _butcherShopViewModel = widget.butcherShopViewModel;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final dimens = Dimens.of(context);
    final butcher = _butcherShopViewModel.butcherShop;
    final address = _butcherShopViewModel.addresses[butcher.addressId];
    final fullAddress = address != null ? '\n${address.fullAddress}' : '';
    final width = MediaQuery.sizeOf(context).width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Registros'),
        centerTitle: true,
        elevation: 5,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                spacing: Dimens.paddingVertical,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: width * .35,
                    child: Card(
                      color: colorScheme.primaryContainer,
                      child: Padding(
                        padding: const EdgeInsets.all(Dimens.paddingAll / 2),
                        child: Column(
                          children: [
                            ListTile(
                              title: Text(butcher.name),
                              subtitle: Text(
                                '${butcher.description}\nDesde:'
                                ' ${butcher.createdAt.toBrString()}'
                                '$fullAddress}',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  FilledButton.icon(
                    onPressed: _goToButcheRegistration,
                    label: const Text('Registro do Açougue'),
                  ),
                ],
              ),
              FilledButton.icon(
                onPressed: () {},
                label: const Text('Registro dos Freezers'),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              FilledButton.icon(
                onPressed: () {},
                label: const Text('Registro dos Funcionários'),
              ),
              FilledButton.icon(
                onPressed: () {},
                label: const Text('Registro das Validades'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _goToButcheRegistration() async {
    await Navigator.pushNamed(context, Routes.butcherShop);
    setState(() {});
  }
}
