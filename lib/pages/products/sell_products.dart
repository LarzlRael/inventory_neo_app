part of '../pages.dart';

class SellProducts extends StatefulWidget {
  const SellProducts({super.key});

  @override
  State<SellProducts> createState() => _SellProductsState();
}

class _SellProductsState extends State<SellProducts> {
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    final cardInventoryProvider =
        Provider.of<CardInventoryProvider>(context, listen: true);
    final clientSelect = cardInventoryProvider.getClient != null;
    return Scaffold(
      appBar: AppBarWithBackIcon(
        appBar: AppBar(),
        title: 'Vender productos',
        showTitle: true,
        actions: [
          IconButton(
            tooltip: 'Limpiar',
            icon: const Icon(Icons.delete),
            color: Colors.black,
            onPressed: () {
              cardInventoryProvider.clearProducts();
            },
          ),
          cardInventoryProvider.getProducts.isNotEmpty &&
                  cardInventoryProvider.getClient != null
              ? IconButton(
                  tooltip: 'Confirmar venta',
                  icon: const Icon(Icons.check_circle),
                  color: Colors.green,
                  onPressed: () {
                    sendData(cardInventoryProvider);
                  },
                )
              : const SizedBox(),
        ],
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Text(
              'Productos Seleccionados: ${cardInventoryProvider.getProducts.length}',
            ),

            /*  FillButton(
                onPressed: () {
                  cardInventoryProvider.clearProducts();
                },
                label: 'Limpiar'), */
            _isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Column(
                    children: [
                      FillButton(
                        onPressed: () {
                          showBottomFindClientSheet(
                              context, cardInventoryProvider);
                        },
                        backgroundColor:
                            clientSelect ? Colors.orange : Colors.blue,
                        label:
                            clientSelect ? 'Cambiar cliente' : 'Buscar cliente',
                      ),
                      FillButton(
                        onPressed: () {
                          showBottomSheet(context, cardInventoryProvider);
                        },
                        label: 'Buscar productos',
                      ),
                    ],
                  ),
            const SizedBox(height: 20),
            cardInventoryProvider.getClient != null
                ? ClientItem(
                    clientModel: cardInventoryProvider.getClient!,
                  )
                : const SizedBox(),
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

  Map<String, dynamic> getProdutsId(List<ProductsModel> products) {
    if (products.isEmpty) {
      return {};
    }
    products.map((e) => e.id).toList();
    return {
      "line_items": products
          .map((e) => {
                "product_id": e.id,
                "quantity": 1,
              })
          .toList(),
    };
  }

  showBottomFindClientSheet(
      BuildContext context, CardInventoryProvider cardInventoryProvider) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
            height: MediaQuery.of(context).size.height * 0.8,
            child: const ClientsPageSelectable());
      },
    );
  }

  sendData(CardInventoryProvider cardInventoryProvider) async {
    final data = {
      "payment_method": "bacs",
      "payment_method_title": "Direct Bank Transfer",
      "set_paid": true,
      "billing": {
        "first_name": cardInventoryProvider.getClient!.firstName,
        "last_name": cardInventoryProvider.getClient!.lastName,
        "address_1": cardInventoryProvider.getClient!.billing.address1,
        "address_2": "",
        "city": "San Francisco",
        "state": "CA",
        "postcode": "94103",
        "country": "US",
        "email": cardInventoryProvider.getClient!.email,
        "phone": "(555) 555-5555"
      },
      ...getProdutsId(cardInventoryProvider.getProducts)
    };
    setState(() {
      _isLoading = true;
    });
    final result = await postAction('orders', data);
    setState(() {
      _isLoading = false;
    });
    if (validateStatus(result?.statusCode)) {
      cardInventoryProvider.clearProducts();

      GlobalSnackBar.show(context, "Venta realizada con exito",
          backgroundColor: Colors.green);
      Navigator.pushNamed(context, 'sell_history');
    } else {
      GlobalSnackBar.show(context, "Error al realizar la venta",
          backgroundColor: Colors.red);
      setState(() {
        _isLoading = true;
      });
    }
  }
}
