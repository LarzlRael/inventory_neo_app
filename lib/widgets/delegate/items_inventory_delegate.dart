part of 'delegates.dart';

class ItemsInventoryDelegate extends SearchDelegate {
  final productsService = ProductsServices();
  @override
  final String searchFieldLabel;

  ItemsInventoryDelegate() : searchFieldLabel = 'Buscar joya por nombre';
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(onPressed: () => query = '', icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    /* TODO return something */
    return IconButton(
        onPressed: () => close(context, null),
        icon: const Icon(Icons.arrow_back_ios));
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder(
      future: productsService.searchProductsByName(query),
      builder:
          (BuildContext context, AsyncSnapshot<List<ProductsModel>> snapshot) {
        if (!snapshot.hasData) {
          return simpleLoading();
        }
        if (snapshot.data!.isEmpty) {
          return const Expanded(
            child: NoInformation(
              text: 'No se encontraron resultados',
              icon: Icons.info_outline,
              showButton: false,
              iconButton: Icons.add,
            ),
          );
        }

        return Expanded(
          child: GridView.count(
              /* shrinkWrap: true, */
              /* physics: NeverScrollableScrollPhysics(), */
              /* padding: const EdgeInsets.all(10), */
              /* childAspectRatio: 3 / 2, */
              crossAxisCount: 2,
              children: snapshot.data!.map<Widget>(
                (product) {
                  return CardItemInventoryVertical(
                    productModel: product,
                  );
                },
              ).toList()),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return allProducts();
    } else {
      return allProducts();
    }
  }

  Widget allProducts() {
    return FutureBuilder(
      future: productsService.getAllProducts(),
      builder:
          (BuildContext context, AsyncSnapshot<List<ProductsModel>> snapshot) {
        if (!snapshot.hasData) {
          return simpleLoading();
        }
        if (snapshot.data!.isEmpty) {
          return const Expanded(
            child: NoInformation(
              text: 'No hay productos en esta categoria',
              icon: Icons.info_outline,
              showButton: false,
              iconButton: Icons.add,
            ),
          );
        }

        return Expanded(
          child: GridView.count(
              /* shrinkWrap: true, */
              /* physics: NeverScrollableScrollPhysics(), */
              /* padding: const EdgeInsets.all(10), */
              /* childAspectRatio: 3 / 2, */
              crossAxisCount: 2,
              children: snapshot.data!.map<Widget>(
                (product) {
                  return CardItemInventoryVertical(
                    productModel: product,
                  );
                },
              ).toList()),
        );
      },
    );
  }
}
