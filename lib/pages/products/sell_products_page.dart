part of '../pages.dart';

class SellProductsPage extends StatefulWidget {
  const SellProductsPage({super.key});

  @override
  State<SellProductsPage> createState() => _SellProductsPageState();
}

class _SellProductsPageState extends State<SellProductsPage> {
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    final cardInventoryProvider =
        Provider.of<CardInventoryProvider>(context, listen: true);
    final clientSelect = cardInventoryProvider.getClient != null;
    final productsSelect = cardInventoryProvider.getProducts.isEmpty;
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
            SimpleText(
              text:
                  'Productos Seleccionados: ${cardInventoryProvider.getProducts.length}',
              fontSize: 16,
              fontWeight: FontWeight.w600,
              bottom: 5,
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
                        label: clientSelect
                            ? 'Cambiar cliente'
                            : 'Seleccionar cliente',
                      ),
                      FillButton(
                        onPressed: () {
                          showBottomSheet(context, cardInventoryProvider);
                        },
                        label: productsSelect
                            ? 'Buscar productos'
                            : 'Cambiar productos',
                        backgroundColor:
                            !productsSelect ? Colors.orange : Colors.blue,
                      ),
                    ],
                  ),
            const SizedBox(height: 20),
            cardInventoryProvider.getClient != null
                ? Column(
                    children: [
                      const SimpleText(
                        text: 'Cliente',
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        bottom: 0,
                      ),
                      ClientItem(
                        clientModel: cardInventoryProvider.getClient!,
                        trailing: IconButton(
                          icon: const Icon(
                            Icons.cancel_rounded,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            cardInventoryProvider.clearClient();
                          },
                        ),
                      ),
                    ],
                  )
                : const SimpleText(
                    text: 'Selecciona un cliente',
                  ),
            cardInventoryProvider.getProducts.isNotEmpty
                ? Expanded(
                    child: ListView.builder(
                      itemCount: cardInventoryProvider.getProducts.length,
                      itemBuilder: (_, index) {
                        final product =
                            cardInventoryProvider.getProducts[index];
                        return CardItemInventory(
                          productModel: product,
                        );
                      },
                    ),
                  )
                : const SimpleText(
                    text:
                        'Selecciona productos, para agregarlos a la lista de venta',
                    top: 20,
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
        return SizedBox(
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
        "address_1": cardInventoryProvider.getClient!.address1,
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
    if (!mounted) return;
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