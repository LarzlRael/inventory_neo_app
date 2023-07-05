part of '../../pages.dart';

class Inventory extends StatefulWidget {
  const Inventory({super.key});

  @override
  State<Inventory> createState() => _InventoryState();
}

class _InventoryState extends State<Inventory> {
  bool isLoading = false;
  late CategoriesMaterialProviders inventoryProvider;
  @override
  void initState() {
    super.initState();
    inventoryProvider = context.read<CategoriesMaterialProviders>();
    inventoryProvider.getFetchCategories();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40),
            Text(
              /* top: 50, */
              'Busca tu \nJoya',
              style: textTheme.titleSmall!.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
            searchBar(context),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 10,
              ),
              child: Text(
                'Escoge \nuna categoria',
                style: textTheme.titleSmall!.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
            Consumer<CategoriesMaterialProviders>(
                builder: (_, categoriesMaterialProviders, __) {
              final categories = categoriesMaterialProviders.categoriesState;

              return categories.isLoading
                  ? simpleLoading()
                  : Expanded(
                      child: AlignedGridView.count(
                        crossAxisCount: 2,
                        mainAxisSpacing: 2,
                        crossAxisSpacing: 2,
                        itemCount: categories.categoriesList.length,
                        itemBuilder: (_, index) => CategoryCard(
                          categoriesModel: categories.categoriesList[index],
                        ),
                      ),
                    );
            })
          ],
        ),
      ),
    );
  }

  Widget searchBar(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showSearch(
          context: context,
          delegate: ItemsInventoryDelegate(
            productsProvider: context.read<ProductsProvider>(),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(
          bottom: 30,
          top: 30,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            SimpleText(text: 'Buscar un producto...'),
            Icon(Icons.search),
          ],
        ),
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final CategorieModel categoriesModel;
  final bool goToProductsByCategory;
  const CategoryCard({
    Key? key,
    required this.categoriesModel,
    this.goToProductsByCategory = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (goToProductsByCategory) {
          context.push(
            '/add_categories_page',
            extra: CategoryForm(
              id: categoriesModel.id,
              name: categoriesModel.name,
              image: categoriesModel.image != null
                  ? categoriesModel.image!.src
                  : null,
            ),
          );
        } else {
          context.push(
            '/list_category_items',
            extra: CategoryTitle(
              categoryId: categoriesModel.id,
              title: categoriesModel.name,
            ),
          );
        }
      },
      child: Container(
        /* width: 125, */
        height: 175,
        margin: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          /* hex color */
          /* color: const Color(0xffff7648), */
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Stack(
          children: [
            Stack(
              children: [
                Container(
                  margin: const EdgeInsets.only(
                    top: 20,
                    right: 10,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.blue,
                  ),
                ),
                Positioned(
                  bottom: 10,
                  left: 10,
                  child: Hero(
                    tag: categoriesModel.name,
                    child: SimpleText(
                      padding: const EdgeInsets.only(top: 10),
                      text: categoriesModel.name,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              top: -10,
              right: -5,
              child: FadeInImage(
                placeholder:
                    const AssetImage('assets/loaders/bottle-loader.gif'),
                image: NetworkImage(
                  categoriesModel.image == null
                      ? 'https://thumbs.dreamstime.com/b/no-image-available-icon-flat-vector-no-image-available-icon-flat-vector-illustration-132482953.jpg'
                      : categoriesModel.image!.src,
                ),
                width: 100,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CategoryTitle {
  final String title;
  final int categoryId;
  const CategoryTitle({required this.title, required this.categoryId});
}

class ListCategoryItems extends StatelessWidget {
  final CategoryTitle categoryTitle;
  const ListCategoryItems({super.key, required this.categoryTitle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWithBackIcon(
        title: categoryTitle.title,
        appBar: AppBar(),
        showTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              showSearch(
                context: context,
                delegate: ItemsInventoryDelegate(
                  productsProvider: context.read<ProductsProvider>(),
                ),
              );
            },
            color: Colors.black,
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: Column(
        children: [
          FutureBuilder(
            future: getProductsByCategory(categoryTitle.categoryId),
            builder: (BuildContext context,
                AsyncSnapshot<List<ProductModel>> snapshot) {
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

              final products = snapshot.data;
              return Expanded(
                child: AlignedGridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 1,
                  crossAxisSpacing: 1,
                  itemCount: products!.length,
                  itemBuilder: (context, index) => CardItemInventoryVertical(
                    productModel: products[index],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Future<List<ProductModel>> getProductsByCategory(int category) async {
    final clientRequest = await getAction(
      'products?category=$category',
    );
    return productsModelFromJson(clientRequest!.body);
  }
}
