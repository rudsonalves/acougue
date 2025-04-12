import 'package:acougue/ui/core/ui/images/logo_image.dart';
import 'package:acougue/ui/features/home/widgets/center_text.dart';
import 'package:flutter/material.dart';

import '/domain/models/product.dart';
import '/domain/enums/enums.dart';
import '/ui/features/home/widgets/home_header_row.dart';
import '/utils/extensions.dart';
import '/routing/router.dart';
import '/ui/core/themes/dimens.dart';
import '/ui/core/themes/brightness_controller.dart';
import '/ui/features/home/home_view_model.dart';
import '/utils/provider.dart';

class HomePage extends StatefulWidget {
  final HomeViewModel homeViewModel;

  const HomePage({super.key, required this.homeViewModel});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final HomeViewModel _homeViewModel;

  bool sortOrder = true;

  @override
  void initState() {
    _homeViewModel = widget.homeViewModel;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final brightness = NotifierProvider.of<BrightnessController>(context);
    // final colorScheme = Theme.of(context).colorScheme;
    final dimens = Dimens.of(context);
    final producsList = _homeViewModel.sortByExpirationDate(sortOrder);
    final now = DateTime.now();
    final nextWeek = now.add(const Duration(days: 7));
    final nextMonth = now.add(const Duration(days: 30));
    final next3Month = now.add(const Duration(days: 90));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sabor da Morte'),
        centerTitle: true,
        elevation: 5,
        actions: [
          IconButton(
            onPressed: brightness.toggle,
            icon: ListenableBuilder(
              listenable: brightness,
              builder: (context, _) {
                return Icon(
                  brightness.isDark ? Icons.dark_mode : Icons.light_mode,
                );
              },
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              // decoration: BoxDecoration(color: Colors.blue),
              child: Column(
                children: [LogoImage(radius: 50), Text('Sabor da Morte')],
              ),
            ),
            ListTile(
              title: const Text('Registros'),
              leading: const Icon(Icons.list),
              onTap: () {
                _goToRegistrationsPage();
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Adicionar Produto'),
              leading: const Icon(Icons.add),
              onTap: () {
                _goToProductsInput();
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Empregados'),
              leading: const Icon(Icons.people),
              onTap: () {
                _goToEmployees();
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToProductsInput,
        icon: const Icon(Icons.add),
        label: const Text('Adicionar Produto'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: dimens.paddingScreenHorizontal / 2,
          vertical: dimens.paddingScreenVertical,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: dimens.spacingVertical,
          children: [
            OverflowBar(
              alignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton.icon(
                  onPressed: _goToRegistrationsPage,
                  icon: const Icon(Icons.list),
                  label: const Text('Registros'),
                ),
                ElevatedButton.icon(
                  onPressed: _goToEmployees,
                  icon: const Icon(Icons.people),
                  label: const Text('Empregados'),
                ),
              ],
            ),
            HomeHeaderRow(callBack: _revertOrder),
            ListView.builder(
              shrinkWrap: true,
              itemCount: producsList.length,
              itemBuilder: (context, index) {
                final product = producsList[index];
                String title = '';
                switch (product.cutType) {
                  case CutsType.halfCarcass:
                    title = CutsType.halfCarcass.label;
                    break;
                  case CutsType.primalCuts:
                    title = product.primalCut!.label;
                    break;
                  case CutsType.retailCuts:
                    title = product.retailCuts!.label;
                }

                Color? color;

                if (product.expirationDate.isBefore(nextWeek)) {
                  color = Colors.redAccent;
                } else if (product.expirationDate.isBefore(nextMonth)) {
                  color = Colors.orange;
                } else if (product.expirationDate.isBefore(next3Month)) {
                  color = Colors.yellow;
                }

                return InkWell(
                  onTap: () => _goToEdit(product),
                  borderRadius: dimens.borderRadius,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: ListTile(
                          textColor: color,
                          title: Text(
                            '$title (${product.weight.toStringAsFixed(1)} kg)',
                          ),
                          subtitle: Text(product.comments ?? ''),
                        ),
                      ),
                      CenterText(
                        color: color,
                        text: product.inputDate.toBrString(),
                      ),
                      CenterText(
                        color: color,
                        text: product.expirationDate.toBrString(),
                      ),
                      CenterText(
                        color: color,
                        text:
                            _homeViewModel
                                .getUserInfo(product.employeeId)
                                ?.name ??
                            '',
                      ),
                      CenterText(
                        color: color,
                        text:
                            _homeViewModel
                                .getFreezer(product.freezerId)
                                ?.name ??
                            '',
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _revertOrder() {
    setState(() {
      sortOrder = !sortOrder;
    });
  }

  Future<void> _goToEmployees() async {
    await Navigator.pushNamed(context, Routes.employees);
    setState(() {});
  }

  Future<void> _goToRegistrationsPage() async {
    await Navigator.pushNamed(context, Routes.registrations);
    setState(() {});
  }

  Future<void> _goToProductsInput() async {
    await Navigator.pushNamed(context, Routes.editProduct);
    setState(() {});
  }

  Future<void> _goToEdit(Product product) async {
    await Navigator.pushNamed(
      context,
      Routes.editProduct,
      arguments: {'productId': product.id},
    );
    setState(() {});
  }
}
