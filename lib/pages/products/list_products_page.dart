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
    super.initState();
    productsProvider = context.read<ProductsProvider>();
    productsProvider.getProductsAllProducts();
  }

  @override
  Widget build(BuildContext context) {
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
      body: Consumer<ProductsProvider>(
        builder: (_, person, child) {
          final products2 = person.productsState;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: MasonryGridView.count(
              physics: const BouncingScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 20,
              crossAxisSpacing: 35,
              itemCount: products2.products.length,
              itemBuilder: (context, index) {
                final product = products2.products[index];
                return CardItemInventoryVertical(
                  productModel: product,
                );
              },
            ),
          );
        },
      ),
    );
  }
}
