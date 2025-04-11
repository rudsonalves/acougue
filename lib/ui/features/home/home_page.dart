import 'package:acougue/domain/models/product.dart';
import 'package:flutter/material.dart';

import 'package:acougue/domain/enums/enums.dart';
import 'package:acougue/ui/features/home/widgets/home_header_row.dart';
import 'package:acougue/utils/extensions.dart';

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
        title: const Text('Home'),
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
                FilledButton(
                  onPressed: _goToRegistrationsPage,
                  child: const Text('Registros'),
                ),
                FilledButton(
                  onPressed: _goToProductsInput,
                  child: const Text('Adicionar Produto'),
                ),
                const FilledButton(
                  onPressed: null,
                  child: Text('Cadastrar Pessoas'),
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
                      Expanded(
                        child: CenterText(
                          color: color,
                          text: product.inputDate.toBrString(),
                        ),
                      ),
                      Expanded(
                        child: CenterText(
                          color: color,
                          text: product.expirationDate.toBrString(),
                        ),
                      ),
                      Expanded(
                        child: CenterText(
                          color: color,
                          text:
                              _homeViewModel
                                  .getUserInfo(product.employeeId)
                                  ?.name ??
                              '',
                        ),
                      ),
                      Expanded(
                        child: CenterText(
                          color: color,
                          text:
                              _homeViewModel
                                  .getFreezer(product.freezerId)
                                  ?.name ??
                              '',
                        ),
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

class CenterText extends StatelessWidget {
  final String text;
  final Color? color;

  const CenterText({super.key, required this.text, this.color});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        text,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(color: color),
      ),
    );
  }
}
