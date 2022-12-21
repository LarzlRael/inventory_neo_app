part of '../pages.dart';

class SellProducts extends StatelessWidget {
  const SellProducts({super.key});

  @override
  Widget build(BuildContext context) {
    final cardInventoryProvider =
        Provider.of<CardInventoryProvider>(context, listen: true);
    return Scaffold(
      appBar: AppBarWithBackIcon(
        appBar: AppBar(),
        title: 'Vender productos',
        showTitle: true,
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Text(
                'Productos Seleccionados: ${cardInventoryProvider.getListProductsId.length}'),
            FillButton(
                onPressed: () {
                  showBottomSheet(context, cardInventoryProvider);
                },
                label: 'Buscar productos'),
            FillButton(
                onPressed: () {
                  cardInventoryProvider.clearProducts();
                },
                label: 'Limpiar'),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: cardInventoryProvider.getProducts.length,
                itemBuilder: (_, index) {
                  final product = cardInventoryProvider.getProducts[index];
                  return CardItemInventory(
                    productModel: product,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  showBottomSheet(
      BuildContext context, CardInventoryProvider cardInventoryProvider) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return const CardInventorySelectableItems();
      },
    );
  }

  getProdutsId(List<ProductsModel> products) {
    if (products.isEmpty) return;
    products.map((e) => e.id).toList();
    final mapxd = {
      "line_items": products
          .map((e) => {
                "product_id": e.id,
                "quantity": 1,
              })
          .toList(),
    };
    debugPrint(mapxd.toString());
  }
}
