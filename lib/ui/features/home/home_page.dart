import 'package:flutter/material.dart';

import 'ui/app_drawer.dart';
import 'ui/buttons_header.dart';
import 'ui/center_text.dart';
import '/domain/models/product.dart';
import '/domain/enums/enums.dart';
import 'ui/home_header_row.dart';
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
  late final DateTime _nextWeek;
  late final DateTime _nextMonth;
  late final DateTime _next3Month;

  @override
  void initState() {
    _homeViewModel = widget.homeViewModel;

    final now = DateTime.now();
    _nextWeek = now.add(const Duration(days: 7));
    _nextMonth = now.add(const Duration(days: 30));
    _next3Month = now.add(const Duration(days: 90));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final brightness = NotifierProvider.of<BrightnessController>(context);
    final dimens = Dimens.of(context);
    final producsList = _homeViewModel.sortByExpirationDate(sortOrder);

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
      drawer: AppDrawer(
        goToRegistrationsPage: _goToRegistrationsPage,
        goToProductsInput: _goToProductsInput,
        goToEmployees: _goToEmployees,
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
            ButtonsHeader(
              goToRegistrationsPage: _goToRegistrationsPage,
              goToEmployees: _goToEmployees,
            ),
            HomeHeaderRow(callBack: _revertOrder),
            ListView.builder(
              shrinkWrap: true,
              itemCount: producsList.length,
              itemBuilder: (context, index) {
                final product = producsList[index];
                final (String title, Color? color) = _setTitleAndColor(product);
                final userName =
                    _homeViewModel.getUserInfo(product.employeeId)?.name ?? '';
                final location =
                    _homeViewModel.getFreezer(product.freezerId)?.name ?? '';

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
                      CenterText(color: color, text: userName),
                      CenterText(color: color, text: location),
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

  (String, Color?) _setTitleAndColor(Product product) {
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

    bool isDark = Theme.of(context).brightness == Brightness.dark;

    Color? color;

    if (product.expirationDate.isBefore(_nextWeek)) {
      color = isDark ? Colors.redAccent : Colors.red;
    } else if (product.expirationDate.isBefore(_nextMonth)) {
      color = isDark ? Colors.orange : Colors.orange.shade600;
    } else if (product.expirationDate.isBefore(_next3Month)) {
      color = isDark ? Colors.yellow : Colors.amber.shade600;
    }

    return (title, color);
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
