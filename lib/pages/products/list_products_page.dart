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
    final products = productsProvider.productsState;
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: MasonryGridView.count(
          physics: const BouncingScrollPhysics(),
          crossAxisCount: 2,
          mainAxisSpacing: 20,
          crossAxisSpacing: 35,
          itemCount: products.products.length,
          itemBuilder: (context, index) {
            final product = products.products[index];
            return CardItemInventoryVertical(
              productModel: product,
            );
          },
        ),
      ),
    );
  }
}
