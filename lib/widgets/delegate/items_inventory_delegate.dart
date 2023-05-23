part of 'delegates.dart';

class ItemsInventoryDelegate extends SearchDelegate {
  ProductsProvider productsProvider = ProductsProvider();
  @override
  final String searchFieldLabel;

  ItemsInventoryDelegate({required this.productsProvider})
      : searchFieldLabel = 'Buscar joya por nombre';
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(onPressed: () => query = '', icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () => close(context, null),
        icon: const Icon(Icons.arrow_back_ios));
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        top: 10.0,
        left: 10.0,
        right: 10.0,
      ),
      child: FutureBuilder(
        future: productsProvider.searchProductsByName(query),
        builder:
            (BuildContext context, AsyncSnapshot<List<ProductModel>> snapshot) {
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

          return GridView.count(
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
              ).toList());
        },
      ),
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
      future: productsProvider.getAllProducts(),
      builder:
          (BuildContext context, AsyncSnapshot<List<ProductModel>> snapshot) {
        if (!snapshot.hasData) {
          return simpleLoading();
        }
        if (snapshot.data!.isEmpty) {
          return const NoInformation(
            text: 'No hay productos en esta categoria',
            icon: Icons.info_outline,
            showButton: false,
            iconButton: Icons.add,
          );
        }

        return GridView.count(
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
            ).toList());
      },
    );
  }
}
