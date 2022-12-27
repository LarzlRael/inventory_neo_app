part of '../pages.dart';

class ListProductsPage extends StatelessWidget {
  const ListProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final productBloc = ProductsBloc();
    productBloc.getProducts();
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, 'add_product');
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
          StreamBuilder(
            stream: productBloc.productsStream,
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
