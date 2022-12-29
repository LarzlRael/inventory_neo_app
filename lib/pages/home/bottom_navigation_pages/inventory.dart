part of '../../pages.dart';

class Inventory extends StatelessWidget {
  Inventory({super.key});

  final pageViewController = PageController();

  @override
  Widget build(BuildContext context) {
    final inventoryProvider = Provider.of<CategoriesMaterialProviders>(context);
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SimpleText(
              top: 50,
              text: 'Busca tu ',
              fontSize: 25,
              fontWeight: FontWeight.w500,
            ),
            const SimpleText(
              text: 'Joya',
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
            searchBar(context),
            const SimpleText(
              top: 10,
              bottom: 10,
              text: 'Escoge \nuna categoria',
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  /* childAspectRatio: 3 / 2, */
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                ),
                itemCount: inventoryProvider.getCategories.length,
                itemBuilder: (BuildContext ctx, index) {
                  return CategoryCard(
                    categoriesModel: inventoryProvider.getCategories[index],
                  );
                },
              ),
            ),
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
          delegate: ItemsInventoryDelegate(),
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
  final CategoriesModel categoriesModel;
  final bool goToProductsByCategory;
  const CategoryCard({
    Key? key,
    required this.categoriesModel,
    this.goToProductsByCategory = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (goToProductsByCategory) {
          Navigator.pushNamed(
            context,
            'add_categories_page',
            arguments: CategoryForm(
              id: categoriesModel.id,
              name: categoriesModel.name,
              image: categoriesModel.image != null
                  ? categoriesModel.image!.src
                  : null,
            ),
          );
        } else {
          Navigator.pushNamed(
            context,
            'list_items_category',
            arguments: categoriesModel.id,
          );
        }
      },
      child: Container(
        width: 125,
        height: 125,
        margin: const EdgeInsets.only(right: 10),
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
                  child: SimpleText(
                    top: 10,
                    text: categoriesModel.name,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    lightThemeColor: Colors.white,
                  ),
                ),
              ],
            ),
            Positioned(
              top: -10,
              right: -5,
              child: Image.network(
                categoriesModel.image == null
                    ? 'https://thumbs.dreamstime.com/b/no-image-available-icon-flat-vector-no-image-available-icon-flat-vector-illustration-132482953.jpg'
                    : categoriesModel.image!.src,
                width: 100,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ListCategoryItems extends StatelessWidget {
  const ListCategoryItems({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments as int;
    return Scaffold(
      appBar: AppBarWithBackIcon(
        title: 'Productos',
        appBar: AppBar(),
        showTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              showSearch(
                context: context,
                delegate: ItemsInventoryDelegate(),
              );
            },
            color: Colors.black,
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: Column(
        children: [
          /*  CategoryCard(
            title: 'Anillos',
            urlImage:
                'https://i.pinimg.com/originals/56/37/66/56376681bea0c4135a00f87520e9d02e.png',
            color: Colors.blue,
          ), */
          FutureBuilder(
            future: getProductsByCategory(arguments),
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
          ),
        ],
      ),
    );
  }

  Future<List<ProductsModel>> getProductsByCategory(int category) async {
    final clientRequest = await getAction(
      'products?category=$category',
    );
    return productsModelFromJson(clientRequest!.body);
  }
}
