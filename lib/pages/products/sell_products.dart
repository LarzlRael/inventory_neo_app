part of '../pages.dart';

class SellProducts extends StatelessWidget {
  const SellProducts({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWithBackIcon(
        appBar: AppBar(),
        title: 'Vender productos',
        showTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          FillButton(
              onPressed: () {
                showBottomSheet(context);
              },
              label: 'Buscar productos'),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  showBottomSheet(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return const CardInventorySelectableItems();
      },
    );
  }
}
