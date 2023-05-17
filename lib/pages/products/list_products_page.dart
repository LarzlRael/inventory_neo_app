part of '../pages.dart';

class ListProductsPage extends StatefulWidget {
  const ListProductsPage({super.key});

  @override
  State<ListProductsPage> createState() => _ListProductsPageState();
}

class _ListProductsPageState extends State<ListProductsPage> {
  late ProductsProvider productsProvider;
  @override
  void initState() {
    productsProvider = context.read<ProductsProvider>();
    productsProvider.fetchProductsAllProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    /* productBloc.getProducts(); */

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push('/add_product');
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBarWithBackIcon(
        appBar: AppBar(),
        title: 'Productos',
        subTitle: 'Lista de los productos',
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            color: Colors.black,
            onPressed: () {
              showSearch(
                context: context,
                delegate: ItemsInventoryDelegate(),
              );
            },
          ),
        ],
        showTitle: true,
      ),
      body: Column(
        children: [
          FutureBuilder(
            future: productsProvider.getCategories(),
            builder: (BuildContext context,
                AsyncSnapshot<List<ProductsModel>> snapshot) {
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
                child: GridView.builder(
                  /* shrinkWrap: true, */
                  /* physics: NeverScrollableScrollPhysics(), */
                  /* padding: const EdgeInsets.all(10), */
                  /* childAspectRatio: 3 / 2, */
                  /* crossAxisCount: 2,
                    children: snapshot.data!.map<Widget>(
                      (product) {
                        return CardItemInventoryVertical(
                          productModel: product,
                        );
                      },
                    ).toList()), */
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 250,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5,
                  ),
                  itemCount: snapshot.data?.length,
                  itemBuilder: (_, int index) {
                    return CardItemInventoryVertical(
                      productModel: snapshot.data![index],
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
