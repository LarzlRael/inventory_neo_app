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
      floatingActionButton: FloatingActionButton.extended(
        label: const Text('Nuevo producto'),
        onPressed: () {
          context.push('/add_product');
        },
        icon: const Icon(Icons.add),
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
                delegate: ItemsInventoryDelegate(
                  productsProvider: productsProvider,
                ),
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
            child: products2.products.isEmpty
                ? NoInformation(
                    icon: Icons.inventory,
                    text: 'No hay productos registrados',
                    showButton: true,
                    buttonText: 'Agregar producto',
                    onPressed: () {
                      context.push('/add_product');
                    },
                    iconButton: Icons.add,
                  )
                : MasonryGridView.count(
                    physics: const BouncingScrollPhysics(),
                    crossAxisCount: 2,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 35,
                    itemCount: products2.products.length,
                    itemBuilder: (context, index) {
                      return CardItemInventoryVertical(
                        productModel: products2.products[index],
                        onTap: (productModel) {
                          /* context.push('/item_detail',
                              extra: products2.products[index]); */
                          context.push(
                            '/item_detail',
                            extra: productModel.id,
                          );
                        },
                      );
                    },
                  ),
          );
        },
      ),
    );
  }
}
