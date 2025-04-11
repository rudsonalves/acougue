import 'package:flutter/material.dart';

import '/ui/features/home/registrations/freezers/view_models/edit_freezer_view_model.dart';
import '/utils/extensions.dart';
import '/routing/router.dart';
import '/ui/features/home/registrations/view_model/butcher_shop_view_model.dart';

class RegistrationsPage extends StatefulWidget {
  final ButcherShopViewModel butcherShopViewModel;
  final FreezersViewModel freezersViewModel;

  const RegistrationsPage({
    super.key,
    required this.butcherShopViewModel,
    required this.freezersViewModel,
  });

  @override
  State<RegistrationsPage> createState() => _RegistrationsPageState();
}

class _RegistrationsPageState extends State<RegistrationsPage> {
  late final ButcherShopViewModel _butcherShopViewModel;
  late final FreezersViewModel _freezersViewModel;

  @override
  void initState() {
    _butcherShopViewModel = widget.butcherShopViewModel;
    _freezersViewModel = widget.freezersViewModel;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final butcher = _butcherShopViewModel.butcherShop;
    final freezers = _freezersViewModel.freezersList;
    final address = _butcherShopViewModel.addresses[butcher.addressId];
    final fullAddress = address != null ? '\n${address.fullAddress}' : '';
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;

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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: width * .35,
                height: height * .25,
                child: InkWell(
                  onTap: _goToButcheRegistration,
                  child: Card(
                    margin: EdgeInsets.zero,
                    color: colorScheme.primaryContainer,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 12,
                      ),
                      child: SizedBox(
                        height: height * .23,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Center(
                              child: Text(
                                'Regisrto Açougue',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            Text(
                              butcher.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              '${butcher.description}\nDesde:'
                              ' ${butcher.createdAt.toBrString()}'
                              '$fullAddress}',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: width * .35,
                height: height * .25,
                child: InkWell(
                  onTap: _goToFreezersPage,
                  child: Card(
                    margin: EdgeInsets.zero,
                    color: colorScheme.primaryContainer,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 12,
                      ),
                      child: SizedBox(
                        height: height * .23,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Center(
                              child: Text(
                                'Câmeras/Freezers',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            Expanded(
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: freezers.length,
                                itemBuilder:
                                    (context, index) => ListTile(
                                      title: Text(freezers[index].name),
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              FilledButton.icon(
                onPressed: null,
                label: const Text('Registro dos Funcionários'),
              ),
              FilledButton.icon(
                onPressed: null,
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

  Future<void> _goToFreezersPage() async {
    await Navigator.pushNamed(context, Routes.freezers);
    setState(() {});
  }
}
